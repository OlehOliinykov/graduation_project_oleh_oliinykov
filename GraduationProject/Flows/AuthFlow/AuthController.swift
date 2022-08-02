//
//  ViewController.swift
//  GraduationProject
//
//  Created by Олег Олейников on 25.12.2021.
//

import UIKit

class AuthController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var topSignInConstraint: NSLayoutConstraint!
    
    private let textFieldInset: CGFloat = 16
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animatedElements()
    }

    private func style() {
        signUpButton.alpha = 0
        signInButton.alpha = 0
        signUpButton.layer.cornerRadius = 16
        signInButton.layer.cornerRadius = 16
        topSignInConstraint.constant += self.view.bounds.height
    }
    
    private func animatedElements() {
        topSignInConstraint.constant = textFieldInset
        UIView.animate(withDuration: 0.6) { [weak self] in
            self?.view.layoutIfNeeded()
        }
        UIView.animate(withDuration: 0.6) { [weak self] in
            self?.signInButton.alpha = 1
        }
        UIView.animate(withDuration: 0.6) { [weak self] in
            self?.signUpButton.alpha = 1
        }
    }
}

