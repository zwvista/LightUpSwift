//
//  FutoshikiMainViewController.swift
//  LogicPuzzlesSwift
//
//  Created by 趙偉 on 2016/09/21.
//  Copyright © 2016年 趙偉. All rights reserved.
//

import UIKit

class FutoshikiMainViewController: GameMainViewController {
    override func getGameDocument() -> GameDocumentBase { FutoshikiDocument.sharedInstance }
}

class FutoshikiOptionsViewController: GameOptionsViewController {
    override func getGameDocument() -> GameDocumentBase { FutoshikiDocument.sharedInstance }
}

class FutoshikiHelpViewController: GameHelpViewController {
    override func getGameDocument() -> GameDocumentBase { FutoshikiDocument.sharedInstance }
}
