//
//  BaseLevel.swift
//  Zombie Conga
//
//  Created by Tornike Despotashvili on 7/2/25.
//

import SpriteKit

class BaseLevel: SKScene {
  let zombie = Zombie()

  func setupSettingsButton() {
    let settingsButton = SKSpriteNode(imageNamed: "settingsButton")
    settingsButton.name = "settingsButton"
    settingsButton.size = CGSize(width: 40, height: 40)
    settingsButton.position = CGPoint(x: size.width - 60, y: size.height - 40)
    
    addChild(settingsButton)
  }
  
  func setupZombie() {
    zombie.position = CGPoint(x: 100, y: UIScreen.main.bounds.height / 2)
    zombie.size = CGSize(width: 70, height: 70)
    addChild(zombie)
  }
}

