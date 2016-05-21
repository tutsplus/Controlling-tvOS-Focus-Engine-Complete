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

