//
//  Entity.swift
//  DevMemo
//
//  Created by Iichiro Kawashima on 2020/08/09.
//  Copyright © 2020 Iichiro Kawashima. All rights reserved.
//
import Firebase

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
