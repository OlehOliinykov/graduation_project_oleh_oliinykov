//
//  RegController.swift
//  GraduationProject
//
//  Created by Олег Олейников on 25.12.2021.
//

import Foundation
import UIKit
import SwiftUI
import Locksmith
import Firebase
import FirebaseAuth
import FirebaseDatabase
import CoreData
import FirebaseCore

class RegController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var familyNameTextField: UITextField!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var emailMessageLabel: UILabel!
    @IBOutlet weak var agreementSwitch: UISwitch!
    @IBOutlet weak var nameMessageLabel: UILabel!
    @IBOutlet weak var familyNameMessageLabel: UILabel!
    
    let emailValidType: String.ValidTypes = .email
    let passwordValidType: String.ValidTypes = .password
    let nameValidType: String.ValidTypes = .name
    let familyNameValidType: String.ValidTypes = .familyName
   
    @IBAction func agreementSwitchTapped(_ sender: UISwitch) {
        if (emailMessageLabel.text == "Valid email") && (messageLabel.text == "Valid password") && (nameMessageLabel.text == "Valid name") && (familyNameMessageLabel.text == "Valid family name") {
            saveButton.isEnabled = agreementSwitch.isOn
        } else {
            saveButton.isEnabled = false
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        let name = nameTextField.text ?? ""
        let familyName = familyNameTextField.text ?? ""
        let userEmail = loginTextField.text ?? ""
        let userPassword = passwordTextField.text ?? ""
        
        UserDefault.shared.saveUser(firstName: name, familyName: familyName)
        
        if let email = loginTextField.text, let password = passwordTextField.text {
            do {
                try Locksmith.updateData(data: ["Email" : email, "Password" : password], forUserAccount: "MyAccount")
                try Locksmith.saveData(data: ["Email" : email, "Password" : password], forUserAccount: "MyAccount")
            } catch {
                print("Unable to save data")
            }
        }

        Auth.auth().createUser(withEmail: userEmail, password: userPassword) { result, error in
            if let error = error {
                print(error)
            }
            guard let result = result else { return }
            print(result.user.uid)
            let ref = Database.database().reference()
            ref.child(result.user.uid).updateChildValues(["name": name, "email": userEmail])
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMessageLabel()
        setupDelegateForTextField()
        style()
    }
    
    func setupMessageLabel() {
        messageLabel.numberOfLines = 0
        emailMessageLabel.numberOfLines = 0
        nameMessageLabel.numberOfLines = 0
        familyNameMessageLabel.numberOfLines = 0
    }
        
    private func style() {
        nameTextField.layer.cornerRadius = 16
        familyNameTextField.layer.cornerRadius = 16
        loginTextField.layer.cornerRadius = 16
        passwordTextField.layer.cornerRadius = 16
        saveButton.layer.cornerRadius = 16
        signInButton.layer.cornerRadius = 16
    }
    func setupDelegateForTextField() {
        nameTextField.delegate = self
        familyNameTextField.delegate = self
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }
                
    private func setTextField(textField: UITextField, label: UILabel, validType: String.ValidTypes, validMessage: String, invalidMessage: String, string: String, range: NSRange) {
        
        let text = (textField.text ?? "") + string
        let result: String
        
        if range.length == 1 {
            let end = text.index(text.startIndex, offsetBy: text.count - 1)
            result = String(text[text.startIndex..<end])
        } else {
            result = text
        }
        
        textField.text = result
        
        if result.isValid(validType: validType) {
            label.text = validMessage
        } else {
            label.text = invalidMessage
        }
    }
}

extension RegController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case loginTextField:
            setTextField(textField: loginTextField,
                         label: emailMessageLabel,
                         validType: emailValidType,
                         validMessage: "Valid email",
                         invalidMessage: "Invalid email",
                         string: string,
                         range: range)
        case passwordTextField:
            setTextField(textField: passwordTextField,
                         label: messageLabel,
                         validType: passwordValidType,
                         validMessage: "Valid password",
                         invalidMessage: "Invalid password",
                         string: string,
                         range: range)
        case nameTextField:
            setTextField(textField: nameTextField,
                         label: nameMessageLabel,
                         validType: nameValidType,
                         validMessage: "Valid name",
                         invalidMessage: "Invalid name",
                         string: string,
                         range: range)
        case familyNameTextField:
            setTextField(textField: familyNameTextField,
                         label: familyNameMessageLabel,
                         validType: familyNameValidType,
                         validMessage: "Valid family name",
                         invalidMessage: "Invalid family name",
                         string: string,
                         range: range)
        default:
            break
        }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

