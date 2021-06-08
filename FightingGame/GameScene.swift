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
    var dpadup = SKSpriteNode(imageNamed: "Up")
    var dpadleft = SKSpriteNode(imageNamed: "Left")
    var dpadright = SKSpriteNode(imageNamed: "Right")
    var dpaddown = SKSpriteNode(imageNamed: "Down")
    var aButton = SKSpriteNode(imageNamed: "AButton")
    
    var ground = SKSpriteNode(imageNamed: "bg-full")
    
    var MinotaurMoveAtlas = SKTextureAtlas()
    var MinotaurMoveArray: [SKTexture] = []
    
    var MinotaurAttackAtlas = SKTextureAtlas()
    var MinotaurAttackArray: [SKTexture] = []
    
    var MinotaurIdleAtlas = SKTextureAtlas()
    var MinotaurIdleArray: [SKTexture] = []
    
    enum playerState{
        
        case Left
        case Right
        case Idle
        
    }
    var currentPlayerState = playerState.Idle

    
    override func didMove(to view: SKView) {
        MinotaurMoveAtlas = SKTextureAtlas(named: "MinotaurMove.atlas")
        MinotaurAttackAtlas = SKTextureAtlas(named: "MinotaurAttack1.atlas")
        MinotaurIdleAtlas = SKTextureAtlas(named: "MinotaurIdle.atlas")
        
        self.anchorPoint = CGPoint(x:0.5, y:0.5)
        
        for n in 1...MinotaurMoveAtlas.textureNames.count{
            let texture = "MM\(n).png"
            MinotaurMoveArray.append(SKTexture(imageNamed: texture))
        }
        for n in 1...MinotaurAttackAtlas.textureNames.count{
            let texture = "MA1\(n).png"
            MinotaurAttackArray.append(SKTexture(imageNamed: texture))
        }
        for n in 1...MinotaurIdleAtlas.textureNames.count{
            let texture = "MI\(n).png"
            MinotaurIdleArray.append(SKTexture(imageNamed: texture))
        }
        let anim = SKAction.animate(with: MinotaurIdleArray, timePerFrame: 0.09)
        let animforever = SKAction.repeatForever(anim)
        player.position = CGPoint(x: frame.midX, y: frame.maxY/3)
        player.setScale(3)
        player.zPosition = 3
        self.addChild(player)
        player.run(animforever)
        
        dpadup.position = CGPoint(x: -frame.size.width * 0.25, y: frame.minY * 0.3)
        dpadup.size = (dpadup.texture?.size())!
        dpadup.name = "up"
        dpadup.setScale(1)
        dpaddown.position = CGPoint(x:  -frame.size.width * 0.25, y: (frame.minY * 0.3) - dpadup.size.height - 10)
        dpaddown.name = "down"
        dpaddown.size = (dpaddown.texture?.size())!
        dpaddown.setScale(1)
        dpadleft.position = CGPoint(x:  (-frame.size.width * 0.25) - dpadup.size.width, y: (frame.minY * 0.3) - dpadup.size.height/2 - 5)
        dpadleft.name = "left"
        dpadleft.size = (dpadleft.texture?.size())!
        dpadleft.setScale(1)
        dpadright.position = CGPoint(x:  (-frame.size.width * 0.25) + dpadup.size.width, y: (frame.minY * 0.3) - dpadup.size.height/2 - 5)
        dpadright.name = "right"
        dpadright.size = (dpadright.texture?.size())!
        dpadright.setScale(1)
        self.addChild(dpadup)
        self.addChild(dpaddown)
        self.addChild(dpadleft)
        self.addChild(dpadright)
        
        aButton.name = "A"
        aButton.position = CGPoint(x: frame.size.width * 0.25, y: frame.minY * 0.3)
        aButton.size = (aButton.texture?.size())!
        self.addChild(aButton)
        
        
        
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
        let anim = SKAction.animate(with: MinotaurMoveArray, timePerFrame: 0.09)
        player.run(anim)
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      let touch = touches.first!
      let location = touch.location(in: self)
      
      var multiplierForDirection: CGFloat
      if location.x < frame.midX {
        // walk left
        multiplierForDirection = -1.0


      } else {
        // walk right
        multiplierForDirection = 1.0


      }
      
//      player.xScale = abs(player.xScale) * multiplierForDirection

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches{
            let pot = touch.location(in: self)
            let nodeTapped = atPoint(pot)
            
            if nodeTapped.name == "up"{print(nodeTapped.name)}
            if nodeTapped.name == "down"{print(nodeTapped.name)}
            if nodeTapped.name == "left"{
                print(nodeTapped.name)
                currentPlayerState = playerState.Left
                let anim = SKAction.animate(with: MinotaurMoveArray, timePerFrame: 0.1)
                let anime = SKAction.repeatForever(anim)
                player.run(anime, withKey: "run")
                player.xScale = abs(player.xScale) * -1.0
            }
            if nodeTapped.name == "right"{
                print(nodeTapped.name)
                currentPlayerState = playerState.Right
                let anim = SKAction.animate(with: MinotaurMoveArray, timePerFrame: 0.1)
                let anime = SKAction.repeatForever(anim)
                player.run(anime, withKey: "run")
                player.xScale = abs(player.xScale) * 1.0
            }
            
            if nodeTapped.name == "A"{
                currentPlayerState = playerState.Idle
                let anim = SKAction.animate(with: MinotaurAttackArray, timePerFrame: 0.1)
                player.run(anim)
                player.removeAction(forKey: "run")
                
            }
        }
    }
}
