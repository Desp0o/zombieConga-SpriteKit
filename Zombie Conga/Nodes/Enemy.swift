//
//  Enemy.swift
//  Zombie Conga
//
//  Created by Tornike Despotashvili on 7/3/25.
//

import SpriteKit

final class Enemy: SKSpriteNode {
  
  init() {
    let texture = SKTexture(imageNamed: "enemy")
    super.init(texture: texture, color: .clear, size: texture.size())
    
    self.name = "enemy"
    self.position = CGPoint(x: size.width / 2, y: size.height / 2)
    self.setScale(0.3)
    self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
    self.physicsBody?.isDynamic = true
    self.physicsBody?.affectedByGravity = false
    self.physicsBody?.usesPreciseCollisionDetection = true
    self.physicsBody?.categoryBitMask = CategoryBitmask.enemy
    self.physicsBody?.collisionBitMask = CategoryBitmask.player
    self.physicsBody?.contactTestBitMask = CategoryBitmask.player
    self.physicsBody?.mass = 10.0
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func generateEnemyPosition(sprite: SKSpriteNode) {
    let posX: CGFloat = sprite.position.x + (UIScreen.main.bounds.maxX + self.frame.width)
    let posY: CGFloat = CGFloat.random(in: (self.frame.height / 2)...(UIScreen.main.bounds.maxY - self.frame.height / 2))
    
    self.position = CGPoint(x: posX, y: posY)
  }
}
