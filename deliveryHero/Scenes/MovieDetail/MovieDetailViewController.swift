//
//  MovieDetailViewController.swift
//  deliveryHero
//
//  Created by Ahmet Öztemiz on 8.07.2022.
//

import Foundation
import UIKit

final class MovieDetailViewController: BaseViewController {

    //MARK: - VIEW
    lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.cellBackgroundColor.cgColor
        
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.textColor
        label.minimumScaleFactor = 0.4
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 3
        
        return label
    }()
    
    lazy var voteLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.textColor
        label.minimumScaleFactor = 0.4
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 3
        
        return label
    }()
    
    lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.textColor
        label.minimumScaleFactor = 0.4
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 3
        
        return label
    }()
    
    lazy var definationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.textColor
        label.minimumScaleFactor = 0.4
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var castTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
        tableView.isHidden = true
        
        let cellId = String(describing: "CastCellViewCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        return tableView
    }()
    
    lazy var infoContainerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 10
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(voteLabel)
        stackView.addArrangedSubview(releaseDateLabel)
        
        return stackView
    }()
    
    lazy var headerContainerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 5
        stackView.addArrangedSubview(posterImageView)
        stackView.addArrangedSubview(infoContainerView)
        
        return stackView
    }()
    
    //MARK: - PROPERTIES
    var presenter: MovieDetailPresenterProtocol!
    private var movieData: MediaDetailPresentationModel?
    private var castList: [CastPresentationModel]?
    
    //MARK: - FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewConstraints()
        presenter.loadData()
    }
    
    
    private func setViewConstraints() {
        view.insertSubview(headerContainerView, belowSubview: indicator)
        view.insertSubview(definationLabel, belowSubview: indicator)
        view.insertSubview(castTableView, belowSubview: indicator)
        
        posterImageView.snp.makeConstraints { make in
            make.height.equalTo(190)
            make.width.equalTo(120)
        }
        
        headerContainerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(10)
        }
        
        definationLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(headerContainerView.snp.bottom).offset(10)
        }
        
        castTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(definationLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
    private func setMovieData() {
        setImageView()
        setInfoText()
        configureNavigationBar(title: Constants.Text.detail)
    }
    
    private func setCastData() {
        castTableView.isHidden = (castList?.isEmpty ?? true) ? true : false
        castTableView.reloadData()
    }
    
    private func setImageView() {
        guard let data = movieData else { return }
        let url = urlParameters.imageBase.rawValue + data.imagePath
        let id = NSString(string: data.id)
        
        posterImageView.downloaded(from: url, cacheId: id) { [weak self] image, cacheId in
            if cacheId == id {
                self?.posterImageView.image = image
            }
        }
    }
    
    private func setInfoText() {
        guard let data = movieData else { return }
        titleLabel.text = data.title
        voteLabel.text = String(format: Constants.Text.vote, data.vote)
        releaseDateLabel.text = String(format: Constants.Text.releaseYear, data.releaseYear)
        definationLabel.text = data.defination
    }
}

//MARK: - DISPLAY LOGIC FUNCTIONS
extension MovieDetailViewController: MovieDetailViewProtocol {
    func handleOutput(_ output: MovieDetailPresenterOutput) {
        switch output {
        case .setLoading(let bool):
            DispatchQueue.main.async {
                self.showIndicator(bool)
            }
        case .showData(let data):
            movieData = data
            setMovieData()
        case .showCastData(let data):
            DispatchQueue.main.async {
                self.castList = data
                self.setCastData()
            }
        }
    }
}

//MARK: - TABLE VIEW FUNCTIONS
extension MovieDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return castList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Constants.Text.actors
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = String(describing: "CastCellViewCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let actor = castList?[indexPath.row]
        
        cell.selectionStyle = .none
        cell.textLabel?.text = actor?.name
        
        return cell
    }
}

extension MovieDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectActor(at: indexPath.row)
    }
}
