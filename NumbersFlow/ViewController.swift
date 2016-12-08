//
//  ViewController.swift
//  NumbersFlow
//
//  Created by Ionut Apostol on 07/12/16.
//  Copyright © 2016 Catchy Games. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateButtons()
    }
    
    func generateButtons() {
        
        
        
        let buttonSize : CGFloat = view.frame.width / 6
        
        let whiteSpace : CGFloat = buttonSize / 6
        
        var xPosition : CGFloat = whiteSpace
        var yPosition : CGFloat = 100
        
        
        for _ in 1...5 {
            
            for _ in 1...5 {
                let button =  UIButton(type: UIButtonType.system)
                button.frame = CGRect(x: xPosition,y: yPosition,width: buttonSize,height: buttonSize)
                button.backgroundColor = UIColor.blue
                button.setTitle("sometitle", for: UIControlState.normal)
                
                xPosition += buttonSize + whiteSpace
                
                view.addSubview(button)
            }
            
            xPosition = whiteSpace
            yPosition += buttonSize + whiteSpace
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}

