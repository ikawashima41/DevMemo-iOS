//
//  FirestoreService.swift
//  DevMemo
//
//  Created by Iichiro Kawashima on 2020/05/31.
//  Copyright © 2020 Iichiro Kawashima. All rights reserved.
//

import FirebaseFirestore

final class FirestoreService {

    private let listener: ListenerRegistration? = nil

    private let dataStore = Firestore.firestore()

    func fetch(comepltion: @escaping (Result<User, Error>) -> Void) {

        let memosRefs = dataStore.collection("Users").order(by: "name")

            .addSnapshotListener { snapshot, e in
                if let snapshot = snapshot {
                    snapshot.documents.map { user -> User in
                        let data = user.data()
                        return User(name: data["name"] as! String, email: data["email"] as! String, iconUrl: data["iconUrl"] as! String, createdAt: data["createdAt"] as! Timestamp, updatedAt: data["updatedAt"] as! Timestamp)
                    }
                }
        }
    }

    func register(name: String, email: String, uid: String) {
        dataStore.collection("users").document(uid).setData([
            "name": name,
            "email": email
        ])
    }

    func register(_ memo: Memos, index: Int) {
        dataStore.collection("memos").document("\(index + 1)").setData([
            "name": memo.title,
            "description": memo.description
        ])
    }

    func update(_ memo: Memos, index: Int) {
        dataStore.collection("memos").document("\(index + 1)").setData([
            "name": memo.title,
            "description": memo.description
        ])
    }
}
