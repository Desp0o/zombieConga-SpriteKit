//
//  BaseLevel.swift
//  Zombie Conga
//
//  Created by Tornike Despotashvili on 7/2/25.
//

import SpriteKit

class BaseLevel: SKScene, SKPhysicsContactDelegate {
  let scoreLabel: SKLabelNode = SKLabelNode()
  var hearts: [SKSpriteNode] = []
  var lives: Int = 3
  
  override func didMove(to view: SKView) {
    self.physicsWorld.contactDelegate = self
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
  
  func setupHearts(camera: SKCameraNode) {
    let posX = camera.position.x - size.width / 2 + 50
    let posY = camera.position.y + size.height / 2 - 40
    
    for i in 0..<3 {
      let heart = SKSpriteNode(imageNamed: "heart")
      heart.size = CGSize(width: 50, height: 50)
      heart.position = CGPoint(x: posX + CGFloat(i * 40), y: posY)
      heart.setScale(0.5)
      heart.zPosition = 100
      camera.addChild(heart)
      hearts.append(heart)
    }
  }
  
  func loseLife() {
    lives -= 1
    
    if lives >= 0 && lives < hearts.count {
      hearts[lives].isHidden = true
    }
    
    if lives == 0 {
      let level = GameManager.loadLevel(lvl: 2)
      level.size = size
      view?.presentScene(level, transition: .crossFade(withDuration: 0.5))
    }
  }
}

