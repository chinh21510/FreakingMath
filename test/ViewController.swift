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
    var bestScore = 0
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var gameOverLabel: UILabel!
    @IBOutlet weak var newScoreLabel: UILabel!
    @IBOutlet weak var bestScoreLabel: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var timeProgress: UIProgressView!
    @IBOutlet weak var trueImageView: UIImageView!
    @IBOutlet weak var falseImageView: UIImageView!
    @IBOutlet weak var replayImageView: UIImageView!
    @IBOutlet weak var gameOverUIview: UIView!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var replayButton: UIButton!
    
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
        return Question(description: description, isTrue: isTrue, timeLeft: 2)
    }
    
    func lose() {
        let a = Int(score.text!)!
        label.isHidden = true
        gameOverUIview.isHidden = false
        if a > bestScore {
            bestScore = a
        }
        newScoreLabel.text = "New \(a)"
        bestScoreLabel.text = "Best \(bestScore)"
        replayButton.isHidden = false
        replayImageView.isHidden = false
        trueButton.isUserInteractionEnabled = false
        falseButton.isUserInteractionEnabled = false
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
            lose()
            timer.invalidate()
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
            lose()
            timer.invalidate()
        }
    }
    
    @IBAction func replayButtonDidTap(_ sender: Any) {
        label.isHidden = false
        timer.invalidate()
        originalScreen()
    }
    
    func times() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
    }
    
    @objc func runTimedCode() {
        question.timeLeft = question.timeLeft - 0.01
        timeProgress.progress = Float(question.timeLeft / 2.0)
        if timeProgress.progress == 0 {
            lose()
        }
    }
    
    func createShadow(view: UIView, color: UIColor, alpha: Float, width: CGFloat, height: CGFloat) {
        view.layer.shadowColor = color.cgColor
        view.layer.shadowOffset = CGSize(width: width, height: height)
        view.layer.shadowOpacity = alpha
        view.layer.shadowRadius = 0
        view.layer.cornerRadius = view.bounds.size.width / 20
    }
    
    func originalScreen() {
        self.question = newQuestion()
        timeProgress.progress = 1
        score.text = "0"
        gameOverUIview.isHidden = true
        replayButton.isHidden = true
        replayImageView.isHidden = true
        trueButton.isUserInteractionEnabled = true
        falseButton.isUserInteractionEnabled = true
        
        createShadow(view: gameOverUIview, color: UIColor.black, alpha: 0.5, width: 0, height: 5.0)
        createShadow(view: replayButton, color: UIColor.white, alpha: 0.8, width: 0.0, height: 5.0 )
        createShadow(view: trueButton, color: UIColor.white, alpha: 0.8, width: 0.0, height: 8.0)
        createShadow(view: falseButton, color: UIColor.white, alpha: 0.8, width: 0.0, height: 8.0)
        
        trueImageView.layer.cornerRadius = trueImageView.bounds.size.width / 20
        falseImageView.layer.cornerRadius = falseImageView.bounds.size.width / 20
        replayImageView.layer.cornerRadius = replayImageView.bounds.size.width / 20
        
        label.font = label.font.withSize(self.view.frame.height * 0.08)
        gameOverLabel.font = gameOverLabel.font.withSize(self.view.frame.height * 0.04)
        newScoreLabel.font = newScoreLabel.font.withSize(self.view.frame.height * 0.04)
        bestScoreLabel.font = bestScoreLabel.font.withSize(self.view.frame.height * 0.04)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        originalScreen()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
}
