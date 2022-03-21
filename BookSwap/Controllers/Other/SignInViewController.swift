//
//  SignInViewController.swift
//  BookSwap
//
//  Created by Shivani Vora on 3/17/22.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {

    private let headerView = SignInHeaderView()
    
    private let emailField: BATextField = {
        let field = BATextField()
        field.placeholder = "Email Address"
        field.keyboardType = .emailAddress
        field.returnKeyType = .next
        field.autocorrectionType = .no
        return field
    }()
    
    private let passwordField: BATextField = {
        let field = BATextField()
        field.placeholder = "Password"
        field.isSecureTextEntry = true
        field.keyboardType = .default
        field.returnKeyType = .continue
        field.autocorrectionType = .no
        return field
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.link, for: .normal)
        button.setTitle("Create Account", for: .normal)
        return button
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.link, for: .normal)
        button.setTitle("Terms and Conditions", for: .normal)
        return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.link, for: .normal)
        button.setTitle("Privacy Policy", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign In"
        view.backgroundColor = .systemBackground
        addSubviews()
        
        emailField.delegate = self
        passwordField.delegate = self
        addButtonActions()
    }
    
    private func addSubviews() {
        view.addSubview(headerView)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signInButton)
        view.addSubview(createAccountButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
    }
    
    private func addButtonActions() {
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAcc), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTerms), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacy), for: .touchUpInside)
    }
    
    @objc private func didTapSignIn() {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text, let password = passwordField.text, !email.trimmingCharacters(in: .whitespaces).isEmpty, !password.isEmpty, password.count >= 6
        else {
            return
        }
        
        //signin w/ authManager
        AuthManager.shared.signIn(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    let vc = TabBarViewController()
                    vc.modalPresentationStyle = .fullScreen
                    self?.present(vc, animated: true, completion: nil)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    @objc private func didTapCreateAcc() {
        let vc = SignUpViewController()
        vc.completion = { [weak self] in
            DispatchQueue.main.async {
                let tabVC = TabBarViewController()
                tabVC.modalPresentationStyle = .fullScreen
                self?.present(tabVC, animated: true)
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapTerms() {
        let vc = TermsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapPrivacy() {
        let vc = PrivacyViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.height/3)
        emailField.frame = CGRect(x: 25, y: headerView.bottom + 20, width: view.width-50, height: 50)
        passwordField.frame = CGRect(x: 25, y: emailField.bottom + 10, width: view.width-50, height: 50)
        signInButton.frame = CGRect(x: 35, y: passwordField.bottom + 20, width: view.width-70, height: 50)
        createAccountButton.frame = CGRect(x: 35, y: signInButton.bottom + 30, width: view.width-70, height: 50)
        termsButton.frame = CGRect(x: 35, y: createAccountButton.bottom + 50, width: view.width-70, height: 40)
        privacyButton.frame = CGRect(x: 35, y: termsButton.bottom + 10, width: view.width-70, height: 40)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            didTapSignIn()
        }
        return true
    }

}
