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
    let relativeFontConstain1: CGFloat = 0.08
    let relativeFontConstain2: CGFloat = 0.04
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var gameOverLabel: UILabel!
    @IBOutlet weak var newScoreLabel: UILabel!
    @IBOutlet weak var bestScoreLabel: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var timeProgress: UIProgressView!
    @IBOutlet weak var replayUIButton: UIButton!
    
    @IBOutlet weak var trueImageView: UIImageView!
    
    @IBOutlet weak var falseImageView: UIImageView!
    
    
    @IBOutlet weak var falseUIButton: UIButton!
    
    @IBOutlet weak var gameOverUIview: UIView!
    
    @IBOutlet weak var trueUIButton: UIButton!
    
    
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
        var bestScore = 0
        label.isHidden = true
        gameOverUIview.isHidden = false
        scores.append(a)
        newScoreLabel.text = "New \(a)"
        for score in scores {
            if bestScore < score {
                bestScore = score
            }
        }
        bestScoreLabel.text = "Best \(bestScore)"
        replayUIButton.isHidden = false
        trueUIButton.isUserInteractionEnabled = false
        falseUIButton.isUserInteractionEnabled = false
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
    @IBAction func replay(_ sender: Any) {
        label.isHidden = false
        timer.invalidate()
        viewDidLoad()
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
    func createShadow(view: UIView, red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat, width: CGFloat, height: CGFloat, ratioCornerRadius: CGFloat, masks: Bool) {
        view.center = self.view.center
        view.layer.shadowColor = UIColor(red: red, green: green, blue: blue, alpha: alpha).cgColor
        view.layer.shadowOffset = CGSize(width: width, height: height)
        view.layer.shadowOpacity = 1.0
        view.layer.shadowRadius = 0
        view.layer.cornerRadius = view.bounds.size.width / ratioCornerRadius
        view.layer.masksToBounds = masks
    }
    override func viewDidLoad() {
        timeProgress.progress = 1
        super.viewDidLoad()
        self.question = newQuestion()
        score.text = "0"
        gameOverUIview.isHidden = true
        replayUIButton.isHidden = true
        trueUIButton.isUserInteractionEnabled = true
        falseUIButton.isUserInteractionEnabled = true
        
        let playIcon = UIImage(named: "playIcon-1")
        let playIconImage = playIcon?.withRenderingMode(.alwaysTemplate)
        replayUIButton.setImage(playIconImage, for: .normal)
        replayUIButton.tintColor = .blue
        
        createShadow(view: gameOverUIview, red: 0.0, green: 0.0, blue: 0.0, alpha: 0.6, width: 0, height: 5.0, ratioCornerRadius: 40, masks: false)
        createShadow(view: replayUIButton, red: 1, green: 1, blue: 1, alpha: 0.8, width: 0.0, height: 8.0, ratioCornerRadius: 20, masks: false)
        createShadow(view: trueUIButton, red: 1, green: 1, blue: 1, alpha: 0.8, width: 0.0, height: 8.0, ratioCornerRadius: 20, masks: false)
        createShadow(view: falseUIButton, red: 1, green: 1, blue: 1, alpha: 0.8, width: 0.0, height: 8.0, ratioCornerRadius: 20, masks: false)
       
        trueImageView.layer.cornerRadius = trueImageView.bounds.size.width / 20
        trueImageView.clipsToBounds = true
        
        
        falseImageView.layer.cornerRadius = falseImageView.bounds.size.width / 20
        falseImageView.clipsToBounds = true
        
        
        label.font = label.font.withSize(self.view.frame.height * relativeFontConstain1)
        gameOverLabel.font = gameOverLabel.font.withSize(self.view.frame.height * relativeFontConstain2)
        newScoreLabel.font = newScoreLabel.font.withSize(self.view.frame.height * relativeFontConstain2)
        bestScoreLabel.font = bestScoreLabel.font.withSize(self.view.frame.height * relativeFontConstain2)
        
    }
}
