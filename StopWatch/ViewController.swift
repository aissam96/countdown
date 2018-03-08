//
//  ViewController.swift
//  StopWatch
//
//  Created by Aissam Erradouane B on 2/12/18.
//  Copyright © 2018 Aissam Erradouane. All rights reserved.
//


import UIKit

@IBDesignable

class ViewController: UIViewController {
    
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    
    var milseconds = 0
    var seconds = 0
    var max = 60
    var maxHours = 10
    var minutes = 0
    var hours = 0
    var pauseTapped = false
    
    var timer = Timer()
    var isTimerRunning = false
    
    @IBAction func start(_ sender: Any) {
        runTimer()
        pauseTapped = false
        isTimerRunning = true
    }
    @IBAction func pause(_ sender: Any) {
        if self.pauseTapped == false {
            timer.invalidate()
            self.pauseTapped = true
            isTimerRunning = false
        }
       
    }
    @IBAction func reset(_ sender: Any) {
        
        timer.invalidate()
        milseconds = 0
        seconds = 0
        minutes = 0
        hours = 0
        pauseTapped = true
        isTimerRunning = false
        label.text = "\(hours) : \(minutes) : \(seconds) : \(milseconds)"

    }
    @IBAction func timer(_ sender: Any) {
    }
  
    
    
    func runTimer(){
        if isTimerRunning == false{
        timer = Timer.scheduledTimer(timeInterval: 1/60, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
            isTimerRunning = true
        }
    }
    
    func updateTimer(){
        milseconds+=1
        
        
        switch max {
            
        case milseconds:
            seconds += 1
            milseconds = 0

        case seconds:
            seconds = 0
            minutes+=1
        case minutes:
            minutes = 0
            hours+=1

        default: break
        }
        
        if hours == maxHours {
            hours = 0
        }
        
        label.text = "\(hours) : \(minutes) : \(seconds) : \(milseconds)"

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // label.font = UIFont(name: "Helvetica Neue", size: 60)
        label.text = "\(hours) : \(minutes) : \(seconds) : \(milseconds)"

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

