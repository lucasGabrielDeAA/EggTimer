//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    enum Hardness: String {
        case soft = "Soft"
        case medium = "Medium"
        case hard = "Hard"
    }
    
    @IBOutlet weak var progressTimer: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let hardnessValues = [Hardness.soft: 300, Hardness.medium: 480, Hardness.hard: 720]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    var player: AVAudioPlayer?

    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        progressTimer.progress = 0
        secondsPassed = 0
        
        totalTime = hardnessValues[ViewController.Hardness(rawValue: sender.currentTitle!)!]!
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressTimer.progress = Float(secondsPassed) / Float(totalTime)
        } else {
            timer.invalidate()
            titleLabel.text = "Your egg is done!"
            playAlarm()
        }
    }
    
    func playAlarm() {
        guard let soundFileUrl = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            
            player = try AVAudioPlayer(contentsOf: soundFileUrl, fileTypeHint: AVFileType.wav.rawValue)
            player?.numberOfLoops = 0
            player?.volume = 1
            player?.prepareToPlay()
            
            guard let player = player else { return }
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
