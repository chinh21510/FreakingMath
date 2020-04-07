//
//  ViewController.swift
//  test
//
//  Created by Chinh Dinh on 4/1/20.
//  Copyright © 2020 Chinh Dinh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var question = Question(description: "a", isTrue: true)
    var isHidden = true
    var timer = Timer()
    var scores: [Int] = []
    var checkIf = true
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var whenLoseUIView: UIImageView!
    @IBOutlet weak var gameOverLabel: UILabel!
    @IBOutlet weak var newScoreLabel: UILabel!
    @IBOutlet weak var bestScoreLabel: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var timeProgress: UIProgressView!
    @IBOutlet weak var replayButtonDidTap: UIButton!
    
    func newQuestion() -> Question{
        let lhs = Int.random(in: 0...10)
        let rhs = Int.random(in: 0...10)
        let isTrue = Bool.random()
        let description: String
        if isTrue {
            description = "\(lhs)+\(rhs)\n=\(lhs + rhs)\n"
        } else {
            var offset = 0
            while offset == 0 {
                offset = Int.random(in: -2...2)
            }
            description = "\(lhs)+\(rhs)\n=\(lhs + rhs + offset)\n "
        }
        label.text = "\(description)"
        return Question(description: description, isTrue: isTrue)
    }
    func hidden() {
        let a = Int(score.text!)!
        var bestScore = 0
        label.isHidden = true
        whenLoseUIView.isHidden = false
        gameOverLabel.isHidden = false
        newScoreLabel.isHidden = false
        newScoreLabel.text = "New \(a)"
        scores.append(a)
        bestScoreLabel.isHidden = false
        for score in scores {
            if bestScore < score {
                bestScore = score
            }
        }
        bestScoreLabel.text = "Best: \(bestScore)"
    }
    @IBAction func trueButtonDidTap(_ sender: Any) {
       let a = Int(score.text!)!
       if question.isTrue {
            score.text = "\(a + 1)"
            self.question = newQuestion()
            timeProgress.progress = 1
            timer.invalidate()
            times()
       } else {
            hidden()
            score.text = "0"
            timeProgress.progress = 0
       }
    }
    @IBAction func falseButtonDidTap(_ sender: Any) {
        let a = Int(score.text!)!
        if !question.isTrue {
            score.text = "\(a + 1)"
            self.question = newQuestion()
            timeProgress.progress = 1
            timer.invalidate()
            times()
        } else {
            hidden()
            score.text = "0"
            timeProgress.progress = 0
        }
 
    }
    @IBAction func replayButtonDidTap(_ sender: Any) {
        let question = newQuestion()
        gameOverLabel.isHidden = true
        newScoreLabel.isHidden = true
        bestScoreLabel.isHidden = true
        whenLoseUIView.isHidden = true
        label.text = "\(question)"
    }
    
    func times() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
    }
    @objc func runTimedCode() {
        timeProgress.progress -= 0.001
        if timeProgress.progress == 0 {
            hidden()
            score.text = "0"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.question = newQuestion()
        whenLoseUIView.isHidden = true
        gameOverLabel.isHidden = true
        newScoreLabel.isHidden = true
        bestScoreLabel.isHidden = true
    }
}

