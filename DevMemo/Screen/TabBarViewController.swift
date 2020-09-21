//
//  TabBarViewController.swift
//  DevMemo
//
//  Created by Iichiro Kawashima on 2020/09/21.
//  Copyright © 2020 Iichiro Kawashima. All rights reserved.
//

import UIKit

final class TabBarViewController: UITabBarController, StoryBoardable {

    override func viewDidLoad() {
        super.viewDidLoad()

        let homeVC = HomeViewController.createInstance()
        let memoRegisterVC = MemoRegistrationViewController.createInstance()

        setViewControllers([homeVC, memoRegisterVC], animated: false)
    }
}

