//
//  HomeViewController.swift
//  DevMemo
//
//  Created by Iichiro Kawashima on 2020/05/26.
//  Copyright © 2020 Iichiro Kawashima. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {

    private enum Section {
        case main
    }

    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, Int> = {
        let dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView) { (collectionView, indexPath, data) -> UICollectionViewCell? in

            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.reuseIdentifier, for: indexPath) as? HomeCollectionViewCell else {
              return UICollectionViewCell()
            }

            return cell
        }
        return dataSource
    }()

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(UINib(nibName: HomeCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: HomeCollectionViewCell.reuseIdentifier)
            collectionView.collectionViewLayout = configureLayout()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(Array(1...100))

        dataSource.apply(initialSnapshot, animatingDifferences: false)
    }

    private func configureLayout() -> UICollectionViewCompositionalLayout {
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .fractionalHeight(1.0))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.2))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

      let section = NSCollectionLayoutSection(group: group)

      return UICollectionViewCompositionalLayout(section: section)
    }
}
