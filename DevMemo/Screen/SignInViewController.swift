//
//  SignInViewController.swift
//  DevMemo
//
//  Created by Iichiro Kawashima on 2020/05/26.
//  Copyright © 2020 Iichiro Kawashima. All rights reserved.
//

import UIKit

final class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!

    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "ログイン画面"
        emailTextField.delegate = self
        passwordTextField.delegate = self
        signInButton.addTarget(self, action: #selector(didButtonTapped), for: .touchUpInside)
    }

    @objc private func didButtonTapped() {

        guard
            let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty else { return }

        FirebaseAuthService.signIn(email: email, password: password) { [weak self]  result in

            switch result {
            case .success:
                let vc = HomeViewController()
                self?.present(vc, animated: true)

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}
