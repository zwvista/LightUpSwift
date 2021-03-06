//
//  TapDifferentlyObject.swift
//  LogicPuzzlesSwift
//
//  Created by 趙偉 on 2016/09/26.
//  Copyright © 2016年 趙偉. All rights reserved.
//

import Foundation

enum TapDifferentlyObject {
    case empty
    case hint(state: HintState)
    case marker
    case wall
    init() {
        self = .empty
    }
    func toString() -> String {
        switch self {
        case .marker:
            return "marker"
        case .wall:
            return "wall"
        default:
            return "empty"
        }
    }
    static func fromString(str: String) -> TapDifferentlyObject {
        switch str {
        case "marker":
            return .marker
        case "wall":
            return .wall
        default:
            return .empty
        }
    }
}

struct TapDifferentlyGameMove {
    var p = Position()
    var obj = TapDifferentlyObject()
}

