//
//  StoryBoardable.swift
//  DevMemo
//
//  Created by Iichiro Kawashima on 2020/09/21.
//  Copyright © 2020 Iichiro Kawashima. All rights reserved.
//
import UIKit

protocol StoryBoardable where Self: UIViewController {}

extension StoryBoardable {
    static func storyboardInstance(bundle: Bundle = Bundle.main) -> Self {
        let className = String(describing: Self.self)
        let storyboard = UIStoryboard(name: className, bundle: bundle)
        if let initialViewController = storyboard.instantiateInitialViewController() as? Self {
            return initialViewController
        } else {
            fatalError("Could not instantiate a \(className) instance from the storyboard.")
        }
    }
}
