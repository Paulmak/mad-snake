//
//  MainView.swift
//  mad-snake
//
//  Created by Pavel on 17.08.2025.
//

import UIKit

private enum Layout {
    static let controlButtonWidth: CGFloat = 84
    static let controlButtonHeight: CGFloat = 60
    static let controlsContainerWidth: CGFloat = 176
    static let controlsContainerHeight: CGFloat = 126
    static let gameFieldTopInset: CGFloat = 20
    static let playButtonHeight: CGFloat = 60
    static let foodCornerRadius: CGFloat = 12.5
}

final class GameMainView: UIView {
    
    private var score = 0
    
    private(set) lazy var gameFieldView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gameFieldViewColor
        return view
    }()
    
    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "Счет \(score)")
        attributedString.addAttribute(
            .font,
            value: UIFont(name: "TT Norms", size: 26) ?? .systemFont(ofSize: 26),
            range: NSRange(location: 0, length: attributedString.length)
        )
        attributedString.addAttribute(
            .foregroundColor,
            value: UIColor.white,
            range: NSRange(location: 0, length: attributedString.length)
        )
        label.attributedText = attributedString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .playButtonsColor
        button.setImage(.playButton, for: .normal)
        return button
    }()
    
    private(set) lazy var controlsContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gameMainViewColor
        return view
    }()
    
    private(set) lazy var upControlButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .playButtonsColor
        button.setImage(.upControl, for: .normal)
        return button
    }()
    
    private(set) lazy var downControlButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .playButtonsColor
        button.setImage(.downControl, for: .normal)
        return button
    }()
    
    private(set) lazy var leftControlButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .playButtonsColor
        button.setImage(.leftControl, for: .normal)
        return button
    }()
    
    private(set) lazy var rightControlButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .playButtonsColor
        button.setImage(.rightControl, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor = .gameMainViewColor
    }
    
    private func configureSubviews() {
        addSubview(gameFieldView)
        addSubview(scoreLabel)
        addSubview(playButton)
        addSubview(controlsContainer)
        controlsContainer.addSubview(leftControlButton)
        controlsContainer.addSubview(rightControlButton)
        controlsContainer.addSubview(upControlButton)
        controlsContainer.addSubview(downControlButton)
    }
    
    func render(snake: [CGPoint], food: CGPoint?, segmentSize: CGFloat, score: Int) {
        gameFieldView.subviews.forEach { $0.removeFromSuperview() }
        
        for (i, p) in snake.enumerated() {
            let seg = UIView(frame: CGRect(x: p.x * segmentSize,
                                           y: p.y * segmentSize,
                                           width: segmentSize,
                                           height: segmentSize))
            seg.backgroundColor = (i == 0) ? .snakeHeadColor : .snakeTailColor
            gameFieldView.addSubview(seg)
        }
        
        if let f = food {
            let foodView = UIView(frame: CGRect(x: f.x * segmentSize,
                                                y: f.y * segmentSize,
                                                width: segmentSize,
                                                height: segmentSize))
            foodView.layer.cornerRadius = Layout.foodCornerRadius
            foodView.backgroundColor = .foodColor
            gameFieldView.addSubview(foodView)
        }
        
        scoreLabel.text = "Счёт: \(score)"
    }
    
    private func configureConstraints() {
        
        NSLayoutConstraint.activate([
            gameFieldView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            gameFieldView.leadingAnchor.constraint(equalTo: leadingAnchor),
            gameFieldView.trailingAnchor.constraint(equalTo: trailingAnchor),
            gameFieldView.bottomAnchor.constraint(equalTo: controlsContainer.topAnchor, constant: -20),
            
            scoreLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            scoreLabel.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -10),
            scoreLabel.topAnchor.constraint(equalTo: controlsContainer.topAnchor),
            
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            playButton.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 10),
            playButton.trailingAnchor.constraint(equalTo: controlsContainer.leadingAnchor, constant: -15),
            playButton.heightAnchor.constraint(equalToConstant: Layout.playButtonHeight),
            playButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            controlsContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            controlsContainer.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            controlsContainer.widthAnchor.constraint(equalToConstant: Layout.controlsContainerWidth),
            controlsContainer.heightAnchor.constraint(equalToConstant: Layout.controlsContainerHeight),
            
            upControlButton.leadingAnchor.constraint(equalTo: controlsContainer.leadingAnchor),
            upControlButton.bottomAnchor.constraint(equalTo: controlsContainer.bottomAnchor),
            upControlButton.widthAnchor.constraint(equalToConstant: Layout.controlButtonWidth),
            upControlButton.heightAnchor.constraint(equalToConstant: Layout.controlButtonHeight),
            
            downControlButton.trailingAnchor.constraint(equalTo: controlsContainer.trailingAnchor),
            downControlButton.bottomAnchor.constraint(equalTo: controlsContainer.bottomAnchor),
            downControlButton.widthAnchor.constraint(equalToConstant: Layout.controlButtonWidth),
            downControlButton.heightAnchor.constraint(equalToConstant: Layout.controlButtonHeight),
            
            leftControlButton.topAnchor.constraint(equalTo: controlsContainer.topAnchor),
            leftControlButton.leadingAnchor.constraint(equalTo: controlsContainer.leadingAnchor),
            leftControlButton.widthAnchor.constraint(equalToConstant: Layout.controlButtonWidth),
            leftControlButton.heightAnchor.constraint(equalToConstant: Layout.controlButtonHeight),
            
            rightControlButton.topAnchor.constraint(equalTo: controlsContainer.topAnchor),
            rightControlButton.trailingAnchor.constraint(equalTo: controlsContainer.trailingAnchor),
            rightControlButton.widthAnchor.constraint(equalToConstant: Layout.controlButtonWidth),
            rightControlButton.heightAnchor.constraint(equalToConstant: Layout.controlButtonHeight),
        ])
    }
}
