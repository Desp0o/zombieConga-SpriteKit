//
//  BaseLevel.swift
//  Zombie Conga
//
//  Created by Tornike Despotashvili on 7/2/25.
//

import SpriteKit

class BaseLevel: SKScene {
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else { return }
    let location = touch.location(in: self)
    let nodeTouch = atPoint(location)
    
    if nodeTouch.name == "settingsButton" {
      let level = GameManager.loadLevel(lvl: 1)
      view?.presentScene(level, transition: .crossFade(withDuration: 1))
    }
  }
  
  func setupSettingsButton() {
    let settingsButton = SKSpriteNode(imageNamed: "settingsButton")
    settingsButton.name = "settingsButton"
    settingsButton.size = CGSize(width: 40, height: 40)
    settingsButton.position = CGPoint(x: size.width - 60, y: size.height - 40)
    
    addChild(settingsButton)
  }
}
