//
//  MainMenu.swift
//  Zombie Conga
//
//  Created by Tornike Despotashvili on 7/2/25.
//

import SpriteKit

final class MainMenu: BaseLevel {
  
  override func didMove(to view: SKView) {
    view.scene?.scaleMode = .fill
    
    setupBG()
    setupStartButton()
    setupSettingsButton()
  }
  
  func setupBG() {
    let bg = SKSpriteNode(imageNamed: "MainMenu")
    bg.size.width = size.width
    bg.size.height = size.height
    bg.anchorPoint = CGPoint(x: 0.0, y: 0.0)
    bg.position = CGPoint(x: 0, y: 0)
    bg.zPosition = -1
    addChild(bg)
  }
  
  func setupStartButton() {
    let playButton = SKSpriteNode(imageNamed: "playButton")
    playButton.name = "playButton"
    playButton.position = CGPoint(x: size.width / 2, y: size.height / 2)
    
    addChild(playButton)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else { return }
    let location = touch.location(in: self)
    let nodeTouch = atPoint(location)
    
    if nodeTouch.name == "settingsButton" {
      let level = GameManager.loadLevel(lvl: 1)
      view?.presentScene(level, transition: .crossFade(withDuration: 0.5))
    }
    
    if nodeTouch.name == "playButton" {
      let level = GameManager.loadLevel(lvl: 1)
      view?.presentScene(level, transition: .crossFade(withDuration: 1))
    }
  }
}
