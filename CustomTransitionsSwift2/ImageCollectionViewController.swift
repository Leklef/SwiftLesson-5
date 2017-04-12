//
//  ImageCollectionViewController.swift
//  CustomTransitionsSwift2
//
//  Created by Ленар on 09.04.17.
//  Copyright © 2017 ru.itisIosLab. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ImageCollectionViewController: UICollectionViewController {
    
    fileprivate let itemsPerRow: CGFloat = 2
    fileprivate let sectionInsets = UIEdgeInsets(top: 0, left: 1, bottom: 1, right: 0)
    var interactionController: UIPercentDrivenInteractiveTransition?
    
    var tappedImage:( UIImageView, CGRect)?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        cell.catImageView.image = UIImage(named: "\(indexPath.row)")
        cell.delegate = self
        return cell
    }

}

extension ImageCollectionViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

extension ImageCollectionViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomDismissController(withDuration: 0.5, originFrame: tappedImage!.1, presentedImage: tappedImage!.0)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomPresentController(withDuration: 2, originFrame: tappedImage!.1, presentedImage: tappedImage!.0)
    }
}

extension ImageCollectionViewController:DidSelectedCell {
    func presentVC(cell: ImageCollectionViewCell) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Image") as! ImageViewController
        vc.transitioningDelegate = self
        vc.image = cell.catImageView.image
        let imagePosition = cell.convert(cell.catImageView.frame.origin, to: collectionView)
        let imageFrameAndPosition = CGRect(x: imagePosition.x, y: imagePosition.y, width: cell.catImageView.frame.width, height: cell.catImageView.frame.height)
        tappedImage = (cell.catImageView, imageFrameAndPosition)
        self.present(vc, animated: true, completion: nil)
    }
}


