//
//  ViewController.swift
//  Notifications
//
//  Copyright © 2019 The Dev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var timer:Timer?
    var isAnimating:Bool = false
    var animationQueue:[String] = []
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    var animationIndex = 0
    let notifNames = ["sizeIncrease","alphaDecrease","alphaIncrease","sizeDecrease"]
    @IBOutlet weak var animationView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (timer) in
            let notifName = self.notifNames[self.animationIndex]
            if self.animationIndex == 3{
                self.animationIndex = 0
            }else{
                self.animationIndex = self.animationIndex + 1
            }
            self.processNotifications(name: notifName)
        }
        timer?.fire()
    }
    
    func processNotifications(name:String){
        self.animationQueue.append(name)
        let countQueue = self.animationQueue.count
        //Remove this condition to develop naver ending animation
        if countQueue >= 20{
            timer?.invalidate()
        }
        self.triggerAnimation()
    }

    func triggerAnimation(){
        if !isAnimating && animationQueue.count > 0{
            self.performAnimation()
        }
    }
    
    func performAnimation(){
        let currentAnimation = animationQueue.removeFirst()
        switch currentAnimation {
        case "alphaIncrease":
            self.isAnimating = true
            UIView.animate(withDuration: 1.0, animations: {
                self.animationView.alpha = 1.0
            }) { (complete) in
                self.isAnimating = false
                self.triggerAnimation()
            }
        case "alphaDecrease":
            self.isAnimating = true
            UIView.animate(withDuration: 1.0, animations: {
                self.animationView.alpha = 0.0
            }) { (complete) in
                self.isAnimating = false
                self.triggerAnimation()
            }
        case "sizeIncrease":
            self.isAnimating = true
            heightConstraint.constant = 100.0
            UIView.animate(withDuration: 1.0, animations: {
                self.view.layoutIfNeeded()
            }) { (complete) in
                self.isAnimating = false
                self.triggerAnimation()
            }
        case "sizeDecrease":
            self.isAnimating = true
            heightConstraint.constant = 0.0
            UIView.animate(withDuration: 1.0, animations: {
                self.view.layoutIfNeeded()
            }) { (complete) in
                self.isAnimating = false
                self.triggerAnimation()
            }
        default:
            print("Unknown animation")
        }
    }

}

