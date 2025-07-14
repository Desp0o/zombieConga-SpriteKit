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
    self.setScale(0)
    
    let scaleUp = SKAction.scale(to: 0.3, duration: 0.3)
    scaleUp.timingMode = .easeOut
    self.run(scaleUp)
    
    let wait = SKAction.wait(forDuration: 3)
    let scaleDown = SKAction.scale(to: 0, duration: 0.2)
    let remove = SKAction.removeFromParent()
    
    let sequence = SKAction.sequence([wait, scaleDown, remove])
    self.run(sequence)
  }
  
  func generateCatPosition(around sprite: SKSpriteNode, scene: SKScene) {
    guard let camera = scene.camera else { return }
    
    let distanceX = CGFloat.random(in: 100...600)
    let distanceY = CGFloat.random(in: 100...200)
    
    let randomBoolX: CGFloat = Bool.random() ? 1 : -1
    let randomBoolY: CGFloat = Bool.random() ? 1 : -1
    
    var calculatedX = camera.position.x + distanceX * randomBoolX
    var calculatedY = camera.position.y + distanceY * randomBoolY
    
    let screenWidth = scene.size.width
    let screenHeight = scene.size.height
    
    let minX = camera.position.x - screenWidth / 2 + 30
    let maxX = camera.position.x + screenWidth / 2 - 30
    let minY = camera.position.y - screenHeight / 2 + 30
    let maxY = camera.position.y + screenHeight / 2 - 30
    
    calculatedX = min(max(calculatedX, minX), maxX)
    calculatedY = min(max(calculatedY, minY), maxY)
    
    self.position = CGPoint(x: calculatedX, y: calculatedY)
  }}
