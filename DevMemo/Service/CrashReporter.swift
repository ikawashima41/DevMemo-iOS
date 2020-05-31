//
//  CrashReporting.swift
//  DevMemo
//
//  Created by Iichiro Kawashima on 2020/05/29.
//  Copyright © 2020 Iichiro Kawashima. All rights reserved.
//

import FirebaseCrashlytics

struct NonFatalError: Error {

    var domain: String
    var code: Int
    var userInfo: [String: Any]

    init(domain: String, code: Int, userInfo: [String: Any]) {
        self.code = code
        self.domain = domain
        self.userInfo = userInfo
    }
}

final class CrashReporter {
    static let shared: CrashReporter = CrashReporter()

    private init() {}

    private let crash = Crashlytics.crashlytics()

    func sendEvent(error: Error?) {

        crash.setCustomValue("1111111", forKey: "userId")
        crash.setCustomValue("networkError", forKey: "title")
        crash.setCustomValue("offlineです", forKey: "message")
        crash.setCustomValue("追加情報", forKey: "additionalInfo")

        crash.setUserID("1111")
        if let error = error?.convert() {
            crash.record(error: error)
        }
    }
}

private extension Error {
    func convert() -> NonFatalError? {

        var userInfo: [String: Any] = [:]
        userInfo.updateValue("1111111", forKey: "userId")
        userInfo.updateValue("networkError", forKey: "title")
        userInfo.updateValue("offlineです", forKey: "message")
        userInfo.updateValue("追加情報", forKey: "additionalInfo")


        return NonFatalError(
            domain: "Test",
            code: 500,
            userInfo: userInfo
        )
    }

    var statusCode: Int {
        let nsError = self as NSError
        return nsError.code
    }

    var domain: String {
        let nsError = self as NSError
        return nsError.domain
    }
}
