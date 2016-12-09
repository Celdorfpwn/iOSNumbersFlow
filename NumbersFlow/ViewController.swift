//
//  ViewController.swift
//  NumbersFlow
//
//  Created by Ionut Apostol on 07/12/16.
//  Copyright © 2016 Catchy Games. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let numbersFactory : NumbersFactory = NumbersFactory()
    
    private let timerLabel : UILabel = UILabel()
    
    private var timerCount : Int = 60
    
    private var timer : Timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
        startGame()
    }
    
    func startGame(){
        view.subviews.forEach({ $0.removeFromSuperview()})
        numbersFactory.reset()
        generateButtons()
        generateTimerLabel()
        timerCount = 60
        timerLabel.text = String(timerCount)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCountAction), userInfo: nil, repeats: true)
    }
    
    
    func endGame() {
        let message = "Congratulations! Your score is " + String(numbersFactory.getScore())
        let alertController = UIAlertController(title: "Game over", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Restart" , style: UIAlertActionStyle.default, handler: { (alert: UIAlertAction!) in self.startGame() }))
        present(alertController,animated: true,completion: nil)
    }
    
    func generateTimerLabel() {
        let xPosition : CGFloat = view.frame.width / 2
        let yPosition : CGFloat = 50.0
        
        timerLabel.frame = CGRect(x: 0,y: 0,width: 50.0,height: 30.0)
        timerLabel.backgroundColor = UIColor.darkGray
        timerLabel.textColor = UIColor.white
        timerLabel.center = CGPoint(x: xPosition, y: yPosition)
        timerLabel.textAlignment = NSTextAlignment.center
        view.addSubview(timerLabel)
    }
    
    func timerCountAction() {
        
        if(timerCount == 0)
        {
            timer.invalidate()
            endGame()
        }
        
        timerLabel.text = String(timerCount)
        timerCount -= 1
    }
    
    
    func generateButtons() {
        let buttonSize : CGFloat = view.frame.width / 6
        
        let whiteSpace : CGFloat = buttonSize / 6
        
        var xPosition : CGFloat = whiteSpace
        var yPosition : CGFloat = (view.frame.height - buttonSize * 5 - whiteSpace * 4) / 2
        
        for _ in 1...5 {
            
            for _ in 1...5 {
                let button =  GameButton(type: UIButtonType.system)
                button.initialize(x: xPosition, y: yPosition, size: buttonSize)
                button.setTitle(String(numbersFactory.getNextNumber()), for: UIControlState.normal)
                button.addTarget(self, action: #selector(buttonClick), for: UIControlEvents.touchUpInside)
                
                xPosition += buttonSize + whiteSpace
                
                view.addSubview(button)
            }
            
            xPosition = whiteSpace
            yPosition += buttonSize + whiteSpace
            
        }
    }
    
    
    @IBAction func buttonClick(button: GameButton!) {
        
        
        let number = Int(button.titleLabel!.text!)
        
        if(numbersFactory.validateNumber(number: number!))
        {
            button.okEvent()
            button.setTitle(String(numbersFactory.getNextNumber()), for: UIControlState.normal)
        }
        else
        {
            button.wrongEvent()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}

