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
    var presenting = true
    var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        let detailsView = presenting ? toView : transitionContext.view(forKey: .from)!
        
        let initialFrame = presenting ? originFrame : detailsView.frame
        let finalFrame = presenting ? detailsView.frame : originFrame
        
        let xScaleFactor = presenting ? initialFrame.width / finalFrame.width : finalFrame.width / initialFrame.width
        let yScaleFator = presenting ? initialFrame.height / finalFrame.height : finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFator)
        if presenting {
            detailsView.transform = scaleTransform
            detailsView.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
            detailsView.clipsToBounds = true
        }
        
        containerView.addSubview(toView)
        containerView.bringSubview(toFront: detailsView)
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, animations: {
            detailsView.transform = self.presenting ? CGAffineTransform.identity : scaleTransform
            detailsView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
}
