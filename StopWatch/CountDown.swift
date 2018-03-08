//
//  CountDown.swift
//  StopWatch
//
//  Created by Aissam Erradouane B on 2/26/18.
//  Copyright © 2018 Aissam Erradouane. All rights reserved.
//

import UIKit
import AVFoundation

class CountDown: UIViewController , UIPickerViewDataSource, UIPickerViewDelegate {

    
    
    
    @IBAction func start(_ sender: Any) {
        if isTimerRunning == false{
            runTimer()
            stopSound()
        }

    }
    

    
    @IBAction func stop(_ sender: Any) {
        if isTimerRunning == true {
            stopTimer()
            stopSound()
        }
    }
    @IBOutlet weak var screen: UILabel!
    
    
    @IBOutlet weak var secpickview: UIPickerView!
    
    var numbers = [Int]()
   
    var time = [0,0,0]
    var timer = Timer()
    var isTimerRunning = false
    var player : AVAudioPlayer?
    let sound = Bundle.main.url(forResource: "Repealer", withExtension: "m4a")
    var issoundRunning = false
    var savedTimer = [0,0,0]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        secpickview.delegate=self
        secpickview.dataSource=self
        
        for i in 0...60 {
            numbers.append(i)
        }
        
        
        
    }
    
    func playSound(){
        
        if issoundRunning == false{
        
        do{
            player = try AVAudioPlayer(contentsOf: sound!)
            guard let player = player else { return }
            player.prepareToPlay()
            player.play()
            issoundRunning = true
        }
        catch let error {
            print(error.localizedDescription)
        }
        }
    }
    
    func stopSound(){
        if issoundRunning == true{
                player?.stop()
                issoundRunning = false
        }
    }
    
    
    
    func runTimer(){
        
        isTimerRunning = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(CountDown.updateTimer)), userInfo: nil, repeats: true)
    }
    
    
    
    func stopTimer(){
        isTimerRunning = false
        timer.invalidate()
        
    }
    
    func updateTimer(){
        
        if time[2] > 0 {
            time[2] -= 1
            screen.text = "\(time[0]) : \(time[1]) : \(time[2])"
        }else{
            time[2] = 59
            if time[1] > 0 {
                time[1] -= 1
                screen.text = "\(time[0]) : \(time[1]) : \(time[2])"
            }else{
                if time[0] > 0{
                    time[1] = 59
                    time[0] -= 1
                    screen.text = "\(time[0]) : \(time[1]) : \(time[2])"
                } else{
                    stopTimer()
                    playSound()
                    screen.text = "CountDown Ended"
                    time=savedTimer
                    
                }
            }
        }
        
        
        }
        
        
        
        
    
    
    

        
        
        
        
  

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numbers.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numbers[row])"
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        stopSound()
        time[component]=numbers[row]
        screen.text = "\(time[0]) : \(time[1]) : \(time[2])"
        savedTimer=time
    }
    
}
