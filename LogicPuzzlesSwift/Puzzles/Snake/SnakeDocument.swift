//
//  SnakeDocument.swift
//  LogicPuzzlesSwift
//
//  Created by 趙偉 on 2016/09/18.
//  Copyright © 2016年 趙偉. All rights reserved.
//

import UIKit
import SharkORM

class SnakeDocument: GameDocument<SnakeGameMove> {
    static var sharedInstance = SnakeDocument()
    
    override func saveMove(_ move: SnakeGameMove, to rec: MoveProgress) {
        (rec.row, rec.col) = move.p.unapply()
        rec.intValue1 = move.obj.rawValue
    }
    
    override func loadMove(from rec: MoveProgress) -> SnakeGameMove {
        SnakeGameMove(p: Position(rec.row, rec.col), obj: SnakeObject(rawValue: rec.intValue1)!)
    }
}
