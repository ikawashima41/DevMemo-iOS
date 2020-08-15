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
}
