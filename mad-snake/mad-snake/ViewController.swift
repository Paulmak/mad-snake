//
//  ViewController.swift
//  mad-snake
//
//  Created by Pavel on 17.08.2025.
//

import UIKit

final class ViewController: UIViewController {
    
    private let gameMainView = GameMainView()
    private var engine: SnakeGameEngine!
    private var timer: Timer?
    private var speed: TimeInterval = 0.3
    private var lastScore = 0
    private var segmentSize: CGFloat = 0
    private var isPaused = true
    
    override func loadView() {
        view = gameMainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if segmentSize == 0 {
            let gameField = gameMainView.gameFieldView.bounds
            segmentSize = gameField.width / 16
            
            let rows = Int(gameField.height / segmentSize)
            segmentSize = gameField.height / CGFloat(rows)
            engine = SnakeGameCore(cols: 16, rows: rows)
            
            render()
            setupControls()
        }
    }
    
    private func setupControls() {
        gameMainView.playButton.addTarget(self, action: #selector(togglePause), for: .touchUpInside)
        gameMainView.upControlButton.addTarget(self, action: #selector(up), for: .touchUpInside)
        gameMainView.downControlButton.addTarget(self, action: #selector(down), for: .touchUpInside)
        gameMainView.leftControlButton.addTarget(self, action: #selector(left), for: .touchUpInside)
        gameMainView.rightControlButton.addTarget(self, action: #selector(right), for: .touchUpInside)
    }
    
    @objc private func togglePause() {
        if engine.state == .gameOver {
            engine.restart()
            render()
            isPaused = true
        }
        
        if isPaused {
            startTimer()
            gameMainView.playButton.setImage(.pause, for: .normal)
        } else {
            timer?.invalidate()
            gameMainView.playButton.setImage(.playButton, for: .normal)
        }
        isPaused.toggle()
    }
    
    @objc private func step() {
        engine.step()
        render()
        
        if engine.state == .gameOver {
            timer?.invalidate()
            gameMainView.playButton.setImage(.runAgain, for: .normal)
            isPaused = true
        }
        
        if engine.score > lastScore {
            lastScore = engine.score
            speed *= 0.9
            startTimer()
        }
    }
    
    private func render() {
        gameMainView.render(snake: engine.snake,
                            food: engine.food,
                            segmentSize: segmentSize,
                            score: engine.score)
    }
    
    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: speed, repeats: true) { [weak self] _ in
            self?.step()
        }
    }
    
    @objc private func up() { engine.changeDirection(to: .up) }
    @objc private func down() { engine.changeDirection(to: .down) }
    @objc private func left() { engine.changeDirection(to: .left) }
    @objc private func right() { engine.changeDirection(to: .right) }
}
