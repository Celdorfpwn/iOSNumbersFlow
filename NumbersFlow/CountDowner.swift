//
//  CountDowner.swift
//  NumbersFlow
//
//  Created by Ionut Apostol on 12/12/16.
//  Copyright © 2016 Catchy Games. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    static let comboSeconds = 2
    static let startSeconds = 66
}

public class CountDowner {
    
    private let viewController : ViewController
    
    private let timerLabel : UILabel = UILabel()
    
    private var timerCounter : Int = Constants.startSeconds
    
    private var timer : Timer = Timer()
    
    private var comboCounter : Int = Constants.comboSeconds
    
    private var comboX : Int = 0
    
    init(controller : ViewController) {
        viewController = controller
        
    }
    
    
    public func start() {
        generateTimerLabel()
        comboCounter = Constants.comboSeconds
        
        timerCounter = Constants.startSeconds
        timerLabel.text = String(timerCounter)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCountAction), userInfo: nil, repeats: true)
    }
    
    public func wrong(){
        comboCounter = 0
        comboX = 0
        if(timerCounter >= 3){
            timerCounter -= 3
            timerLabel.text = String(timerCounter)
        }
        else {
            endGame()
        }
    }
    
    public func addCombo() {
        comboCounter = Constants.comboSeconds
        comboX += 1
    }
    
    func calculateCombo() -> Int {
        return comboX / 3 + comboX
    }
    
    func generateTimerLabel() {
        let xPosition : CGFloat = viewController.view.frame.width / 2
        let yPosition : CGFloat = 50.0
        
        timerLabel.frame = CGRect(x: 0,y: 0,width: 50.0,height: 30.0)
        timerLabel.backgroundColor = UIColor.black
        timerLabel.textColor = UIColor.white
        timerLabel.center = CGPoint(x: xPosition, y: yPosition)
        timerLabel.textAlignment = NSTextAlignment.center
        viewController.view.addSubview(timerLabel)
    }
    
    func endGame() {
        timer.invalidate()
        viewController.endGame()
    }
    
    @objc func timerCountAction() {
        if(timerCounter <= 0)
        {
            endGame()
        }
        
        if(comboCounter == 0)
        {
            if(comboX > 3)
            {
                let comboTotal = calculateCombo()
                timerCounter += comboTotal
                timerLabel.text = "+" + String(comboTotal)
                
            }
            else
            {
                timerLabel.text = String(timerCounter)
                timerCounter -= 1
            }
            
            comboX = 0
        }
        else
        {
            comboCounter -= 1
            timerLabel.text = String(timerCounter)
            timerCounter -= 1
        }
    }
    
}
