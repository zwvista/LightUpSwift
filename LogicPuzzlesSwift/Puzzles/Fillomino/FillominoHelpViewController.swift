//
//  FillominoHelpViewController.swift
//  LogicPuzzlesSwift
//
//  Created by 趙偉 on 2017/05/14.
//  Copyright © 2017年 趙偉. All rights reserved.
//

import UIKit

class FillominoHelpViewController: GameHelpViewController {

    var gameDocument: FillominoDocument { return FillominoDocument.sharedInstance }
    override func getGameDocument() -> GameDocumentBase! { return FillominoDocument.sharedInstance }

}