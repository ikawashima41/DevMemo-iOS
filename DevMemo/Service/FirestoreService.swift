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

    func fetch() {
        dataStore.collection("users").document("")
    }

    func post() {
        dataStore.collection("memos").document("")
    }
}

struct User {
    var name: String
    var email: String
    var iconUrl: String
    var createdAt: Date
    var updatedAt: Date
}

struct Memos {
    var title: String
    var description: String
    var isCompleted: Bool
    var tagsIDs: [String]?
    var createdAt: Date
    var updatedAt: Date
}

struct Tags {
    var title: String
    var isCompleted: Bool
    var completedAt: Date?
    var tagsIDs: [String]?
    var createdAt: Date
    var updatedAt: Date
}
