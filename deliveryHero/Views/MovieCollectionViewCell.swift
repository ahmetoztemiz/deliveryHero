//
//  MovieCollectionViewCell.swift
//  deliveryHero
//
//  Created by Ahmet Öztemiz on 8.07.2022.
//

import Foundation
import UIKit
import SnapKit

final class MovieCollectionViewCell: UICollectionViewCell {
    
    lazy var containerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        stackView.layer.cornerRadius = 10
        stackView.alignment = .center
        stackView.backgroundColor = UIColor.cellBackgroundColor
        
        return stackView
    }()
    
    lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.cellTextColor
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textAlignment = .center
        label.numberOfLines = 2
        
        return label
    }()
    
    var cellId: NSString?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImageView(url: String) {
        movieImageView.image = .waitIcon
        let imageURL = urlParameters.imageBase.rawValue + url
        movieImageView.downloaded(from: imageURL, cacheId: cellId) { [weak self] image, cacheId in
            if let cellId = self?.cellId, cacheId == cellId {
                self?.movieImageView.image = image
            }
        }
    }
    
    private func configureCell() {
        containerView.addArrangedSubview(movieImageView)
        containerView.addArrangedSubview(titleLabel)
        self.contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(self.contentView).inset(5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(70)
            make.leading.trailing.equalTo(self.containerView).inset(2)
        }
        
        movieImageView.snp.makeConstraints { make in
            make.trailing.leading.top.equalTo(self.containerView).inset(3)
        }
    }
}

