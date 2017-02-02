//
//  ViewController.swift
//  AASegmentedControl
//
//  Created by Engr. Ahsan Ali on 01/10/2017.
//  Copyright (c) 2017 AA-Creations. All rights reserved.
//

import UIKit
import AASegmentedControl

class ViewController: UIViewController {
    
    @IBOutlet var segmentedControls: [AASegmentedControl]!

    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControls.forEach({self.setupSegmentedControl($0)})
        
    }
    
    func setupSegmentedControl(_ segmentControl: AASegmentedControl) {
        segmentControl.itemNames = ["TAB 1","TAB 2","TAB 3"]
        segmentControl.font = UIFont(name: "Chalkduster", size: 14.0)!
        segmentControl.selectedIndex = 1
        segmentControl.addTarget(self,
                                 action: #selector(ViewController.segmentValueChanged(_:)),
                                 for: .valueChanged)
    }
    
    func segmentValueChanged(_ sender: AASegmentedControl) {
        
        segmentedControls.forEach({$0.selectedIndex = sender.selectedIndex})
        
        print("SelectedIndex: ", sender.selectedIndex)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}



