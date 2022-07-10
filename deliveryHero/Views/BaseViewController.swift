//
//  BaseViewController.swift
//  deliveryHero
//
//  Created by Ahmet Öztemiz on 8.07.2022.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    //MARK: - VIEW
    lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = UIColor.indicatorColor
        indicator.transform = CGAffineTransform(scaleX: 2, y: 2)
        indicator.hidesWhenStopped = true
        indicator.center = view.center

        return indicator
    }()
    
    lazy var emptyStateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .emptyIcon

        return imageView
    }()
    
    lazy var emptyStatleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.textColor
        label.minimumScaleFactor = 0.4
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.numberOfLines = 3
        label.text = Constants.Text.noResultError
        
        return label
    }()
    
    lazy var emptyStateContainerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 2
        stackView.addArrangedSubview(emptyStateImageView)
        stackView.addArrangedSubview(emptyStatleLabel)
        stackView.isHidden = true
        
        return stackView
    }()
    
    //MARK: - PROPERTIES
    
    
    //MARK: - FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        hideKeyboardWhenTappedAround()
    }
    
    private func setConstraints() {
        view.addSubview(indicator)
        
        view.insertSubview(emptyStateContainerView, belowSubview: indicator)
        emptyStateContainerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(view.bounds.width)
            make.height.equalTo(300)
        }
    }
    
    func configureNavigationBar(title: String) {
        self.title = title
        self.navigationController?.navigationBar.tintColor = UIColor.textColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.textColor]
        self.view.backgroundColor = UIColor.backgroundColor
        self.view.tintColor = UIColor.iconColor
    }

    func showIndicator(_ isLoading: Bool) {
        if isLoading {
            self.indicator.startAnimating()
        } else {
            self.indicator.stopAnimating()
        }
        
        self.view.isUserInteractionEnabled = !isLoading
    }
    
    func showEmptyState(_ isEmpty: Bool) {
        emptyStateContainerView.isHidden = !isEmpty
    }
    
    func setAlertView(title: String,
                      message: String? = nil,
                      cancelButton: String,
                      confirmButton: String? = nil,
                      actionHandler: @escaping () -> ()) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: cancelButton, style: .cancel))
        
        if let buttonText = confirmButton {
            alert.addAction(UIAlertAction(title: buttonText, style: .default, handler: { action in
                actionHandler()
            }))
        }
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        gestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
