//
//  BootyIslandMainViewController.swift
//  LogicPuzzlesSwift
//
//  Created by 趙偉 on 2016/09/21.
//  Copyright © 2016年 趙偉. All rights reserved.
//

import UIKit

class BootyIslandMainViewController: GameMainViewController {
    override func getGameDocument() -> GameDocumentBase { BootyIslandDocument.sharedInstance }
}

class BootyIslandOptionsViewController: GameOptionsViewController {
    override func getGameDocument() -> GameDocumentBase { BootyIslandDocument.sharedInstance }
}

class BootyIslandHelpViewController: GameHelpViewController {
    override func getGameDocument() -> GameDocumentBase { BootyIslandDocument.sharedInstance }
}
