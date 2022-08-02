//
//  SignInController.swift
//  GraduationProject
//
//  Created by Олег Олейников on 25.12.2021.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class SignInController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
 
    @IBAction func sighInTapped() {
        let email = loginTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print(error)
            } else {
                self.showModalAuth()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        addTarget()
    }

    private func style() {
        loginTextField.layer.cornerRadius = 16
        passwordTextField.layer.cornerRadius = 16
        signInButton.layer.cornerRadius = 16
        signUpButton.layer.cornerRadius = 16
    }
    
    func addTarget() {
        loginTextField.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged)
    }
    
    @objc private func textFieldsIsNotEmpty(sender: UITextField) {
        
        sender.text = sender.text?.trimmingCharacters(in: .whitespaces)
        
        guard let login = loginTextField.text, !login.isEmpty,
        let password = passwordTextField.text, !password.isEmpty
        else {
            self.signInButton.isEnabled = false
            return
        }
        
        signInButton.isEnabled = true
    }
    
    func showModalAuth() {
        let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
        let newVc: UIViewController = storyboard.instantiateViewController(withIdentifier: "TabBar") 
        present(newVc, animated: true, completion: nil)
    }
    
}
