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

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var gameOverUIview: UIImageView!
    @IBOutlet weak var gameOver: UILabel!
    @IBOutlet weak var newScore: UILabel!
    @IBOutlet weak var best: UILabel!
    @IBOutlet weak var score: UILabel!
    
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
    
    @IBAction func trueButtonDidTap(_ sender: Any) {
        
        let a = Int(score.text!)!
        if question.isTrue {
            score.text = "\(a + 1)"
            self.question = newQuestion()
        } else {
            score.text = "0"
            gameOverUIview.isHidden = false
            gameOver.isHidden = false
            newScore.isHidden = false
            newScore.text = "New \(a)"
            best.isHidden = false
            
        }
        
    }
    @IBAction func falseButtonDidTap(_ sender: Any) {
        let a = Int(score.text!)!
        if !question.isTrue {
            score.text = "\(a + 1)"
            self.question = newQuestion()
        } else {
            score.text = "0"
            gameOverUIview.isHidden = false
            gameOver.isHidden = false
            newScore.isHidden = false
            newScore.text = "New \(a)"
            best.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.question = newQuestion()
        gameOverUIview.isHidden = true
        gameOver.isHidden = true
        newScore.isHidden = true
        best.isHidden = true
    }
    
    
   
    
}

