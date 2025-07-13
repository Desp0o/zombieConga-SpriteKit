//
//  BaseLevel.swift
//  Zombie Conga
//
//  Created by Tornike Despotashvili on 7/2/25.
//

import SpriteKit

class BaseLevel: SKScene, SKPhysicsContactDelegate {
  let scoreLabel: SKLabelNode = SKLabelNode()
  
  override func didMove(to view: SKView) {
    self.physicsWorld.contactDelegate = self
  }

  func setupSettingsButton() {
    let settingsButton = SKSpriteNode(imageNamed: "settingsButton")
    settingsButton.name = "settingsButton"
    settingsButton.size = CGSize(width: 40, height: 40)
    settingsButton.position = CGPoint(x: size.width - 60, y: size.height - 40)
    
    addChild(settingsButton)
  }
  
  func setUpScoreLabel(camera: SKCameraNode) {
    scoreLabel.text = "0"
    scoreLabel.fontColor = .green
    scoreLabel.fontSize = 30
    scoreLabel.fontName = "Helvetica Bold"
    scoreLabel.zPosition = 10
    scoreLabel.position = CGPoint(x: camera.position.x + size.width / 2 - 40, y: camera.position.y + size.height / 2 - 50)
    
    camera.addChild(scoreLabel)
  }
  
  func showScoreLabel(score: Int) {
    scoreLabel.text = "\(score)"
  }
}

