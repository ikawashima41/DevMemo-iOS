//
//  FirebaseAuthService.swift
//  DevMemo
//
//  Created by Iichiro Kawashima on 2020/05/26.
//  Copyright © 2020 Iichiro Kawashima. All rights reserved.
//

import FirebaseAuth

final class FirebaseAuthService {

    private let auth = Auth.auth()

    var currentId: String? {
        return auth.currentUser?.uid
    }

    func login(email: String, password: String,
               completion: @escaping (Result<Void, Error>) -> Void) {
        self.auth.createUser(withEmail: email, password: password, completion: { authResult, error in

            if let error = error {
                completion(.failure(error))
            }
            guard let email = authResult?.user.email, let uid = authResult?.user.uid else { return }

            UserDefaults.standard.set(email, forKey: "email")
            UserDefaults.standard.set(uid, forKey: "uid")

            completion(.success(()))
        })
    }

    func logout(successHandler: @escaping () -> Void, errorHandler: @escaping (Error) -> Void) {
        do {
            try auth.signOut()
            successHandler()
        } catch {
            errorHandler(error)
        }
    }
}
