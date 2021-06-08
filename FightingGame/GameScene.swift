//
//  GameScene.swift
//  FightingGame
//
//  Created by Josh Manik on 08/06/2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var player = SKSpriteNode(imageNamed: "SW13")
    var dpadup = SKSpriteNode(imageNamed: "gamepadUP")
    var dpadleft = SKSpriteNode(imageNamed: "gamepadLeft")
    var dpadright = SKSpriteNode(imageNamed: "gamepadRight")
    var dpaddown = SKSpriteNode(imageNamed: "gamepadDown")
    
    var ground = SKSpriteNode(imageNamed: "bg-full")
    
    var PlayerTextureAtlas = SKTextureAtlas()
    var PlayerTextureArray: [SKTexture] = []
    
    enum playerState{
        
        case Left
        case Right
        case Idle
        
    }
    var currentPlayerState = playerState.Idle

    
    override func didMove(to view: SKView) {
        PlayerTextureAtlas = SKTextureAtlas(named: "MinotaurMove.atlas")
        
        self.anchorPoint = CGPoint(x:0.5, y:0.5)
        
        for n in 1...PlayerTextureAtlas.textureNames.count{
            let texture = "MM\(n).png"
            PlayerTextureArray.append(SKTexture(imageNamed: texture))
        }
        let anim = SKAction.animate(with: PlayerTextureArray, timePerFrame: 0.09)
        let animforever = SKAction.repeatForever(anim)
        player.position = CGPoint(x: frame.midX, y: frame.maxY/3)
        player.setScale(3)
        player.zPosition = 3
        self.addChild(player)
        player.run(animforever)
        
        dpadup.position = CGPoint(x: -frame.size.width * 0.25, y: frame.minY * 0.3)
        dpadup.setScale(5)
        dpaddown.position = CGPoint(x:  -frame.size.width * 0.25, y: frame.minY * 0.3)
        dpaddown.setScale(5)
        dpadleft.position = CGPoint(x:  -frame.size.width * 0.25, y: frame.minY * 0.3)
        dpadleft.setScale(5)
        dpadright.position = CGPoint(x:  -frame.size.width * 0.25, y: frame.minY * 0.3)
        dpadright.setScale(5)
        self.addChild(dpadup)
        self.addChild(dpaddown)
        self.addChild(dpadleft)
        self.addChild(dpadright)
        
        createGrounds()


    }
    
    override func update(_ currentTime: TimeInterval) {
        if currentPlayerState == playerState.Left{
            moveGroundLeft()
        }
        if currentPlayerState == playerState.Right{
            moveGroundRight()
        }
        
    }
    
    func createGrounds(){
        
        for i in 0...3 {
            
            let ground = SKSpriteNode(imageNamed: "bg-full")
            ground.name = "Ground"
            ground.size = CGSize(width: (self.scene?.size.width)!, height: (self.ground.texture?.size().height)!)
            ground.anchorPoint = CGPoint(x:0.5, y:0.5)
            ground.position = CGPoint(x: CGFloat(i) * ground.size.width, y: frame.maxY/2)
            
            self.addChild(ground)
        }
    }
    
    func moveGroundLeft(){
        
        self.enumerateChildNodes(withName: "Ground", using: ({
            (node, error) in
            
            node.position.x += 1.5
            
            if node.position.x > ((self.scene?.size.width)!){
                node.position.x -= (self.scene?.size.width)! * 3
            }
        }))
    }
    
    func moveGroundRight(){
        
        self.enumerateChildNodes(withName: "Ground", using: ({
            (node, error) in
            
            node.position.x -= 1.5
            
            if node.position.x < -((self.scene?.size.width)!){
                node.position.x += (self.scene?.size.width)! * 3
            }
        }))
    }
    
    func animate(){
        let anim = SKAction.animate(with: PlayerTextureArray, timePerFrame: 0.09)
        player.run(anim)
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      let touch = touches.first!
      let location = touch.location(in: self)
      
      var multiplierForDirection: CGFloat
      if location.x < frame.midX {
        // walk left
        multiplierForDirection = -1.0
        currentPlayerState = playerState.Left

      } else {
        // walk right
        multiplierForDirection = 1.0
        currentPlayerState = playerState.Right

      }
      
      player.xScale = abs(player.xScale) * multiplierForDirection
        
        animate()
        
    }
}
