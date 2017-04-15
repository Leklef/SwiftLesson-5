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
    
    init(withDuration duration: TimeInterval, presentedImageView:UIImageView) {
        self.duration = duration
        self.presentedImageView = presentedImageView
        
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) as? ImageViewController  else {return}
        guard let toVC = transitionContext.viewController(forKey: .to) else {return}
        
        let containerView = transitionContext.containerView
        
        let toFrame = presentedImageView.convert(presentedImageView.bounds, to: containerView)
        let fromFrame = fromVC.catImageView.convert(fromVC.catImageView.bounds, to: containerView)
        
        let newImageView = UIImageView(frame: fromFrame)
        newImageView.image = presentedImageView.image
        newImageView.contentMode = .scaleAspectFit
        containerView.addSubview(newImageView)
        
        containerView.addSubview(toVC.view)
        containerView.sendSubview(toBack: toVC.view)
        presentedImageView.alpha = 0
        
        containerView.addSubview(newImageView)
        
        fromVC.view.removeFromSuperview()
        
        toVC.view.alpha = 0
        UIView.animate(withDuration: self.duration, animations: { () -> Void in
            toVC.view.alpha = 1
            newImageView.frame = toFrame
        }, completion: { (completed: Bool) -> Void in
            self.presentedImageView.alpha = 1
            newImageView.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
    }
    
}
