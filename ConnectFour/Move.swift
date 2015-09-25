//
//  Move.swift
//  ConnectFour
//
//  Created by Preston Price on 9/21/15.
//  Copyright © 2015 BendyStraw. All rights reserved.
//

import UIKit
import GameplayKit

class Move: NSObject, GKGameModelUpdate {
    var value: Int = 0
    var column: Int
    
    init(column: Int) {
        self.column = column
    }
}
