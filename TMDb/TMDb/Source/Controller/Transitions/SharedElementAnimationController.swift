//
//  SharedElementAnimationController.swift
//  CITAppStore
//
//  Created by SalmoJunior on 10/02/17.
//  Copyright © 2017 Salmo Junior. All rights reserved.
//

import UIKit


/// ItemToDetailAnimationController
class SharedElementAnimationController: NSObject {
    //MARK: - Properties
    fileprivate var originFrame: CGRect
    fileprivate var destineFrame: CGRect
    fileprivate var sourceImageView: UIImageView
    fileprivate var duration: Double
    var mode: SharedAnimationMode
    weak fileprivate var delegate: SharedElementAnimationControllerDelegate?
    
    //MARK: - Initializers
    init(originFrame: CGRect, destineFrame: CGRect, sourceImageView: UIImageView, animationMode: SharedAnimationMode = .push, duration: Double = 0.4, delegate: SharedElementAnimationControllerDelegate? = nil) {
        self.originFrame = originFrame
        self.destineFrame = destineFrame
        self.sourceImageView = sourceImageView.clone()
        self.mode = animationMode
        self.duration = duration
        self.delegate = delegate
    }
    
    //MARK: - Private Functions
    fileprivate func centerOfAFrame(_ frame: CGRect) -> CGPoint {
        let xCenter = frame.origin.x + frame.size.width / 2
        let yCenter = frame.origin.y + frame.size.height / 2
        let center = CGPoint(x: xCenter, y: yCenter)
        
        return center
    }
}


/// Supported transition types
///
/// - push: push
/// - pop: pop
/// - presenting: presenting
/// - dismiss: dismiss
enum SharedAnimationMode {
    case push
    case pop
    case presenting
    case dismiss
}

/// ItemToDetailAnimationControllerDelegate
protocol SharedElementAnimationControllerDelegate: class {
    
    /// Called when transition animation will start.
    /// It can be used to update view elements before start preseting the new view controller.
    ///
    /// - Parameter animator: animator intance
    func willStartAnimation(animator: SharedElementAnimationController)
    
    /// Called when transition animation is finishied.
    /// It can be used to update view elements after finish preseting the new view controller.
    ///
    /// - Parameter animator: animator instance
    func didCompleteAnimation(animator: SharedElementAnimationController)
}


// MARK: - UIViewControllerAnimatedTransitioning
extension SharedElementAnimationController: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?)-> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch mode {
        case .push:
            pushAnimation(transitionContext)
        case .pop:
            popAnimation(transitionContext)
        case .presenting:
            presentAnimation(transitionContext)
        case .dismiss:
            dismissAnimation(transitionContext)
        }
    }
    
    // Push and Present animation scope
    func pushAnimation(_ transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        
        let xScaleFactor = destineFrame.width / originFrame.width
        let yScaleFactor = destineFrame.height / originFrame.height
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        containerView.addSubview(fromViewController.view)
        containerView.addSubview(toViewController.view)
        
        sourceImageView.frame = originFrame
        containerView.addSubview(sourceImageView)
        delegate?.willStartAnimation(animator: self)
        
        toViewController.view.alpha = 0
        fromViewController.beginAppearanceTransition(false, animated: true)
        
        UIView.animate(withDuration: duration, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            self.sourceImageView.transform = scaleTransform
            self.sourceImageView.center = self.centerOfAFrame(self.destineFrame)
            toViewController.view.alpha = 1
            
        }) { (finished) in
            
            self.delegate?.didCompleteAnimation(animator: self)
            
            UIView.animate(withDuration: self.duration, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.sourceImageView.alpha = 0
            }, completion: { (finished) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                self.sourceImageView.removeFromSuperview()
                fromViewController.endAppearanceTransition()
            })
        }
    }
    
    // Pop animation scope
    func popAnimation(_ transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        
        let xScaleFactor = originFrame.width / destineFrame.width
        let yScaleFactor = originFrame.height / destineFrame.height
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        containerView.addSubview(fromViewController.view)
        containerView.addSubview(toViewController.view)

        sourceImageView.frame = destineFrame
        containerView.addSubview(sourceImageView)
        delegate?.willStartAnimation(animator: self)
        
        UIView.animate(withDuration: duration, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            self.sourceImageView.transform = scaleTransform
            self.sourceImageView.center = self.centerOfAFrame(self.originFrame)
            
        }) { (finished) in
            
            self.delegate?.didCompleteAnimation(animator: self)
            
            UIView.animate(withDuration: self.duration, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.sourceImageView.alpha = 0
            }, completion: { (finished) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                self.sourceImageView.removeFromSuperview()
            })
        }
    }
    
    // Presenting animation scope 
    func presentAnimation(_ transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        
        containerView.addSubview(toViewController.view)
        
        sourceImageView.frame = originFrame
        containerView.addSubview(sourceImageView)
        delegate?.willStartAnimation(animator: self)
        
        let xScaleFactor = destineFrame.size.width / originFrame.size.width
        let yScaleFactor = destineFrame.size.height / originFrame.size.height
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        toViewController.view.alpha = 0
        
        UIView.animate(withDuration: duration, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            self.sourceImageView.transform = scaleTransform
            self.sourceImageView.center = self.centerOfAFrame(self.destineFrame)
            toViewController.view.alpha = 1
            
        }) { (finished) in
            
            self.delegate?.didCompleteAnimation(animator: self)
            
            UIView.animate(withDuration: self.duration, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.sourceImageView.alpha = 0
            }, completion: { (finished) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                self.sourceImageView.removeFromSuperview()
            })
        }
    }
    
    // Dismiss animation scope
    func dismissAnimation(_ transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        
        sourceImageView.frame = originFrame
        containerView.addSubview(sourceImageView)
        delegate?.willStartAnimation(animator: self)
        
        let xScaleFactor = destineFrame.size.width / originFrame.size.width
        let yScaleFactor = destineFrame.size.height / originFrame.size.height
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        UIView.animate(withDuration: duration, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            self.sourceImageView.transform = scaleTransform
            self.sourceImageView.center = self.centerOfAFrame(self.destineFrame)
            fromView.alpha = 0
        }) { (finished) in
            
            self.delegate?.didCompleteAnimation(animator: self)
            
            UIView.animate(withDuration: self.duration, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.sourceImageView.alpha = 0
            }, completion: { (finished) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                self.sourceImageView.removeFromSuperview()
            })
        }
    }
}
