//
//  LoginViewController.swift
//  Karoooo
//
//  Created by Raghvendra Pacholi on 17/12/22.
//

import Foundation
import UIKit
import GCCountryPicker
import AnimatedField

class LoginViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var usernameTextField: AnimatedField!
    @IBOutlet weak var loginErrorMessageLabel: UILabel!
    @IBOutlet weak var passwordTextField: AnimatedField!
    @IBOutlet weak var countryTextField: AnimatedField!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: Properties
    private var loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    // MARK: Methods
    // Comments: Method to perform initial setup for view.
    private func setup() {
        
        var format = AnimatedFieldFormat()
        format.alertColor = .red
        format.alertFieldActive = false
        format.titleAlwaysVisible = true
        
        usernameTextField.format = format
        usernameTextField.placeholder = "Write your username(min.)"
        usernameTextField.type = .username(6, 20)
        usernameTextField.delegate = self
        usernameTextField.tag = 0
        
        passwordTextField.format = format
        passwordTextField.placeholder = "Enter password"
        passwordTextField.type = .password(6, 20)
        passwordTextField.isSecure = true
        passwordTextField.delegate = self
        passwordTextField.showVisibleButton = true
        passwordTextField.tag = 1
        
        countryTextField.placeholder = "Select Country"
        
        countryTextField.format = format
        countryTextField.placeholder = "Select country"
        countryTextField.delegate = self
        countryTextField.tag = 2
        
        self.loginErrorMessageLabel.isHidden = true
        self.loginErrorMessageLabel.textColor = .red
    }
    
    
    @IBAction func LoginButtonPressed(_ sender: Any) {
        
        loginViewModel.checkLogin(username: usernameTextField.text, password: passwordTextField.text, country: countryTextField.text) { result in
            switch result {
            case .success :
                let usersListViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "UsersListViewControllerIdentifier") as? UsersListViewController
                self.navigationController?.pushViewController(usersListViewControllerObj!, animated: true)
                
            case .failure(let errorMessage) :
                self.loginErrorMessageLabel.text = errorMessage.rawValue
                self.loginErrorMessageLabel.isHidden = false
                
            }
        }
    }
}


extension LoginViewController: AnimatedFieldDelegate {
    
    // MARK: Delegates
    func animatedFieldDidBeginEditing(_ animatedField: AnimatedField) {
        
        self.loginErrorMessageLabel.isHidden = true
        if animatedField == countryTextField {
            let countryPickerViewController = GCCountryPickerViewController(displayMode: .withoutCallingCodes)
            
            countryPickerViewController.delegate = self
            countryPickerViewController.navigationItem.title = NSLocalizedString("Countries", comment: "")
            
            let navigationController = UINavigationController(rootViewController: countryPickerViewController)
            
            self.present(navigationController, animated: true, completion: nil)
        }
        
    }
    
}

extension LoginViewController : GCCountryPickerDelegate {
    // MARK: Delegates
    func countryPickerDidCancel(_ countryPicker: GCCountryPicker.GCCountryPickerViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func countryPicker(_ countryPicker: GCCountryPicker.GCCountryPickerViewController, didSelectCountry country: GCCountryPicker.GCCountry) {
        
        self.countryTextField.text = country.localizedDisplayName
        self.dismiss(animated: true, completion: nil)
    }
}
