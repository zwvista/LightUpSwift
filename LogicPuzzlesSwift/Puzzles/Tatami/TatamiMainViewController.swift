//
//  TatamiMainViewController.swift
//  LogicPuzzlesSwift
//
//  Created by 趙偉 on 2016/09/21.
//  Copyright © 2016年 趙偉. All rights reserved.
//

import UIKit

class TatamiMainViewController: GameMainViewController {

    var gameDocument: TatamiDocument { TatamiDocument.sharedInstance }
    override func getGameDocument() -> GameDocumentBase! { TatamiDocument.sharedInstance }

}
