//
//  CastleBaileyMainViewController.swift
//  LogicPuzzlesSwift
//
//  Created by 趙偉 on 2016/09/21.
//  Copyright © 2016年 趙偉. All rights reserved.
//

import UIKit

class CastleBaileyMainViewController: GameMainViewController {
    override func getGameDocument() -> GameDocumentBase { CastleBaileyDocument.sharedInstance }
}

class CastleBaileyOptionsViewController: GameOptionsViewController {
    override func getGameDocument() -> GameDocumentBase { CastleBaileyDocument.sharedInstance }
}

class CastleBaileyHelpViewController: GameHelpViewController {
    override func getGameDocument() -> GameDocumentBase { CastleBaileyDocument.sharedInstance }
}
