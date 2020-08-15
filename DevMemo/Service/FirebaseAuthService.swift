//
//  FirebaseAuthService.swift
//  DevMemo
//
//  Created by Iichiro Kawashima on 2020/05/26.
//  Copyright © 2020 Iichiro Kawashima. All rights reserved.
//

import FirebaseAuth
import FirebaseFirestore

final class FirebaseAuthService {

    private static let auth = Auth.auth()

    static var currentId: String? {
        return auth.currentUser?.uid
    }

    static func signIn(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {

        auth.signIn(withEmail: email, password: password, completion: { authResult, error in
            if let error = error {
                completion(.failure(error))
            }

            guard let uid = authResult?.user.uid else { return }

            Firestore.firestore().collection("users").document(uid).getDocument { (ref, error) in
                if let error = error {
                    completion(.failure(error))
                }

                completion(.success(()))
            }
        })
    }

    static func signUp(email: String, password: String, uid: String? = nil,
                completion: @escaping (Result<Void, Error>) -> Void) {
        auth.createUser(withEmail: email, password: password, completion: { authResult, error in

            if let error = error {
                completion(.failure(error))
            }
            guard let email = authResult?.user.email, let id = authResult?.user.uid else { return }

            var documentId: String {
                if let uid = uid {
                    return uid
                } else {
                    return id
                }
            }

            Firestore.firestore().collection("users").document(documentId).setData([
                "email": email
            ], merge: true)

            completion(.success(()))
        })
    }

    static func logout(successHandler: @escaping () -> Void, errorHandler: @escaping (Error) -> Void) {
        do {
            try auth.signOut()
            successHandler()
        } catch {
            errorHandler(error)
        }
    }

    static func fetch(comepltion: @escaping (Result<[User], Error>) -> Void) {

        Firestore.firestore().collection("Users").order(by: "name")
            .addSnapshotListener { snapshot, error in

                if let error = error {
                    comepltion(.failure(error))
                }

                if let snapshot = snapshot {
                    let users = snapshot.documents.map { user -> User in
                        let data = user.data()
                        return User(name: data["name"] as! String, email: data["email"] as! String, iconUrl: data["iconUrl"] as! String, createdAt: data["createdAt"] as! Timestamp, updatedAt: data["updatedAt"] as! Timestamp)
                    }
                    comepltion(.success(users))
                }
        }
    }
}
