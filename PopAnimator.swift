//
//  PopAnimator.swift
//  SolarSystem
//
//  Created by Neha Thakore on 4/11/18.
//  Copyright © 2018 Neha Thakore. All rights reserved.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let duration = 0.25
    var isPresenting = true
    var originFrame = CGRect.zero
    var originView = UIView()
    var dismissCompletion: (() -> Void)?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toView = transitionContext.view(forKey: .to)!
        let fromView = transitionContext.view(forKey: .from)!
        
        let scaleTransform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        
        if isPresenting {
            toView.clipsToBounds = true
        }
        
        let containerView = transitionContext.containerView
        
        var viewToBringToFront = UIView()
        if isPresenting {
            viewToBringToFront = toView
        } else {
            viewToBringToFront = fromView
        }
        
        containerView.addSubview(toView)
        
        if !isPresenting {
            containerView.addSubview(viewToBringToFront)
        }
        containerView.bringSubview(toFront: viewToBringToFront)
        
        if isPresenting {
            UIView.animate(withDuration: duration, delay: 0.0, options: [UIViewAnimationOptions.curveEaseOut], animations: {
                    viewToBringToFront.transform = scaleTransform
            }) { (complete) in
                UIView.animate(withDuration: self.duration, delay: 0.0, options: [UIViewAnimationOptions.curveEaseOut], animations: {
                    viewToBringToFront.transform = CGAffineTransform.identity
                }) { (complete) in
                    if !self.isPresenting {
                        self.dismissCompletion?()
                    }
                    
                    transitionContext.completeTransition(true)
                }
            }
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                viewToBringToFront.alpha = 0.0
            }) { (complete) in
                if !self.isPresenting {
                    self.dismissCompletion?()
                }
                
                transitionContext.completeTransition(true)
            }
        }
    }
}
