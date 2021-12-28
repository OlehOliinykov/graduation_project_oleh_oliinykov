//
//  SignInController.swift
//  GraduationProject
//
//  Created by Олег Олейников on 25.12.2021.
//

import Foundation
import UIKit

class SignInController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        loginTextField.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged)
    }

    private func style() {
        loginTextField.layer.cornerRadius = 16
        passwordTextField.layer.cornerRadius = 16
        signInButton.layer.cornerRadius = 16
        signUpButton.layer.cornerRadius = 16
    }
    
    @objc func textFieldsIsNotEmpty(sender: UITextField) {
        
        sender.text = sender.text?.trimmingCharacters(in: .whitespaces)
        
        guard let login = loginTextField.text, !login.isEmpty,
        let password = passwordTextField.text, !password.isEmpty
        else {
            self.signInButton.isEnabled = false
            return
        }
        
        signInButton.isEnabled = true
    
    }

}
