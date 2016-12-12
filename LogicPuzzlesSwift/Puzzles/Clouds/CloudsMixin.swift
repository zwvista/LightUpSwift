//
//  CloudsMixin.swift
//  LogicPuzzlesSwift
//
//  Created by 趙偉 on 2016/10/10.
//  Copyright © 2016年 趙偉. All rights reserved.
//

import Foundation

protocol CloudsMixin: GameMixin {
    var gameDocument: CloudsDocument { get }
    var gameOptions: GameProgress { get }
    var markerOption: Int { get }
    func setMarkerOption(rec: GameProgress, newValue: Int)
}

extension CloudsMixin {
    var gameDocument: CloudsDocument { return CloudsDocument.sharedInstance }
    var gameOptions: GameProgress { return gameDocument.gameProgress }
    var markerOption: Int { return gameOptions.option1?.toInt() ?? 0 }
    func setMarkerOption(rec: GameProgress, newValue: Int) { rec.option1 = newValue.description }
}
