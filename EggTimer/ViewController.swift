//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    enum Hardness: String {
        case soft = "Soft"
        case medium = "Medium"
        case hard = "Hard"
    }
    
    let hardnessValues = [Hardness.soft: 300, Hardness.medium: 480, Hardness.hard: 720]
    var timeInterval = 0
    var timer = Timer()

    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        
        timeInterval = hardnessValues[ViewController.Hardness(rawValue: sender.currentTitle!)!]!
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if timeInterval > 0 {
            print("\(timeInterval) seconds")
            timeInterval -= 1
        } else {
            timer.invalidate()
        }
    }
    
}
