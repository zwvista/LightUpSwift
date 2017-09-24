//
//  SnakeGameState.swift
//  LogicPuzzlesSwift
//
//  Created by 趙偉 on 2016/09/19.
//  Copyright © 2016年 趙偉. All rights reserved.
//

import Foundation

class SnakeGameState: GridGameState {
    // http://stackoverflow.com/questions/24094158/overriding-superclass-property-with-different-type-in-swift
    var game: SnakeGame {
        get {return getGame() as! SnakeGame}
        set {setGame(game: newValue)}
    }
    var gameDocument: SnakeDocument { return SnakeDocument.sharedInstance }
    override func getGameDocument() -> GameDocumentBase! { return SnakeDocument.sharedInstance }
    var objArray = [SnakeObject]()
    var row2state = [HintState]()
    var col2state = [HintState]()
    
    override func copy() -> SnakeGameState {
        let v = SnakeGameState(game: game, isCopy: true)
        return setup(v: v)
    }
    func setup(v: SnakeGameState) -> SnakeGameState {
        _ = super.setup(v: v)
        v.objArray = objArray
        v.row2state = row2state
        v.col2state = col2state
        return v
    }
    
    required init(game: SnakeGame, isCopy: Bool = false) {
        super.init(game: game)
        guard !isCopy else {return}
        objArray = Array<SnakeObject>(repeating: SnakeObject(), count: rows * cols)
        for p in game.pos2snake {
            self[p] = .snake
        }
        row2state = Array<HintState>(repeating: .normal, count: rows)
        col2state = Array<HintState>(repeating: .normal, count: cols)
        updateIsSolved()
    }
    
    subscript(p: Position) -> SnakeObject {
        get {
            return self[p.row, p.col]
        }
        set(newValue) {
            self[p.row, p.col] = newValue
        }
    }
    subscript(row: Int, col: Int) -> SnakeObject {
        get {
            return objArray[row * cols + col]
        }
        set(newValue) {
            objArray[row * cols + col] = newValue
        }
    }
    
    func setObject(move: inout SnakeGameMove) -> Bool {
        let p = move.p
        guard isValid(p: p) && !game.pos2snake.contains(p) && self[p] != move.obj else {return false}
        self[p] = move.obj
        updateIsSolved()
        return true
    }
    
    func switchObject(move: inout SnakeGameMove) -> Bool {
        let markerOption = MarkerOptions(rawValue: self.markerOption)
        func f(o: SnakeObject) -> SnakeObject {
            switch o {
            case .empty:
                return markerOption == .markerFirst ? .marker : .snake
            case .snake:
                return markerOption == .markerLast ? .marker : .empty
            case .marker:
                return markerOption == .markerFirst ? .snake : .empty
            default:
                return o
            }
        }
        let p = move.p
        guard isValid(p: p) else {return false}
        move.obj = f(o: self[p])
        return setObject(move: &move)
    }
    
    /*
        iOS Game: Logic Games/Puzzle Set 16/Snake

        Summary
        Still lives inside your pocket-sized computer

        Description
        1. Complete the Snake, head to tail, inside the board.
        2. The two tiles given at the start are the head and the tail of the snake
           (it is irrelevant which is which).
        3. Numbers on the border tell you how many tiles the snake occupies in that
           row or column.
        4. The snake can't touch itself, not even diagonally.
    */
    private func updateIsSolved() {
        let allowedObjectsOnly = self.allowedObjectsOnly
        isSolved = true
        for r in 0..<rows {
            for c in 0..<cols {
                if self[r, c] == .forbidden {self[r, c] = .empty}
            }
        }
        for r in 0..<rows {
            var n1 = 0
            let n2 = game.row2hint[r]
            for c in 0..<cols {
                if self[r, c] == .snake {n1 += 1}
            }
            row2state[r] = n1 < n2 ? .normal : n1 == n2 ? .complete : .error
            if n1 != n2 {isSolved = false}
        }
        for c in 0..<cols {
            var n1 = 0
            let n2 = game.col2hint[c]
            for r in 0..<rows {
                if self[r, c] == .snake {n1 += 1}
            }
            col2state[c] = n1 < n2 ? .normal : n1 == n2 ? .complete : .error
            if n1 != n2 {isSolved = false}
        }
        for r in 0..<rows {
            for c in 0..<cols {
                switch self[r, c] {
                case .empty, .marker:
                    if allowedObjectsOnly && (row2state[r] != .normal || col2state[c] != .normal) {self[r, c] = .forbidden}
                default:
                    break
                }
            }
        }
        let g = Graph()
        var pos2node = [Position: Node]()
        for r in 0..<rows {
            for c in 0..<cols {
                let p = Position(r, c)
                guard self[p] == .snake else {continue}
                let node = g.addNode(p.description)
                pos2node[p] = node
            }
        }
        for (p, node) in pos2node {
            for os in SnakeGame.offset {
                let p2 = p + os
                guard let node2 = pos2node[p2] else {continue}
                g.addEdge(node, neighbor: node2)
            }
        }
        let nodesExplored = breadthFirstSearch(g, source: pos2node.first!.value)
        let n1 = nodesExplored.count
        let n2 = pos2node.values.count
        if n1 != n2 {isSolved = false}
        for p in pos2node.keys {
            var (rngEmpty, rngSnake) = ([Position](), [Position]())
            for os in SnakeGame.offset {
                let p2 = p + os
                guard isValid(p: p2) else {continue}
                switch self[p2] {
                case .empty, .marker:
                    rngEmpty.append(p2)
                case .snake:
                    rngSnake.append(p2)
                default:
                    break
                }
            }
            let b = game.pos2snake.contains(p)
            let cnt = rngSnake.count
            if b && cnt >= 1 || !b && cnt >= 2 {
                for p2 in rngEmpty {
                    if allowedObjectsOnly {self[p2] = .forbidden}
                }
                if b && cnt > 1 || !b && cnt > 2 {isSolved = false}
            }
        }
    }
}