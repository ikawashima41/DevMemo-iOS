//
//  FirebaseAuthTests.swift
//  DevMemoTests
//
//  Created by Iichiro Kawashima on 2020/08/16.
//  Copyright © 2020 Iichiro Kawashima. All rights reserved.
//

import XCTest

@testable import DevMemo

class FirebaseAuthTests: XCTestCase {

    private let uid: String = "TestUid"

    override func tearDown() {
        super.tearDown()

        FirebaseAuthService.logout(successHandler: {
            print("logout")
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    func testSignIn() {
        let exp = expectation(description: "signIn")

        FirebaseAuthService.signIn(email: "test1@gmail.com", password: "0401Tiro") { (result) in
            switch result {
            case .success:
                exp.fulfill()

            case .failure(let error):
                print(error.localizedDescription)
                XCTFail()
            }
        }
        wait(for: [exp], timeout: 5.0)
    }

    func testSignUp() {
        let exp = expectation(description: "signUp")

        let email = "\(randomString(length: 8))@gmail.com"
        FirebaseAuthService.signUp(email: email, password: "0401Tiro", uid: uid) { (result) in
            switch result {
            case .success:
                exp.fulfill()

            case .failure(let error):
                print(error.localizedDescription)
                XCTFail()
            }
        }
        wait(for: [exp], timeout: 5.0)
    }

    private func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
