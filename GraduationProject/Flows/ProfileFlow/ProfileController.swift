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
import CoreLocation
import CoreLocationUI
import Locksmith

class ProfileController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var latitudeLocationLabel: UILabel!
    @IBOutlet weak var longitudeLocationLabel: UILabel!
    @IBOutlet weak var lastLocationButton: CLLocationButton!
    
    let coreLocationManager = CLLocationManager()
    let defaults = UserDefaults.standard
    
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
        let alert = UIAlertController(title: "Log Out", message: "Are you sure you want to Log out?", preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "No", style: .cancel)
        let logOutButton = UIAlertAction(title: "Yes", style: .default, handler: { [weak self] action in
            self?.dismiss(animated: true, completion: nil)
            do {
                try Auth.auth().signOut()
            } catch {
                print(error)
            }
        })
        
        alert.addAction(cancelButton)
        alert.addAction(logOutButton)
        present(alert, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        coreLocationManager.delegate = self
        addTargetFunc()
        userInfo()
        style()
    }
    
    func userInfo() {
        let dictionary = Locksmith.loadDataForUserAccount(userAccount: "MyAccount")
        let email = dictionary?["Email"] as? String
        
        if let result = email {
            emailTextField.text = "\(result)"
        } else {
            print("Error")
        }
    }
    
    private func addTargetFunc() {
        lastLocationButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc func didTapButton() {
        coreLocationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.coreLocationManager.stopUpdatingLocation()
        print(locations)
        latitudeLocationLabel.text = "latitude: \(location.coordinate.latitude)"
        longitudeLocationLabel.text = "longitude: \(location.coordinate.longitude)"
    }
    
    private func style() {
        emailTextField.layer.cornerRadius = 16
        nameTextField.layer.cornerRadius = 16
        surnameTextField.layer.cornerRadius = 16
        bioTextView.layer.cornerRadius = 16
        editButton.layer.cornerRadius = 16
        saveButton.layer.cornerRadius = 16
    }
    
}
