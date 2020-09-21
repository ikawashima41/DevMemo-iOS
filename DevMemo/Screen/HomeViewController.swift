//
//  HomeViewController.swift
//  DevMemo
//
//  Created by Iichiro Kawashima on 2020/05/26.
//  Copyright © 2020 Iichiro Kawashima. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController, StoryBoardable {

    @IBOutlet weak var collectionView: UICollectionView!

    private var model: [Memos] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        FirestoreService.fetch { [weak self] result in
            switch result {
            case .success(let memos):
                self?.model.append(contentsOf: memos)

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "ホーム画面"
        setupCollectionView()
    }

    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: HomeCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: HomeCollectionViewCell.reuseIdentifier)
        collectionView.collectionViewLayout = layout
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.reuseIdentifier, for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }

        cell.configure(image: UIImage(named: "AppIcon")!, title: "test", description: "description")
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let prototypeCell = UINib(nibName: "HomeCollectionViewCell", bundle: nil).instantiate(withOwner: nil, options: nil).first as! HomeCollectionViewCell
        prototypeCell.bounds.size.width = cellWidth
        prototypeCell.contentView.bounds.size.width = cellWidth
        return prototypeCell.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .defaultLow)
    }

    private var cellWidth: CGFloat {
        let availableWidth = collectionView.bounds.inset(by: collectionView.adjustedContentInset).width
        let interColumnSpace = CGFloat(8)
        let numColumns = CGFloat(3)
        let numInterColumnSpaces = numColumns - 1

        return ((availableWidth - interColumnSpace * numInterColumnSpaces) / numColumns).rounded(.down)
    }
}

extension HomeViewController {
    static func createInstance() -> HomeViewController {
        return Self.storyboardInstance()
    }
}
