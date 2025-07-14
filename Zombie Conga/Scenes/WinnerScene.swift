//
//  WinnerScene.swift
//  Zombie Conga
//
//  Created by Tornike Despotashvili on 7/14/25.
//

import SpriteKit

final class WinnerScene: BaseLevel {
  
  override func didMove(to view: SKView) {
    setupBg()
    setupPlayAgainButton()
    setupMainMenuButton()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else { return }
    let location = touch.location(in: self)
    let nodeTouch = atPoint(location)
    
    if nodeTouch.name == "playButton" {
      let level = GameManager.loadLevel(lvl: 1)
      view?.presentScene(level, transition: .crossFade(withDuration: 1))
    }
    
    if nodeTouch.name == "mainMenuButton" {
      let level = GameManager.loadLevel(lvl: 0)
      level.size = size
      view?.presentScene(level, transition: .crossFade(withDuration: 1))
    }
  }
  
  func setupBg() {
    let bg = SKSpriteNode(imageNamed: "winnerBG")
    bg.size.width = size.width
    bg.size.height = size.height
    bg.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    bg.position = CGPoint(x: size.width / 2, y: size.height / 2)
    bg.zPosition = -1
    
    addChild(bg)
  }
  
  func setupPlayAgainButton() {
    let button = SKSpriteNode(imageNamed: "playButton")
    button.name = "playButton"
    button.size = CGSize(width: 60, height: 60)
    button.position = CGPoint(x: size.width / 2 - 35, y: 70)
    button.zPosition = 2
    
    addChild(button)
  }
  
  func setupMainMenuButton() {
    let button = SKSpriteNode(imageNamed: "mainMenuButton")
    button.name = "mainMenuButton"
    button.size = CGSize(width: 60, height: 60)
    button.position = CGPoint(x: size.width / 2 + 35, y: 70)
    button.zPosition = 2
    
    addChild(button)
  }
}
