//
//  Zombie.swift
//  Zombie Conga
//
//  Created by Tornike Despotashvili on 7/2/25.
//

import SpriteKit

class Zombie: SKSpriteNode {
  var takenCatsCount: Int = 0
  
  let walkTextures: [SKTexture] = [
    SKTexture(imageNamed: "zombie1"),
    SKTexture(imageNamed: "zombie2"),
    SKTexture(imageNamed: "zombie3"),
    SKTexture(imageNamed: "zombie4")
  ]
  
  init() {
    let texture = SKTexture(imageNamed: "zombie1")
    super.init(texture: texture, color: .clear, size: texture.size())
    self.setScale(0.3)
    self.name = "zombie"
    self.physicsBody = SKPhysicsBody(rectangleOf: self.frame.size)
    self.physicsBody?.isDynamic = true
    self.physicsBody?.affectedByGravity = false
    self.physicsBody?.usesPreciseCollisionDetection = true
    self.physicsBody?.categoryBitMask = CategoryBitmask.player
    self.physicsBody?.collisionBitMask = CategoryBitmask.enemy
    self.physicsBody?.contactTestBitMask = CategoryBitmask.enemy
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func moveZombie(location: CGPoint) {
    let zombieX: CGFloat = self.position.x
    let zombieY: CGFloat = self.position.y
    
    let offset: CGPoint = CGPoint(x: location.x - zombieX, y: location.y - zombieY)
    let distance: CGFloat = sqrt(offset.x * offset.x + offset.y * offset.y)
    let speed: CGFloat = 350.0
    let duration: CGFloat = distance / speed
    let direction: CGPoint = CGPoint(x: offset.x / distance, y: offset.y / distance)
    let angle: CGFloat = atan2(direction.y, direction.x)
    
    let move = SKAction.move(to: location, duration: duration)
    let rotate = SKAction.rotate(toAngle: angle, duration: 0.2, shortestUnitArc: true)
    let stopAnimation = SKAction.run { [weak self] in
      self?.removeAction(forKey: "zombieWalk")
    }
    
    self.removeAction(forKey: "zombieMoveAction")
    animateZombieWalk()
    self.run(rotate)
    self.run(SKAction.sequence([move, stopAnimation]), withKey: "zombieMoveAction")
    
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
    
    self.run(repeatAnimation, withKey: "zombieWalk")
  }
}
