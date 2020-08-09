//
//  FireStoreTests.swift
//  DevMemoTests
//
//  Created by Iichiro Kawashima on 2020/08/10.
//  Copyright © 2020 Iichiro Kawashima. All rights reserved.
//

import XCTest
import FirebaseFirestore

@testable import DevMemo

class FireStoreTests: XCTestCase {

    let uid: String = "TestUid"

    override func tearDown() {
        super.tearDown()

        Firestore.firestore().collection("users").document(uid).delete()
    }

    func testGetFirestore() {

        let exp = expectation(description: "fetchUsers")

        Firestore.firestore().collection("users").document().getDocument { (snapShot, error) in
            if let error = error {
                print(error.localizedDescription)
                XCTFail()
            }
            guard let data = snapShot?.data() else { return }
            print(data)

            exp.fulfill()
        }

        wait(for: [exp], timeout: 3.0)
    }

    func testPostFirestore() {
        let exp = expectation(description: "fetchMemos")

        FirebaseAuthService().signUp(email: "test1@gmail.com", password: "0401Tiro", uid: uid) { (result) in
            switch result {
            case .success:
                exp.fulfill()

            case .failure(let error):
                print(error.localizedDescription)
                XCTFail()
            }
        }
        wait(for: [exp], timeout: 3.0)
    }
}
