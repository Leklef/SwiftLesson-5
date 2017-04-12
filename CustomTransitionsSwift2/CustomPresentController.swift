//
//  CustomPresentController.swift
//  CustomTransitionsSwift2
//
//  Created by Ленар on 09.04.17.
//  Copyright © 2017 ru.itisIosLab. All rights reserved.
//

import Foundation
import UIKit

class CustomPresentController:NSObject, UIViewControllerAnimatedTransitioning {
    
    var duration: TimeInterval
    var originFrame: CGRect
    var presentedImageView: UIImageView
    
    init(withDuration duration: TimeInterval, originFrame: CGRect, presentedImage:UIImageView) {
        self.duration = duration
        self.originFrame = originFrame
        self.presentedImageView = presentedImage
        
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from)  else {return}
        guard let toVC = transitionContext.viewController(forKey: .to) as? ImageViewController else {return}
        
        let finalFrameToImage = toVC.catImageView.frame
        
        let containerView = transitionContext.containerView
        guard let snapShotView = presentedImageView.snapshotView(afterScreenUpdates: false) else {return}
        snapShotView.frame = originFrame
        snapShotView.contentMode = .center
        containerView.addSubview(snapShotView)
        presentedImageView.alpha = 0
        
        UIView.animate(withDuration: self.duration, animations: { () -> Void in
            fromVC.view.alpha = 0
            snapShotView.frame = finalFrameToImage
        }, completion: { (completed: Bool) -> Void in
            fromVC.view.alpha = 1
            self.presentedImageView.alpha = 1
            containerView.addSubview(toVC.view)
            snapShotView.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
    }
    
}
