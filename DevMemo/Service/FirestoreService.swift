//
//  FirestoreService.swift
//  DevMemo
//
//  Created by Iichiro Kawashima on 2020/05/31.
//  Copyright © 2020 Iichiro Kawashima. All rights reserved.
//

import FirebaseFirestore

final class FirestoreService {

    enum FireStoreQuery {
        case registerUser(name: String, email: String, uid: String)
        case registerMemo(memo: Memos, index: Int)
        case update(memo: Memos, index: Int)
    }

    private static let dataStore = Firestore.firestore()

    static func fetch(comepltion: @escaping (Result<[Memos], Error>) -> Void) {
        dataStore.collection("Memos").order(by: "title")
            .addSnapshotListener { snapshot, error in

                if let error = error {
                    comepltion(.failure(error))
                }

                if let snapshot = snapshot {
                    let memos = snapshot.documents.map { memos -> Memos in
                        let data = memos.data()
                        return
                            Memos(title: data["title"] as! String,
                                  description: data["description"] as! String,
                                  isCompleted: data["isCompleted"] as! Bool,
                                  tagsIDs: data["tagsIDs"] as? [String],
                                  createdAt: data["createdAt"] as! Timestamp,
                                  updatedAt: data["updatedAt"] as! Timestamp
                            )
                    }
                    comepltion(.success(memos))
                }
        }
    }

    static func setData(_ type: FireStoreQuery) {

        switch type {
        case .registerUser(let memo, let index, _):
            dataStore.collection(memo).document(index).setData([
                "name": "memo.title",
                "description": "memo.description"
            ])

        default:
            break

        }
    }
}
