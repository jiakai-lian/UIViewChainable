//
//  ViewController.swift
//  UIViewChainable
//
//  Created by Jacky Lian on 11/21/2017.
//  Copyright (c) 2017 Jacky Lian. All rights reserved.
//

import UIKit
import UIViewChainable

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        UILabel().ui
            .attach(to: view)
            .constraintLayout {
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).activate()
            $0.centerYAnchor.constraint(equalTo: view.centerYAnchor).activate()
            
            $0.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).activate()
            }
            .config {
                $0.text = "Chainable UI config and layouts extension"
                $0.numberOfLines = -1
                $0.backgroundColor = .groupTableViewBackground
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

