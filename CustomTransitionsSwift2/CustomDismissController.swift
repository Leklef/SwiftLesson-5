//
//  DismissViewController.swift
//  CustomTransitionsSwift2
//
//  Created by Ленар on 12.04.17.
//  Copyright © 2017 ru.itisIosLab. All rights reserved.
//

import Foundation
import UIKit

class CustomDismissController:NSObject, UIViewControllerAnimatedTransitioning {
    
    var duration: TimeInterval
    var presentedImageView: UIImageView
    var originFrame:CGRect
    
    init(withDuration duration: TimeInterval, originFrame:CGRect, presentedImage:UIImageView) {
        self.duration = duration
        self.presentedImageView = presentedImage
        self.originFrame = originFrame
        
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) as? ImageViewController  else {return}
        guard let toVC = transitionContext.viewController(forKey: .to) else {return}
        
        let containerView = transitionContext.containerView
        
        guard let snapShotView = fromVC.catImageView.snapshotView(afterScreenUpdates: false) else {return}
        snapShotView.frame = fromVC.catImageView.frame
        
        containerView.addSubview(toVC.view)
        containerView.sendSubview(toBack: toVC.view)
        presentedImageView.alpha = 0
        
        containerView.addSubview(snapShotView)
        
        fromVC.view.removeFromSuperview()
        
        toVC.view.alpha = 0
        let finalFrameForVC = presentedImageView.frame
        UIView.animate(withDuration: self.duration, animations: { () -> Void in
            toVC.view.alpha = 1
            fromVC.catImageView.frame = finalFrameForVC
            snapShotView.frame = finalFrameForImage
            self.presentedImageView.alpha = 1
        }, completion: { (completed: Bool) -> Void in
            self.presentedImageView.alpha = 1
            snapShotView.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
    }
    
}
