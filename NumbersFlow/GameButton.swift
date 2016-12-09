//
//  GameButton.swift
//  NumbersFlow
//
//  Created by Ionut Apostol on 09/12/16.
//  Copyright © 2016 Catchy Games. All rights reserved.
//

import Foundation
import UIKit

public class GameButton : UIButton {
    
    public func initialize(x: CGFloat, y: CGFloat, size : CGFloat) {
        self.frame = CGRect(x: x,y: y,width: size,height: size)
        self.backgroundColor = UIColor.darkGray
        self.setTitleColor(UIColor.white, for: UIControlState.normal)
        self.titleLabel!.font = UIFont(name: "Arial", size: 25)
    }
    
    
    public func okEvent() {
        self.backgroundColor = UIColor.green
        
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(reset), userInfo: nil, repeats: false)
        
    }
    
    public func wrongEvent(){
        self.backgroundColor = UIColor.red
        
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(reset), userInfo: nil, repeats: false)
    }
    
    
    func reset() {
        self.backgroundColor = UIColor.darkGray
    }
    
}
