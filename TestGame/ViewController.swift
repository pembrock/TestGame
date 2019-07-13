//
//  ViewController.swift
//  TestGame
//
//  Created by Pasikuta Kirill on 08.07.2019.
//  Copyright © 2019 Pasikuta Kirill. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gameFieldView: GameFieldView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var gameController: GameControllerViewClass!
    
    private var gameTimer: Timer?
    private var timer: Timer?
    private var displayDuration: TimeInterval = 2
    private var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        gameFieldView.layer.borderWidth = 1
        gameFieldView.layer.borderColor = UIColor.gray.cgColor
        gameFieldView.layer.cornerRadius = 5
        updateUI()
        gameFieldView.shapeHitHandler = {[weak self] in self?.objectTapped()}
        gameController.startStopHandler = {[weak self] in self?.actionButtonTapped()}
        gameController.gameDuration = 20
    }

    
    func objectTapped() {
        guard gameController.isGameActive else { return }
        repositionImageWithTimer()
        score += 1
    }
    
    private func startGame() {
        score = 0
        repositionImageWithTimer()
        gameTimer?.invalidate()
        gameTimer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(gameTimerTick),
            userInfo: nil,
            repeats: true
        )
        gameController.gameTimeLeft = gameController.gameDuration
        gameController.isGameActive = true
        updateUI()
    }
    
    private func stopGame() {
        gameController.isGameActive = false
        updateUI()
        gameTimer?.invalidate()
        timer?.invalidate()
        scoreLabel.text = "Последний счет: \(score)"
    }
    
    private func repositionImageWithTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(
            timeInterval: displayDuration,
            target: self,
            selector: #selector(moveImage),
            userInfo: nil,
            repeats: true
        )
        timer?.fire()
    }
    
    private func updateUI() {
        gameFieldView.isShapeHidden = !gameController.isGameActive
    }
    
    @objc private func gameTimerTick() {
        gameController.gameTimeLeft -= 1
        if gameController.gameTimeLeft <= 0 {
            stopGame()
        } else {
            updateUI()
        }
    }
    
    @objc private func moveImage() {
        gameFieldView.randomizeShapes()
    }
    
    func actionButtonTapped() {
        if gameController.isGameActive {
            stopGame()
        } else {
            startGame()
        }
        
    }
}

