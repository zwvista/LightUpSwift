//
//  DisconnectFourMainViewController.swift
//  LogicPuzzlesSwift
//
//  Created by 趙偉 on 2016/09/21.
//  Copyright © 2016年 趙偉. All rights reserved.
//

import UIKit

class DisconnectFourMainViewController: GameMainViewController {

    var gameDocument: DisconnectFourDocument { return DisconnectFourDocument.sharedInstance }
    override func getGameDocument() -> GameDocumentBase! { return DisconnectFourDocument.sharedInstance }

}