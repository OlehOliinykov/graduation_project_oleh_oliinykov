//
//  ProfileController.swift
//  GraduationProject
//
//  Created by Олег Олейников on 25.12.2021.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class ProfileController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
    }
    
    private func style() {
        emailTextField.layer.cornerRadius = 16
        nameTextField.layer.cornerRadius = 16
        surnameTextField.layer.cornerRadius = 16
        bioTextView.layer.cornerRadius = 16
        editButton.layer.cornerRadius = 16
        saveButton.layer.cornerRadius = 16
    }
    
    @IBAction func editMode(_ sender: UIButton) {
        emailTextField.isUserInteractionEnabled = true
        nameTextField.isUserInteractionEnabled = true
        surnameTextField.isUserInteractionEnabled = true
        bioTextView.isUserInteractionEnabled = true
        editButton.isHidden = true
        saveButton.isHidden = false
    }
    
    @IBAction func saveMode(_ sender: UIButton) {
        emailTextField.isUserInteractionEnabled = false
        nameTextField.isUserInteractionEnabled = false
        surnameTextField.isUserInteractionEnabled = false
        bioTextView.isUserInteractionEnabled = false
        editButton.isHidden = false
        saveButton.isHidden = true
    }
    
    
    @IBAction func logOutTapped(_ sender: UIBarButtonItem) {
/*        let alert = UIAlertController(title: "", message: "Are you sure you want to Log out?", preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "No", style: .cancel)
        let logOutButton = UIAlertAction(title: "Yes", style: .default, handler: { [weak self] action in
            self?.dismiss(animated: true, completion: nil)
        })
        
        alert.addAction(cancelButton)
        alert.addAction(logOutButton)
        present(alert, animated: true)
*/
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
    
}

