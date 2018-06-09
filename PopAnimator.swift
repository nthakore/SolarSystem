//
//  PopAnimator.swift
//  SolarSystem
//
//  Created by Neha Thakore on 4/11/18.
//  Copyright © 2018 Neha Thakore. All rights reserved.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let duration = 1.0
    var shouldPresent = true
    var originFrame = CGRect.zero
    var dismissCompletion: (() -> Void)?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        let toView = transitionContext.view(forKey: .to)!
        let detailsView = shouldPresent ? toView : transitionContext.view(forKey: .from)!
        
        var initialFrame = shouldPresent ? originFrame : detailsView.frame
        
        let finalFrame = shouldPresent ? detailsView.frame : originFrame
        
        let xScaleFactor = shouldPresent ? initialFrame.width / finalFrame.width : finalFrame.width / initialFrame.width
        let yScaleFator = shouldPresent ? initialFrame.height / finalFrame.height : finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFator)
        if shouldPresent {
            detailsView.transform = scaleTransform
            detailsView.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
            detailsView.clipsToBounds = true
        }
        
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        containerView.bringSubview(toFront: detailsView)
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, animations: {
            detailsView.transform = self.shouldPresent ? CGAffineTransform.identity : scaleTransform
            detailsView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
        }, completion: { _ in
            if !self.shouldPresent {
                self.dismissCompletion?()
            }
            transitionContext.completeTransition(true)
        })
    }
}
