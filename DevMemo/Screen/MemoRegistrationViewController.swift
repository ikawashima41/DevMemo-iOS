//
//  MemoRegistrationViewController.swift
//  DevMemo
//
//  Created by Iichiro Kawashima on 2020/08/09.
//  Copyright © 2020 Iichiro Kawashima. All rights reserved.
//

import UIKit

final class MemoRegistrationViewController: UIViewController, StoryBoardable {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension MemoRegistrationViewController {
    static func createInstance() -> MemoRegistrationViewController {
        return Self.storyboardInstance()
    }
}
