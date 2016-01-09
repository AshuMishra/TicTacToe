//
//  GameBoardView.swift
//  TicTacToe
//
//  Created by Susmita Horrow on 09/01/16.
//  Copyright © 2016 Ashutosh. All rights reserved.
//

import Foundation
import UIKit

enum Player {
	case first
	case second
	case none

	func valueForPlayer()-> Int {
		switch self {
		case .first:
			return 0
		case .second:
			return 1
		case .none:
			return -1
		}
	}

	func image()-> UIImage {
		switch self {
		case .first:
			return UIImage(named: "Triangle.png")!
		case .second:
			return UIImage(named: "circle.png")!
		case .none:
			return UIImage()
		}
	}
}

typealias GameOverCompletion = (winningPlayer: Player) -> Void

class GameBoardView: UIView {

	@IBOutlet weak var boardView: UIView!
	@IBOutlet weak var button0: UIButton!
	@IBOutlet weak var button1: UIButton!
	@IBOutlet weak var button2: UIButton!
	@IBOutlet weak var button3: UIButton!
	@IBOutlet weak var button4: UIButton!
	@IBOutlet weak var button5: UIButton!
	@IBOutlet weak var button6: UIButton!
	@IBOutlet weak var button7: UIButton!
	@IBOutlet weak var button8: UIButton!

	var currentPlayer: Player = Player.first
	var winningPlayer: Player = Player.none
	private var gameState = [Player](count: 9, repeatedValue: .none)
	private let winningCombinations = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
	var gameOverCompletion: GameOverCompletion?

	func markPosition(position: Int, player: Player) {
		if gameState[position] != .none {
			return
		}
		gameState[position] = player
		let image = player.image()
		switch(position) {
		case 0:
			button0.setImage(image, forState: UIControlState.Normal)
		case 1:
			button1.setImage(image, forState: UIControlState.Normal)
		case 2:
			button2.setImage(image, forState: UIControlState.Normal)
		case 3:
			button3.setImage(image, forState: UIControlState.Normal)
		case 4:
			button4.setImage(image, forState: UIControlState.Normal)
		case 5:
			button5.setImage(image, forState: UIControlState.Normal)
		case 6:
			button6.setImage(image, forState: UIControlState.Normal)
		case 7:
			button7.setImage(image, forState: UIControlState.Normal)
		case 8:
			button8.setImage(image, forState: UIControlState.Normal)
		default:
			return
		}
	}

	func startGame() {

		winningPlayer = .none
		gameState = [Player](count: 9, repeatedValue: winningPlayer)

		button0.setImage(nil, forState: UIControlState.Normal)
		button1.setImage(nil, forState: UIControlState.Normal)
		button2.setImage(nil, forState: UIControlState.Normal)
		button3.setImage(nil, forState: UIControlState.Normal)
		button4.setImage(nil, forState: UIControlState.Normal)
		button5.setImage(nil, forState: UIControlState.Normal)
		button6.setImage(nil, forState: UIControlState.Normal)
		button7.setImage(nil, forState: UIControlState.Normal)
		button8.setImage(nil, forState: UIControlState.Normal)
	}

	func didCurrentPlayerWin(currentPosition: Int)-> Bool {
		for combination in winningCombinations {
			if(combination.contains(currentPosition)) {
				var set = Set<Player>()
				for index in combination {
					set.insert(gameState[index])
				}
				if set.count == 1 {
					return true
				}
			}
		}
		return false
	}

	func isGameOver()-> Bool {
		if !gameState.contains(Player.none) && winningPlayer == .none {
			//Match drawn
			return true
		}else if winningPlayer != .none {
			// Someone won
			return true
		}else {
			return false
		}
	}
	@IBAction func buttonPressed(sender: UIButton) {
		let buttonIndex = sender.tag
		if isGameOver() {
			return
		}else if gameState.contains(.none) && winningPlayer == .none {
			markPosition(buttonIndex, player: currentPlayer)
			if didCurrentPlayerWin(buttonIndex) {
				winningPlayer = currentPlayer
				if let gameOverCompletion = gameOverCompletion {
					gameOverCompletion(winningPlayer: currentPlayer)
				}

			}
		}else {
			if let gameOverCompletion = gameOverCompletion {
				gameOverCompletion(winningPlayer: .none)
			}

		}
		currentPlayer = currentPlayer == .first ? .second : .first
	}
}