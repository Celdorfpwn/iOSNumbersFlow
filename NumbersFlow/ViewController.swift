//
//  ViewController.swift
//  NumbersFlow
//
//  Created by Ionut Apostol on 07/12/16.
//  Copyright © 2016 Catchy Games. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var presentationLabel: UILabel!
    
    private let numbersFactory : NumbersFactory = NumbersFactory()
    
    private lazy var countDowner : CountDowner = CountDowner(controller: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startIntroduction()
    }
    
    public func startIntroduction(){
        presentationLabel.alpha = 0.0
        
        presentationLabel.text = "Catchy Games"
        
        UIView.animate(withDuration: 2, animations: {
            self.presentationLabel.alpha = 1.0
        })
        
        _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(fadeOutFirstText), userInfo: nil, repeats: false)
    }
    
    public func fadeOutFirstText() {
        UIView.animate(withDuration: 2, animations: {
            self.presentationLabel.alpha = 0
        })
        
        _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(fadeInSecondText), userInfo: nil, repeats: false)
    }
    
    public func fadeInSecondText() {
        
        self.presentationLabel.alpha = 0.0
        UIView.animate(withDuration: 0.5, animations: {
            self.presentationLabel.alpha = 1.0
            self.presentationLabel.text = "Have fun"
        })
    
       
        _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(fadeOutSecondText), userInfo: nil, repeats: false)
    }
    
    public func fadeOutSecondText() {
        UIView.animate(withDuration: 2, animations: {
            self.presentationLabel.alpha = 0
        })
        
        _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(startGame), userInfo: nil, repeats: false)
    }
    
    public func startGame(){
        
            self.view.backgroundColor = UIColor.lightGray
            self.view.subviews.forEach({ $0.removeFromSuperview()})
            self.numbersFactory.reset()
            self.generateButtons()
            self.countDowner.start()
    
    }
    

    public func endGame() {
        
        let message = "Congratulations! Your score is " + String(numbersFactory.getScore())
        let alertController = UIAlertController(title: "Game over", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Restart" , style: UIAlertActionStyle.default, handler: { (alert: UIAlertAction!) in self.startGame() }))
        present(alertController,animated: true,completion: nil)
        
    }
    

    @IBAction func buttonClick(button: GameButton!) {
        
        let number = Int(button.titleLabel!.text!)
        
        if(numbersFactory.validateNumber(number: number!))
        {
            button.okEvent()
            countDowner.addCombo()
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
                button.layer.cornerRadius = 10
                xPosition += buttonSize + whiteSpace
                
                view.addSubview(button)
            }
            
            xPosition = whiteSpace
            yPosition += buttonSize + whiteSpace
            
        }
    }
    
}

