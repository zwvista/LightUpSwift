//
//  FenceSentinelsGame.swift
//  LogicPuzzlesSwift
//
//  Created by 趙偉 on 2016/09/10.
//  Copyright © 2016年 趙偉. All rights reserved.
//

import Foundation

class FenceSentinelsGame: GridGame<FenceSentinelsGameViewController> {
    static let offset = [
        Position(-1, 0),
        Position(0, 1),
        Position(1, 0),
        Position(0, -1),
    ]
    static let offset2 = [
        Position(0, 0),
        Position(1, 1),
        Position(1, 1),
        Position(0, 0),
    ]
    static let dirs = [1, 0, 3, 2]
    
    override func isValid(row: Int, col: Int) -> Bool {
        return 0..<rows - 1 ~= row && 0..<cols - 1 ~= col
    }

    var pos2hint = [Position: Int]()
    
    init(layout: [String], delegate: FenceSentinelsGameViewController? = nil) {
        super.init(delegate: delegate)
        
        size = Position(layout.count + 1, layout[0].length + 1)
        
        for r in 0..<rows - 1 {
            let str = layout[r]
            for c in 0..<cols - 1 {
                let ch = str[c]
                guard case "0"..."9" = ch else {continue}
                pos2hint[Position(r, c)] = ch.toInt!
            }
        }
        
        let state = FenceSentinelsGameState(game: self)
        states.append(state)
        levelInitilized(state: state)
    }
    
    func switchObject(move: inout FenceSentinelsGameMove) -> Bool {
        return changeObject(move: &move, f: {state, move in state.switchObject(move: &move)})
    }
    
    func setObject(move: inout FenceSentinelsGameMove) -> Bool {
        return changeObject(move: &move, f: {state, move in state.setObject(move: &move)})
    }
    
}
