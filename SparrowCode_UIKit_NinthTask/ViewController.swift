//
//  ViewController.swift
//  SparrowCode_UIKit_NinthTask
//
//  Created by Edmond Podlegaev on 27.04.2024.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    lazy var collectionView: UICollectionView = {
        let layout = CustomFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.width / 1.5, height: view.frame.height / 2)

        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        collectionView.layoutMargins = .init(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.delegate = self
        collectionView.dataSource = self

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Collection"
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.frame = view.frame
    }
    
    func collectionView(_: UICollectionView, numberOfItemsInSection: Int) -> Int {
        10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        cell.layer.cornerRadius = 10
        cell.backgroundColor = .lightGray

        return cell
    }

    func collectionView(_: UICollectionView, layout: UICollectionViewLayout, insetForSectionAt: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}

final class CustomFlowLayout: UICollectionViewFlowLayout {

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }

        let pageWidth = itemSize.width + minimumInteritemSpacing
        let approximatePage = collectionView.contentOffset.x / pageWidth
        let currentPage = velocity.x.isZero ? round(approximatePage) : (velocity.x < .zero ? floor(approximatePage) : ceil(approximatePage))
        let flickedPages = (abs(round(velocity.x)) <= 1) ? .zero : round(velocity.x)
        let newHorizontalOffset = ((currentPage + flickedPages) * pageWidth) - collectionView.contentInset.left

        return CGPoint(x: newHorizontalOffset, y: proposedContentOffset.y)
    }
}
