//
//  OverUnderGame.swift
//  LogicPuzzlesSwift
//
//  Created by 趙偉 on 2016/09/10.
//  Copyright © 2016年 趙偉. All rights reserved.
//

import Foundation

class OverUnderGame: GridGame<OverUnderGameViewController> {
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
    
    var objArray = [GridDotObject]()
    var pos2hint = [Position: Int]()
    var areaSize = 0
    
    init(layout: [String], delegate: OverUnderGameViewController? = nil) {
        super.init(delegate: delegate)
        
        size = Position(layout.count + 1, layout[0].length + 1)
        objArray = Array<GridDotObject>(repeating: Array<GridLineObject>(repeating: .empty, count: 4), count: rows * cols)
        
        for r in 0..<rows - 1 {
            let str = layout[r]
            for c in 0..<cols - 1 {
                let p = Position(r, c)
                let ch = str[c]
                guard ch != " " else {continue}
                let n = ch.toInt!
                pos2hint[p] = n
            }
        }
        areaSize = (rows - 1) * (cols - 1) / pos2hint.count
        for r in 0..<rows - 1 {
            self[r, 0][2] = .line
            self[r + 1, 0][0] = .line
            self[r, cols - 1][2] = .line
            self[r + 1, cols - 1][0] = .line
        }
        for c in 0..<cols - 1 {
            self[0, c][1] = .line
            self[0, c + 1][3] = .line
            self[rows - 1, c][1] = .line
            self[rows - 1, c + 1][3] = .line
        }
        
        let state = OverUnderGameState(game: self)
        levelInitilized(state: state)
    }
    
    subscript(p: Position) -> GridDotObject {
        get {
            return self[p.row, p.col]
        }
        set(newValue) {
            self[p.row, p.col] = newValue
        }
    }
    subscript(row: Int, col: Int) -> GridDotObject {
        get {
            return objArray[row * cols + col]
        }
        set(newValue) {
            objArray[row * cols + col] = newValue
        }
    }
    
    func switchObject(move: inout OverUnderGameMove) -> Bool {
        return changeObject(move: &move, f: {state, move in state.switchObject(move: &move)})
    }
    
    func setObject(move: inout OverUnderGameMove) -> Bool {
        return changeObject(move: &move, f: {state, move in state.setObject(move: &move)})
    }
    
}
