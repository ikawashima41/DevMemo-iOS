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

    }

    func post() {
        dataStore.collection("memos").document("")
    }

    func testPost() {
        let citiesRef = dataStore.collection("users")

        citiesRef.document().setData([
            "name": "San Francisco",
            "state": "CA",
            "country": "USA",
            "capital": false,
            "population": 860000,
            "regions": ["west_coast", "norcal"]
        ])
        citiesRef.document("LA").setData([
            "name": "Los Angeles",
            "state": "CA",
            "country": "USA",
            "capital": false,
            "population": 3900000,
            "regions": ["west_coast", "socal"]
        ])
        citiesRef.document("DC").setData([
            "name": "Washington D.C.",
            "country": "USA",
            "capital": true,
            "population": 680000,
            "regions": ["east_coast"]
        ])
        citiesRef.document("TOK").setData([
            "name": "Tokyo",
            "country": "Japan",
            "capital": true,
            "population": 9000000,
            "regions": ["kanto", "honshu"]
        ])
        citiesRef.document("BJ").setData([
            "name": "Beijing",
            "country": "China",
            "capital": true,
            "population": 21500000,
            "regions": ["jingjinji", "hebei"]
        ])
    }

    func testFetch() {
        let citiesRef = dataStore.collection("users").order(by: "name").addSnapshotListener { snapshot, e in
            if let snapshot = snapshot {
                snapshot.documents.map { user -> User in
                    let data = user.data()
                    return User(name: data["name"] as! String, email: data["email"] as! String, iconUrl: data["iconUrl"] as! String, createdAt: data["createdAt"] as! Timestamp, updatedAt: data["updatedAt"] as! Timestamp)
                }
            }
        }
    }
}

struct User {
    var name: String
    var email: String
    var iconUrl: String
    var createdAt: Timestamp
    var updatedAt: Timestamp
}

struct Memos {
    var title: String
    var description: String
    var isCompleted: Bool
    var tagsIDs: [String]?
    var createdAt: Timestamp
    var updatedAt: Timestamp
}

struct Tags {
    var title: String
    var isCompleted: Bool
    var completedAt: Date?
    var tagsIDs: [String]?
    var createdAt: Timestamp
    var updatedAt: Timestamp
}
