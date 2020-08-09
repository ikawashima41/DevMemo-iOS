//
//  HomeCollectionViewCell.swift
//  DevMemo
//
//  Created by Iichiro Kawashima on 2020/05/26.
//  Copyright © 2020 Iichiro Kawashima. All rights reserved.
//

import UIKit

final class HomeCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: HomeCollectionViewCell.self)
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }


    func set(image: UIImage, title: String, description: String) {
        imageView.image = image
        titleLabel.text = title
        descriptionLabel.text = description
    }
}
