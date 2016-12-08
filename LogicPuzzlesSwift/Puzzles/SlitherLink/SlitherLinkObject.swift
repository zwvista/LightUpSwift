//
//  SlitherLinkObject.swift
//  LogicPuzzlesSwift
//
//  Created by 趙偉 on 2016/09/26.
//  Copyright © 2016年 趙偉. All rights reserved.
//

import Foundation

enum SlitherLinkObject: Int {
    case empty
    case line
    case marker
    init() {
        self = .empty
    }
}

typealias SlitherLinkDotObject = [SlitherLinkObject]

struct SlitherLinkGameMove {
    var p = Position()
    var dir = 0
    var obj = SlitherLinkObject()
}
