//
//  CrashReporting.swift
//  DevMemo
//
//  Created by Iichiro Kawashima on 2020/05/29.
//  Copyright © 2020 Iichiro Kawashima. All rights reserved.
//

import FirebaseCrashlytics

enum CrashError: Error {
    case network
    case test
}

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

        crash.setCustomValue(String(describing: error?.statusCode), forKey: "statusCode")
        crash.setCustomValue(error?.localizedDescription ?? "", forKey: "description")

        crash.setUserID("STG-test")

        if let error = error?.convert() {
            crash.record(error: error)
        }
    }
}

private extension Error {
    func convert() -> NonFatalError? {

        return NonFatalError(
            domain: domain,
            code: statusCode,
            userInfo: [:]
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
