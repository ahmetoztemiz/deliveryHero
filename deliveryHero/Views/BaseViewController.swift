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
    
    //MARK: - PROPERTIES
    
    
    //MARK: - FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        setLoadingIndicator()
        hideKeyboardWhenTappedAround()
    }

    private func setLoadingIndicator() {
        view.addSubview(indicator)
    }
    
    func configureNavigationBar(title: String) {
        self.title = title
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.textColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.textColor]
    }

    func showIndicator(_ isLoading: Bool) {
        if isLoading {
            self.indicator.startAnimating()
        } else {
            self.indicator.stopAnimating()
        }
        
        self.view.isUserInteractionEnabled = !isLoading
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
