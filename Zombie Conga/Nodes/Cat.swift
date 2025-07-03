//
//  Cat.swift
//  Zombie Conga
//
//  Created by Tornike Despotashvili on 7/3/25.
//

import SpriteKit

final class Cat: SKSpriteNode {
  init() {
    let texture = SKTexture(imageNamed: "cat")
    super.init(texture: texture, color: .clear, size: texture.size())
    
    setupCat()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupCat() {
    let scaledSize = CGSize(width: self.frame.size.width * 1.1,
                            height: self.frame.size.height * 1.1)
    self.name = "cat"
    self.physicsBody = SKPhysicsBody(rectangleOf: scaledSize)
    self.physicsBody?.isDynamic = true
    self.physicsBody?.affectedByGravity = false
    self.physicsBody?.usesPreciseCollisionDetection = true
    self.physicsBody?.categoryBitMask = CategoryBitmask.cat
    self.physicsBody?.collisionBitMask = CategoryBitmask.player
    self.physicsBody?.contactTestBitMask = CategoryBitmask.player
    self.setScale(0.3)
  }
  
  func generateCatPosition(around sprite: SKSpriteNode) {
    let distanceX = CGFloat.random(in: 100...UIScreen.main.bounds.maxX - self.frame.width / 2)
    let distanceY = CGFloat.random(in: 100...UIScreen.main.bounds.maxY - self.frame.height / 2)
    
    let positiveX = max(min(sprite.position.x + distanceX, UIScreen.main.bounds.maxX), UIScreen.main.bounds.minX)
    let positiveY = max(min(sprite.position.y + distanceY, UIScreen.main.bounds.maxY), UIScreen.main.bounds.minY)
    
    let negativeX = max(min(sprite.position.x - distanceX, UIScreen.main.bounds.maxX), UIScreen.main.bounds.minX)
    let negativeY = max(min(sprite.position.y - distanceY, UIScreen.main.bounds.maxY), UIScreen.main.bounds.minY)
    
    let randomX = CGFloat.random(in: negativeX...positiveX)
    let randomY = CGFloat.random(in: negativeY...positiveY)
    
    self.position = CGPoint(x: randomX, y: randomY)
  }
}
