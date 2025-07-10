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
    let distanceX = CGFloat.random(in: 100...600)
    let distanceY = CGFloat.random(in: 100...200)
    
    let randomBoolX: CGFloat = Bool.random() ? 1 : -1
    let randomBoolY: CGFloat = Bool.random() ? 1 : -1
    
    var calculatedX = CGFloat((sprite.position.x + distanceX) * randomBoolX)
    var calculatedY = CGFloat((sprite.position.y + distanceY) * randomBoolY)
    
    if calculatedX > UIScreen.main.bounds.maxX {
      calculatedX = UIScreen.main.bounds.width
    }
    
    if calculatedX < UIScreen.main.bounds.minX {
      calculatedX = 30
    }
    
    if calculatedY > UIScreen.main.bounds.maxY {
      calculatedY = UIScreen.main.bounds.height
    }
    
    if calculatedY < UIScreen.main.bounds.minY {
      calculatedY = 30
    }
    
    self.position = CGPoint(x: calculatedX, y: calculatedY)
  }
}
