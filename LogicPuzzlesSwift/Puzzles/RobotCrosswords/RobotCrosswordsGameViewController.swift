//
//  RobotCrosswordsGameViewController.swift
//  LogicPuzzlesSwift
//
//  Created by 趙偉 on 2016/08/31.
//  Copyright (c) 2016年 趙偉. All rights reserved.
//

import UIKit
import SpriteKit

class RobotCrosswordsGameViewController: GameGameViewController, GameDelegate {
    typealias GM = RobotCrosswordsGameMove
    typealias GS = RobotCrosswordsGameState

    var scene: RobotCrosswordsGameScene {
        get {return getScene() as! RobotCrosswordsGameScene}
        set {setScene(scene: newValue)}
    }
    var game: RobotCrosswordsGame {
        get {getGame() as! RobotCrosswordsGame}
        set {setGame(game: newValue)}
    }
    var gameDocument: RobotCrosswordsDocument { RobotCrosswordsDocument.sharedInstance }
    override func getGameDocument() -> GameDocumentBase! { RobotCrosswordsDocument.sharedInstance }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create and configure the scene.
        scene = RobotCrosswordsGameScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFill
        scene.backgroundColor = UIColor.black
        
        // Present the scene.
        skView.presentScene(scene)
        
        startGame()
    }
    
    override func handleTap(_ sender: UITapGestureRecognizer) {
        guard !game.isSolved else {return}
        let touchLocation = sender.location(in: sender.view)
        let touchLocationInScene = scene.convertPoint(fromView: touchLocation)
        guard scene.gridNode.contains(touchLocationInScene) else {return}
        let touchLocationInGrid = scene.convert(touchLocationInScene, to: scene.gridNode)
        let p = scene.gridNode.cellPosition(point: touchLocationInGrid)
        var move = RobotCrosswordsGameMove(p: p, obj: -1)
        if game.switchObject(move: &move) { soundManager.playSoundTap() }
    }
    
    override func startGame() {
        lblLevel.text = gameDocument.selectedLevelID
        updateSolutionUI()
        
        let level: GameLevel = gameDocument.levels.first(where: {$0.id == gameDocument.selectedLevelID}) ?? gameDocument.levels.first!
        
        levelInitilizing = true
        defer {levelInitilizing = false}
        game = RobotCrosswordsGame(layout: level.layout, delegate: self)
        
        // restore game state
        for case let rec as MoveProgress in gameDocument.moveProgress {
            var move = gameDocument.loadMove(from: rec)!
            _ = game.setObject(move: &move)
        }
        let moveIndex = gameDocument.levelProgress.moveIndex
        if case 0..<game.moveCount = moveIndex {
            while moveIndex != game.moveIndex {
                game.undo()
            }
        }
        scene.levelUpdated(from: game.states[0], to: game.currentState)
    }
    
    func moveAdded(_ game: AnyObject, move: RobotCrosswordsGameMove) {
        guard !levelInitilizing else {return}
        gameDocument.moveAdded(game: game, move: move)
    }
    
    func levelInitilized(_ game: AnyObject, state: RobotCrosswordsGameState) {
        let game = game as! RobotCrosswordsGame
        updateMovesUI(game)
        scene.levelInitialized(game, state: state, skView: skView)
    }
    
    func levelUpdated(_ game: AnyObject, from stateFrom: RobotCrosswordsGameState, to stateTo: RobotCrosswordsGameState) {
        let game = game as! RobotCrosswordsGame
        updateMovesUI(game)
        guard !levelInitilizing else {return}
        scene.levelUpdated(from: stateFrom, to: stateTo)
        gameDocument.levelUpdated(game: game)
    }
    
    func gameSolved(_ game: AnyObject) {
        guard !levelInitilizing else {return}
        soundManager.playSoundSolved()
        gameDocument.gameSolved(game: game)
        updateSolutionUI()
   }
}
