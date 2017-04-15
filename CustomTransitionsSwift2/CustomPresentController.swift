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
    
    fileprivate var duration: TimeInterval
    fileprivate var presentedImageView: UIImageView
    
    init(withDuration duration: TimeInterval, presentedImageView:UIImageView) {
        self.duration = duration
        self.presentedImageView = presentedImageView
        
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from)  else {return}
        guard let toVC = transitionContext.viewController(forKey: .to) as? ImageViewController else {return}
        
        let containerView = transitionContext.containerView
        
        let fromFrame = presentedImageView.convert(presentedImageView.bounds, to: containerView)
        let finalFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        let newImageView = UIImageView(frame: fromFrame)
        newImageView.image = presentedImageView.image
        newImageView.contentMode = .scaleAspectFit
        containerView.addSubview(newImageView)
        
        presentedImageView.alpha = 0
        
        UIView.animate(withDuration: self.duration, animations: { () -> Void in
            fromVC.view.alpha = 0
            newImageView.frame = finalFrame
        }, completion: { (completed: Bool) -> Void in
            fromVC.view.alpha = 1
            self.presentedImageView.alpha = 1
            containerView.addSubview(toVC.view)
            newImageView.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
    }
    
}
