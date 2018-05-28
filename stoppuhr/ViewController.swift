//
//  ViewController.swift
//  stoppuhr
//
//  Created by Filip Nikolić on 11.05.18.
//  Copyright © 2018 Filip Nikolić. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var stopWatchButtons: [UIButton]!
    
    var seconds = 0
    var running = false
    var timer = Timer()
    
    var roundTimes = [String]()
    
    let formatter = DateComponentsFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        updateTimeLabel()
        tableView.dataSource = self
        //Start button als erstes danach Stop button in collection
        stopWatchButtons = stopWatchButtons.sorted { $0.tag < $1.tag}
    }
    
    func updateTimeLabel() {
        if let formattedString =  formatter.string(from: TimeInterval(seconds)) {
            timeLabel.text = formattedString
        }
    }
    
    @objc func countUp() {
        seconds += 1
        updateTimeLabel()
    }
    
    func startTimer() {
        if running { return }
        timer = Timer.scheduledTimer(timeInterval:  1, target: self, selector: #selector(countUp), userInfo: nil, repeats: true)
        running = true
    }
    
    func stopTimer() {
        timer.invalidate()
        running = false
    }
    
    func resetTimer() {
        stopTimer()
        seconds = 0
        updateTimeLabel()
        roundTimes.removeAll()
        tableView.reloadData()
        
        set(title: "Start", for: 0)
        set(title: "Stop", for: 1)
    }
    
    func set(title: String, for buttonIndex: Int){
        stopWatchButtons[buttonIndex].setTitle(title, for: .normal)
    }

    @IBAction func buttonHandel(_ sender: UIButton) {
        if let title = sender.titleLabel?.text{
            switch title {
            case "Start":
            startTimer()
            set(title: "Round", for: 0)
            set(title: "Stop", for: 1)
            case "Stop":
            stopTimer()
            set(title: "Start", for: 0)
            set(title: "Reset", for: 1)
            case "Round":
                if let time = timeLabel.text {
                    roundTimes.append(time)
                    tableView.reloadData()
                }
            case "Reset":
            resetTimer()
            default:
                break
            }
        }
    }
}


extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roundTimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoundTableViewCell", for: indexPath)
        cell.textLabel?.text = roundTimes[indexPath.row]
        return cell
    }
    
}










