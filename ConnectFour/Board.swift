//
//  Board.swift
//  ConnectFour
//
//  Created by Preston Price on 9/20/15.
//  Copyright © 2015 BendyStraw. All rights reserved.
//

import UIKit
import GameplayKit

enum ChipColor: Int {
    case None = 0
    case Black
    case Red
}
class Board: NSObject {
    static var width = 7
    static var height = 6
    var slots = [ChipColor]()
    var currentPlayer: Player
    
    override init() {
        for _ in 0 ..< Board.width * Board.height {
            slots.append(.None)
        }
        currentPlayer = Player.allPlayers[0]
        super.init()
    }
    
    func chipInColumn(column: Int, row: Int) -> ChipColor {
        return slots[row + column * Board.height]
    }
    
    func setChip(chip: ChipColor, inColumn column: NSInteger, row: NSInteger) {
        slots[row + column * Board.height] = chip
    }
    
    func nextEmptySlotInColumn(column:Int) -> Int? {
        for var row = 0; row < Board.height; row++ {
            if chipInColumn(column, row: row) == .None {
                return row
            }
        }
        return nil
    }
    
    func canMoveInColumn(column: Int) -> Bool {
        return nextEmptySlotInColumn(column) != nil
    }
    
    func addChip(chip: ChipColor, inColumn column:Int) {
        if let row = nextEmptySlotInColumn(column) {
            setChip(chip, inColumn: column, row: row)
        }
    }
    
    func isFull() -> Bool {
        for var column = 0; column < Board.width; column++ {
            if canMoveInColumn(column) {
                return false
            }
        }
        return true
    }
    
    func isWinForPlayer(player: GKGameModelPlayer) -> Bool {
        let chip = (player as! Player).chip
        
        for var row = 0; row < Board.height; row++ {
            for var col = 0; col < Board.width; col++ {
                if squaresMatchChip(chip, row: row, col: col, moveX: 1, moveY: 0) {
                    return true
                } else if squaresMatchChip(chip, row: row, col: col, moveX: 0, moveY: 1) {
                    return true
                } else if squaresMatchChip(chip, row: row, col: col, moveX: 1, moveY: 1) {
                    return true
                } else if squaresMatchChip(chip, row: row, col: col, moveX: 1, moveY: -1) {
                    return true
                }
            }
        }
        
        return false
    }
    
    func squaresMatchChip(chip: ChipColor, row: Int, col: Int, moveX: Int, moveY: Int) -> Bool {
        // bail out early if we can't win from here
        if row + (moveY * 3) < 0 { return false }
        if row + (moveY * 3) >= Board.height { return false }
        if col + (moveX * 3) < 0 { return false }
        if col + (moveX * 3) >= Board.width { return false }
        
        // still here? Check every square
        if chipInColumn(col, row: row) != chip { return false }
        if chipInColumn(col + moveX, row: row + moveY) != chip { return false }
        if chipInColumn(col + (moveX * 2), row: row + (moveY * 2)) != chip { return false }
        if chipInColumn(col + (moveX * 3), row: row + (moveY * 3)) != chip { return false }
        
        return true
    }
}
