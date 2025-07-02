//
//  BaseLevel.swift
//  Zombie Conga
//
//  Created by Tornike Despotashvili on 7/2/25.
//

import SpriteKit

class BaseLevel: SKScene, SKPhysicsContactDelegate {
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
}

