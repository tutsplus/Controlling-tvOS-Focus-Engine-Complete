//
//  ViewController.swift
//  tvOS Focus Engine
//
//  Created by Davis Allie on 21/05/16.
//  Copyright © 2016 tutsplus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var buttons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let rightButtonIds = [3, 6]
        for buttonId in rightButtonIds {
            if let button = buttonWithTag(buttonId) {
                let focusGuide = UIFocusGuide()
                view.addLayoutGuide(focusGuide)
                focusGuide.widthAnchor.constraintEqualToAnchor(button.widthAnchor).active = true
                focusGuide.heightAnchor.constraintEqualToAnchor(button.heightAnchor).active = true
                focusGuide.leadingAnchor.constraintEqualToAnchor(button.trailingAnchor, constant: 60.0).active = true
                focusGuide.centerYAnchor.constraintEqualToAnchor(button.centerYAnchor).active = true
                focusGuide.preferredFocusedView = buttonWithTag(buttonId-2)
            }
        }
        
        let leftButtonIds = [1, 4]
        for buttonId in leftButtonIds {
            if let button = buttonWithTag(buttonId) {
                let focusGuide = UIFocusGuide()
                view.addLayoutGuide(focusGuide)
                focusGuide.widthAnchor.constraintEqualToAnchor(button.widthAnchor).active = true
                focusGuide.heightAnchor.constraintEqualToAnchor(button.heightAnchor).active = true
                focusGuide.trailingAnchor.constraintEqualToAnchor(button.leadingAnchor, constant: -60.0).active = true
                focusGuide.centerYAnchor.constraintEqualToAnchor(button.centerYAnchor).active = true
                focusGuide.preferredFocusedView = buttonWithTag(buttonId+2)
            }
        }
    }
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocusInContext(context, withAnimationCoordinator: coordinator)

        if let previouslyFocusedButton = context.previouslyFocusedView as? UIButton where buttons.contains(previouslyFocusedButton),
           let nextFocusedButton = context.nextFocusedView as? UIButton where buttons.contains(nextFocusedButton) {
            coordinator.addCoordinatedAnimations({
                previouslyFocusedButton.alpha = 0.5
                nextFocusedButton.alpha = 1.0
                
                // Running custom timed animation
                let duration = UIView.inheritedAnimationDuration()
                UIView.animateWithDuration(duration/2.0, delay: 0.0, options: .OverrideInheritedDuration, animations: {
                    // Animations
                    }, completion: { (completed: Bool) in
                        // Completion block
                })
                }, completion: {
                    // Run Completed Animation
            })
        }
    }
    
    override func shouldUpdateFocusInContext(context: UIFocusUpdateContext) -> Bool {
        let focusedButton = context.previouslyFocusedView as? UIButton
        
        if focusedButton == buttonWithTag(2) || focusedButton == buttonWithTag(3) {
            if context.focusHeading == .Down {
                return false
            }
        }
        
        return super.shouldUpdateFocusInContext(context)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonWithTag(tag: Int) -> UIButton? {
        for button in buttons {
            if button.tag == tag {
                return button
            }
        }
        
        return nil
    }
}

