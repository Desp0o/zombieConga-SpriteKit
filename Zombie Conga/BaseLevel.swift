//
//  BaseLevel.swift
//  Zombie Conga
//
//  Created by Tornike Despotashvili on 7/2/25.
//

import SpriteKit

class BaseLevel: SKScene {
  let zombie = SKSpriteNode(imageNamed: "zombie1")

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
  
  func moveZombie(location: CGPoint) {
    let zombieX: CGFloat = zombie.position.x
    let zombieY: CGFloat = zombie.position.y
    
    let offset: CGPoint = CGPointMake(location.x - zombieX, location.y - zombieY)
    let distance: CGFloat = sqrt(offset.x * offset.x + offset.y * offset.y)
    let speed: CGFloat = 300.0
    let duration: CGFloat = distance / speed
    let direction: CGPoint = CGPoint(x: offset.x / distance, y: offset.y / distance)
    let angle: CGFloat = atan2(direction.y, direction.x)
    
    let move = SKAction.move(to: location, duration: duration)
    let rotate = SKAction.rotate(toAngle: angle, duration: 0.2, shortestUnitArc: true)
    let stopAnimation = SKAction.run {
      self.zombie.removeAction(forKey: "zombieWalk")
    }
    
    zombie.removeAllActions()
    animateZombieWalk()
    zombie.run(rotate)
    zombie.run(SKAction.sequence([move, stopAnimation]))
    
  }
  
  func animateZombieWalk() {
    let textures: [SKTexture] = [
      SKTexture(imageNamed: "zombie1"),
      SKTexture(imageNamed: "zombie2"),
      SKTexture(imageNamed: "zombie3"),
      SKTexture(imageNamed: "zombie4")
    ]
    
    let animation = SKAction.animate(with: textures, timePerFrame: 0.1)
    let repeatAnimation = SKAction.repeatForever(animation)
    
    zombie.run(repeatAnimation, withKey: "zombieWalk")
  }
}

