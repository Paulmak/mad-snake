//
//  SnakeGameCore.swift
//  mad-snake
//
//  Created by Pavel on 20.08.2025.
//

import UIKit

protocol SnakeGameEngine {
    var snake: [CGPoint] { get }
    var food: CGPoint? { get }
    var score: Int { get }
    var state: GameState { get }
    
    mutating func step()
    mutating func restart()
    mutating func changeDirection(to direction: Direction)
}

enum GameState {
    case running
    case gameOver
}

enum Direction {
    case up, down, left, right
    
    var vector: CGPoint {
        switch self {
        case .up: return CGPoint(x: 0, y: -1)
        case .down: return CGPoint(x: 0, y: 1)
        case .left: return CGPoint(x: -1, y: 0)
        case .right: return CGPoint(x: 1, y: 0)
        }
    }
}

struct SnakeGameCore: SnakeGameEngine {
    
    private(set) var snake: [CGPoint] = []
    private(set) var food: CGPoint?
    private(set) var direction: Direction = .right
    private(set) var score: Int = 0
    private(set) var state: GameState = .running
    
    private let cols: Int
    private let rows: Int
    
    init(cols: Int, rows: Int) {
        self.cols = cols
        self.rows = rows
        reset()
    }
    
    private mutating func reset() {
        score = 0
        direction = .right
        snake = [CGPoint(x: 5, y: 5), CGPoint(x: 4, y: 5)]
        spawnFood()
    }
    
    mutating func restart() {
        reset()
        state = .running
    }
    
    mutating func step() {
        guard let head = snake.first else { return }
        let newHead = nextHeadPosition(from: head)
        
        // Выход за границы
        if newHead.x < 0 || newHead.y < 0 ||
            Int(newHead.x) >= cols || Int(newHead.y) >= rows {
            state = .gameOver
            return
        }
        
        // Столкновение с собой
        if snake.contains(newHead) {
            state = .gameOver
            return
        }
        
        // Столкновение с едой
        if newHead == food {
            snake.insert(newHead, at: 0)
            score += 1
            spawnFood()
        } else {
            snake.insert(newHead, at: 0)
            snake.removeLast()
        }
    }
    
    private func nextHeadPosition(from head: CGPoint) -> CGPoint {
        CGPoint(x: head.x + direction.vector.x, y: head.y + direction.vector.y)
    }
    
    mutating func spawnFood() {
        food = CGPoint(
            x: Int.random(in: 0..<cols),
            y: Int.random(in: 0..<rows)
        )
    }
    
    mutating func changeDirection(to newDirection: Direction) {
        switch (direction, newDirection) {
        case (.up, .down), (.down, .up),
            (.left, .right), (.right, .left):
            return
        default:
            direction = newDirection
        }
    }
}
