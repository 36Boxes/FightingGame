//
//  GameScene.swift
//  FightingGame
//
//  Created by Josh Manik on 08/06/2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player = SKSpriteNode(imageNamed: "MM1")
    var dpadup = SKSpriteNode(imageNamed: "Up")
    var dpadleft = SKSpriteNode(imageNamed: "Left")
    var dpadright = SKSpriteNode(imageNamed: "Right")
    var dpaddown = SKSpriteNode(imageNamed: "Down")
    var aButton = SKSpriteNode(imageNamed: "AButton")
    var bButton = SKSpriteNode(imageNamed: "BButton")
    var xButton = SKSpriteNode(imageNamed: "XButton")
    var yButton = SKSpriteNode(imageNamed: "YButton")
    var enemy = SKSpriteNode(imageNamed: "GI1")
    var enemyLives = 2
    
    var ground = SKSpriteNode(imageNamed: "bg-full")
    
    var MinotaurMoveAtlas = SKTextureAtlas()
    var MinotaurMoveArray: [SKTexture] = []
    
    var MinotaurAttackAtlas = SKTextureAtlas()
    var MinotaurAttackArray: [SKTexture] = []
    
    var MinotaurIdleAtlas = SKTextureAtlas()
    var MinotaurIdleArray: [SKTexture] = []
    
    var GoblinMoveAtlas = SKTextureAtlas()
    var GoblinMoveArray: [SKTexture] = []
    
    var GoblinAttackAtlas = SKTextureAtlas()
    var GoblinAttackArray: [SKTexture] = []
    
    var GoblinIdleAtlas = SKTextureAtlas()
    var GoblinIdleArray: [SKTexture] = []
    
    enum playerState{
        
        case Left
        case Right
        case Idle
        case Attacking
        
    }
    
    var contactCounter = 0
    
    var inRange = false
    
    struct physicsCatergories {
        
        static let None: UInt32 = 0
        
        static let Floor: UInt32 = 1
        
        static let Player: UInt32 = 2
        
        static let Enemy: UInt32 = 4
    }
    var currentPlayerState = playerState.Idle
    
    func spawnEnemy(){
        enemy.name = "Enemy"
        enemy.size = (enemy.texture?.size())!
        enemy.position = CGPoint(x: frame.size.width * 0.4, y: frame.maxY)
        enemy.setScale(1)
        enemy.zPosition = 30
        enemy.physicsBody = SKPhysicsBody(texture: enemy.texture!, size: enemy.texture!.size())
        enemy.physicsBody?.categoryBitMask = physicsCatergories.Enemy
        enemy.physicsBody?.affectedByGravity = true
        enemy.physicsBody!.collisionBitMask = physicsCatergories.Player | physicsCatergories.Floor
        enemy.physicsBody!.contactTestBitMask = physicsCatergories.Player
        enemy.xScale = abs(enemy.xScale) * -1.0
        self.addChild(enemy)
        let an1m = SKAction.animate(with: GoblinIdleArray, timePerFrame: 0.2)
        let an1mforever = SKAction.repeatForever(an1m)
        enemy.run(an1mforever)
        enemyLives = 3
    }

    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        MinotaurMoveAtlas = SKTextureAtlas(named: "MinotaurMove.atlas")
        MinotaurAttackAtlas = SKTextureAtlas(named: "MinotaurAttack2.atlas")
        MinotaurIdleAtlas = SKTextureAtlas(named: "MinotaurIdle.atlas")
        GoblinMoveAtlas = SKTextureAtlas(named: "GoblinDeath.atlas")
        GoblinIdleAtlas = SKTextureAtlas(named: "GoblinIdle.atlas")
        GoblinAttackAtlas = SKTextureAtlas(named: "GoblinDamage.atlas")
        
        self.anchorPoint = CGPoint(x:0.5, y:0.5)
        
        for n in 1...MinotaurMoveAtlas.textureNames.count{
            let texture = "MM\(n).png"
            MinotaurMoveArray.append(SKTexture(imageNamed: texture))
        }
        for n in 1...MinotaurAttackAtlas.textureNames.count{
            let texture = "MA2\(n).png"
            MinotaurAttackArray.append(SKTexture(imageNamed: texture))
        }
        for n in 1...MinotaurIdleAtlas.textureNames.count{
            let texture = "MI\(n).png"
            MinotaurIdleArray.append(SKTexture(imageNamed: texture))
        }
        for n in 1...GoblinMoveAtlas.textureNames.count{
            let texture = "GD\(n).png"
            GoblinMoveArray.append(SKTexture(imageNamed: texture))
        }
        for n in 1...GoblinIdleAtlas.textureNames.count{
            let texture = "GI\(n).png"
            GoblinIdleArray.append(SKTexture(imageNamed: texture))
        }
        for n in 1...GoblinAttackAtlas.textureNames.count{
            let texture = "GDam\(n).png"
            GoblinAttackArray.append(SKTexture(imageNamed: texture))
        }
       
        let anim = SKAction.animate(with: MinotaurIdleArray, timePerFrame: 0.2)
        let animforever = SKAction.repeatForever(anim)
        player.position = CGPoint(x: frame.midX, y: frame.maxY/2)
        player.setScale(1)
        player.zPosition = 30
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.categoryBitMask = physicsCatergories.Player
        player.physicsBody?.affectedByGravity = true
        player.physicsBody!.collisionBitMask = physicsCatergories.Floor | physicsCatergories.Enemy
        player.physicsBody!.contactTestBitMask = physicsCatergories.Enemy

        self.addChild(player)
        player.run(animforever)
        
        enemy.name = "Enemy"
        enemy.size = (enemy.texture?.size())!
        enemy.position = CGPoint(x: frame.size.width * 0.2, y: frame.maxY/2)
        enemy.setScale(1)
        enemy.zPosition = 30
        enemy.physicsBody = SKPhysicsBody(texture: enemy.texture!, size: enemy.texture!.size())
        enemy.physicsBody?.categoryBitMask = physicsCatergories.Enemy
        enemy.physicsBody?.affectedByGravity = true
        enemy.physicsBody!.collisionBitMask = physicsCatergories.Player | physicsCatergories.Floor
        enemy.physicsBody!.contactTestBitMask = physicsCatergories.Player
        enemy.xScale = abs(enemy.xScale) * -1.0
        self.addChild(enemy)
        let an1m = SKAction.animate(with: GoblinIdleArray, timePerFrame: 0.2)
        let an1mforever = SKAction.repeatForever(an1m)
        enemy.run(an1mforever)
        
        dpadup.position = CGPoint(x: -frame.size.width * 0.2, y: -frame.size.height * 0.2)
        dpadup.size = (dpadup.texture?.size())!
        dpadup.name = "up"
        dpadup.setScale(1.25)
        dpaddown.position = CGPoint(x:  -frame.size.width * 0.2, y: (-frame.size.height * 0.2) - dpadup.size.height - 15)
        dpaddown.name = "down"
        dpaddown.size = (dpaddown.texture?.size())!
        dpaddown.setScale(1.25)
        dpadleft.position = CGPoint(x:  (-frame.size.width * 0.2) - dpadup.size.width, y: (-frame.size.height * 0.2) - dpadup.size.height/2 - 7.5)
        dpadleft.name = "left"
        dpadleft.size = (dpadleft.texture?.size())!
        dpadleft.setScale(1.25)
        dpadright.position = CGPoint(x:  (-frame.size.width * 0.2) + dpadup.size.width, y: (-frame.size.height * 0.2) - dpadup.size.height/2 - 7.5)
        dpadright.name = "right"
        dpadright.size = (dpadright.texture?.size())!
        dpadright.setScale(1.25)
        self.addChild(dpadup)
        self.addChild(dpaddown)
        self.addChild(dpadleft)
        self.addChild(dpadright)
        
        aButton.name = "A"
        aButton.position = CGPoint(x: frame.size.width * 0.15, y: frame.minY * 0.1)
        aButton.size = (aButton.texture?.size())!
        self.addChild(aButton)
        bButton.name = "B"
        bButton.position = CGPoint(x: frame.size.width * 0.4, y: frame.midY * 0.05)
        bButton.size = (bButton.texture?.size())!
        self.addChild(bButton)
        xButton.name = "X"
        xButton.position = CGPoint(x: frame.size.width * 0.15, y: frame.minY * 0.3)
        self.addChild(xButton)
        yButton.name = "Y"
        yButton.position = CGPoint(x: frame.size.width * 0.4, y: frame.minY * 0.25)
        self.addChild(yButton)
        
        
        
        createGrounds()


    }
    
    override func update(_ currentTime: TimeInterval) {
        moveSky()
        if currentPlayerState == playerState.Left{
            moveGroundLeft()
        }
        if currentPlayerState == playerState.Right{
            moveGroundRight()
        }
        print(contactCounter)
        
    }
    
    func createGrounds(){
        
        for i in 0...3 {
            
            let ground = SKSpriteNode(imageNamed: "GrassFloor")
            ground.name = "Ground"
            ground.size = CGSize(width: (self.scene?.size.width)!, height: 30)
            ground.anchorPoint = CGPoint(x:0.5, y:0.5)
            ground.position = CGPoint(x: CGFloat(i) * ground.size.width, y: frame.maxY/3)
            ground.physicsBody = SKPhysicsBody(texture: ground.texture!, size: ground.texture!.size())
            ground.physicsBody?.affectedByGravity = false
            ground.physicsBody?.categoryBitMask = physicsCatergories.Floor
            ground.physicsBody?.collisionBitMask = physicsCatergories.Player | physicsCatergories.Enemy
            ground.physicsBody?.isDynamic = false
            
            self.addChild(ground)
            
            let tree = SKSpriteNode(imageNamed: "TreeWithoutPath")
            tree.name = "Tree"
            tree.size = CGSize(width: (self.scene?.size.width)!, height: 250)
            tree.anchorPoint = CGPoint(x:0.5, y:0.5)
            tree.zPosition = 10
            tree.position = CGPoint(x: CGFloat(i) * tree.size.width, y: frame.maxY/3 + 140)
            self.addChild(tree)
            
            let sky = SKSpriteNode(imageNamed: "SkyWithClouds")
            sky.name = "Sky"
            sky.size = CGSize(width: (self.scene?.size.width)!, height: 250)
            sky.anchorPoint = CGPoint(x:0.5, y:0.5)
            sky.zPosition = 1
            sky.position = CGPoint(x: CGFloat(i) * ground.size.width, y: frame.maxY/3 + 150)
            
            self.addChild(sky)
            
            let hill = SKSpriteNode(imageNamed: "BackgroundMountains")
            hill.name = "Hills"
            hill.size = CGSize(width: (self.scene?.size.width)!, height: 250)
            hill.anchorPoint = CGPoint(x:0.5, y:0.5)
            hill.zPosition = 2
            hill.position = CGPoint(x: CGFloat(i) * ground.size.width, y: frame.maxY/3 + 150)
            
            self.addChild(hill)
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
        self.enumerateChildNodes(withName: "Tree", using: ({
            (node, error) in
            
            node.position.x += 1.5
            
            if node.position.x > ((self.scene?.size.width)!){
                node.position.x -= (self.scene?.size.width)! * 3
            }
        }))
        self.enumerateChildNodes(withName: "Hills", using: ({
            (node, error) in
            
            node.position.x += 0.5
            
            if node.position.x > ((self.scene?.size.width)!){
                node.position.x -= (self.scene?.size.width)! * 3
            }
        }))
    }
    
    func moveSky(){
        self.enumerateChildNodes(withName: "Sky", using: ({
            (node, error) in
            
            node.position.x -= 0.25
            
            if node.position.x < -((self.scene?.size.width)!){
                node.position.x += (self.scene?.size.width)! * 3
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
        
        self.enumerateChildNodes(withName: "Tree", using: ({
            (node, error) in
            
            node.position.x -= 1.5
            
            if node.position.x < -((self.scene?.size.width)!){
                node.position.x += (self.scene?.size.width)! * 3
            }
        }))
        
        
        self.enumerateChildNodes(withName: "Hills", using: ({
            (node, error) in
            
            node.position.x -= 0.5
            
            if node.position.x < -((self.scene?.size.width)!){
                node.position.x += (self.scene?.size.width)! * 3
            }
        }))
        
        self.enumerateChildNodes(withName: "Enemy", using: ({
            (node, error) in
            
            node.position.x -= 0.5
            
            if node.position.x < -((self.scene?.size.width)!){
                node.position.x += (self.scene?.size.width)! * 3
            }
        }))
    }
    
    func animate(){
        let anim = SKAction.animate(with: MinotaurMoveArray, timePerFrame: 0.09)
        player.run(anim)
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        var body1 = SKPhysicsBody()
        var body2 = SKPhysicsBody()
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask{
            body1 = contact.bodyA
            body2 = contact.bodyB
        }else{
            body1 = contact.bodyB
            body2 = contact.bodyA
        }
        
        if body1.categoryBitMask == physicsCatergories.Player && body2.categoryBitMask == physicsCatergories.Enemy{
            inRange = true

            
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        var body1 = SKPhysicsBody()
        var body2 = SKPhysicsBody()
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask{
            body1 = contact.bodyA
            body2 = contact.bodyB
        }else{
            body1 = contact.bodyB
            body2 = contact.bodyA
        }
        
        if body1.categoryBitMask == physicsCatergories.Player && body2.categoryBitMask == physicsCatergories.Enemy{
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches{
            let pot = touch.location(in: self)
            let nodeTapped = atPoint(pot)
            
            if nodeTapped.name == "up"{print(nodeTapped.name)}
            if nodeTapped.name == "down"{print(nodeTapped.name)}
            if nodeTapped.name == "left"{
                currentPlayerState = playerState.Left
                let anim = SKAction.animate(with: MinotaurMoveArray, timePerFrame: 0.1)
                let anime = SKAction.repeatForever(anim)
                player.run(anime, withKey: "run")
                player.xScale = abs(player.xScale) * -1.0
            }
            if nodeTapped.name == "right"{
                currentPlayerState = playerState.Right
                let anim = SKAction.animate(with: MinotaurMoveArray, timePerFrame: 0.1)
                let anime = SKAction.repeatForever(anim)
                player.run(anime, withKey: "run")
                player.xScale = abs(player.xScale) * 1.0
            }
            
            if nodeTapped.name == "A"{
                let anim = SKAction.animate(with: MinotaurAttackArray, timePerFrame: 0.1)
                player.run(anim)
                player.removeAction(forKey: "run")
                currentPlayerState = playerState.Attacking
                if inRange == true{
                    hurtEnemy()
                }
                
            }
        }
    }
    
    func hurtEnemy(){
        let anim = SKAction.animate(with: GoblinAttackArray, timePerFrame: 0.2)
        enemy.run(anim)
        enemyLives -= 1
        if enemyLives == 0{
            let anim = SKAction.animate(with: GoblinMoveArray, timePerFrame: 0.1)
            let remove = SKAction.removeFromParent()
            let spawn = SKAction.run(spawnEnemy)
            let seq = SKAction.sequence([anim, remove, spawn])
            enemy.run(seq)
            inRange = false
        }
    }
}
