//
//  TataminoDocument.swift
//  LogicPuzzlesSwift
//
//  Created by 趙偉 on 2016/09/18.
//  Copyright © 2016年 趙偉. All rights reserved.
//

import UIKit
import SharkORM

class TataminoDocument: GameDocument<TataminoGame, TataminoGameMove> {
    static var sharedInstance = TataminoDocument()
    
    override func saveMove(_ move: TataminoGameMove, to rec: MoveProgress) {
        (rec.row, rec.col) = move.p.unapply()
        rec.strValue1 = move.obj.description
    }
    
    override func loadMove(from rec: MoveProgress) -> TataminoGameMove? {
        return TataminoGameMove(p: Position(rec.row, rec.col), obj: rec.strValue1![0])
    }
}