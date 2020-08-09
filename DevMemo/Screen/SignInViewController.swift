//
//  SignInViewController.swift
//  DevMemo
//
//  Created by Iichiro Kawashima on 2020/05/26.
//  Copyright © 2020 Iichiro Kawashima. All rights reserved.
//

import UIKit

enum CrashError: Error {
    case network
    case test
}

final class SignInViewController: UIViewController {

    private let service = FirebaseAuthService()

    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!

    @IBOutlet weak var signInButton: UIButton! {
        didSet {
            signInButton.addTarget(self, action: #selector(didButtonTapped), for: .touchUpInside)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.delegate = self
        passwordTextField.delegate = self

    }

    @objc private func didButtonTapped() {

        guard
            let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty else { return }

        service.signIn(email: email, password: password) { [weak self]  result in

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

        fatalError()
    }
}
