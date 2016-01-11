//
//  Game.swift
//  TicTacToe
//
//  Created by Ashutosh Mishra on 10/01/16.
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

class Game: GameBoardViewDelegate {
	var currentPlayer: Player = Player.first
	var winningPlayer: Player = Player.none
	var gameOverCompletion: GameOverCompletion?
	var playerLastTapped: Player?

	private var gameState = [Player](count: 9, repeatedValue: .none)
	private let winningCombinations = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
	private let corners = [0, 2, 6, 8]
	private let center = 4
	private let edges = [1, 3, 5, 7]

	var isTwoPlayerGame: Bool = true
	var gameBoard: GameBoardView = GameBoardView() {
		didSet{
			gameBoard.delegate = self
		}
	}

	func startGame() {
		winningPlayer = .none
		gameState = [Player](count: 9, repeatedValue: winningPlayer)
		gameBoard.resetPositions()
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

	func firstMoveByAI() {
		startGame()
		if let move = casualMove() {
			mark(move)
		}
	}
	
	private func mark(let position: Int) {
		if gameState[position] != .none {
			return
		}
		if isGameOver() {
			return
		}else if gameState.contains(.none) && winningPlayer == .none {
			gameState[position] = currentPlayer
			gameBoard.markPosition(position, player: currentPlayer)
		}
		checkWinningPosition(currentPlayer,index: position)
		currentPlayer = currentPlayer == .first ? .second : .first

	}

	private func didCurrentPlayerWin(currentPosition: Int)-> Bool {
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

	private func isFirstMove()-> Bool {
		let set = Set(gameState)
		return set.count == 1
	}

	private func nextPossibleMove()-> Int? {
		var nextPosition: Int?
		if isFirstMove() {
			nextPosition = casualMove()
		}else if let winningPosition = winningMove() { //Check if the AI has two pieces in a row and can place a third, and if so place it there to win (horizontal, vertical and diagonal)
			nextPosition = winningPosition
		}else if let blockingPosition = blockingMove() {
			nextPosition = blockingPosition
		}else {
			nextPosition = casualMove()
		}
		return nextPosition
	}

	private func winningMove()-> Int? {
		var nextPosition: Int?
		let combination = winningCombination(currentPlayer)
		for index in combination {
			if gameState[index] == .none {
				nextPosition = index
			}
		}
		return nextPosition
	}

	private func blockingMove()-> Int? {
		var nextPosition: Int?
		let opponent = currentPlayer == .first ? Player.second : Player.first
		let combination = winningCombination(opponent)
		for index in combination {
			if gameState[index] == .none {
				nextPosition = index
			}
		}
		return nextPosition
	}

	private func winningCombination(player: Player)-> [Int] {
		var result = [Int]()
		for (index, element) in gameState.enumerate() {
			if element == player {
				let combinationWithIndex = winningCombinations.filter { $0.contains(index)}
				for combination in combinationWithIndex {
					let countOfCurrentPlayerPosition = combination.filter({ (element) -> Bool in
						gameState[element] == player
					}).count
					let counOfNonePlayerPosition = combination.filter({ (element) -> Bool in
						gameState[element] == .none
					}).count
					if countOfCurrentPlayerPosition == 2 && counOfNonePlayerPosition == 1 {
						result = combination
					}
				}
			}
		}
		return result
	}

	private func casualMove()-> Int? {
		var nextPosition: Int?
		if let centerPosition = getBlankPosition([center]) {
			nextPosition = centerPosition
		}else if let cornerPosition = getBlankPosition(corners) {
			 nextPosition = cornerPosition
		}else if let edgePosition = getBlankPosition(edges) {
			 nextPosition = edgePosition
		}
		return nextPosition
	}

	private func firstMove()-> Int? {
		var nextPosition: Int?
		var positions = corners
		positions.append(center)
		for position in positions {
			if gameState[position] == Player.none {
				nextPosition = position
			}
		}
		return nextPosition
	}

	private func getBlankPosition(options: [Int]) -> Int? {
		var blankPosition: Int?
		for position in options {
			if gameState[position] == Player.none {
				blankPosition = position
			}
		}
		return blankPosition
	}

	func handleButtonPress(index: Int) {
		playerLastTapped = currentPlayer
		mark(index)
		if isTwoPlayerGame == false {
			playerLastTapped = currentPlayer
			// handle move for computer
			if let nextPosition = nextPossibleMove() {
				mark(nextPosition)
			}
		}
	}

	func checkWinningPosition(player: Player, index: Int) {
		if didCurrentPlayerWin(index) {
			winningPlayer = currentPlayer
			if let gameOverCompletion = gameOverCompletion {
				gameOverCompletion(winningPlayer: winningPlayer)
			}
		}else if isGameOver() {
			if let gameOverCompletion = gameOverCompletion {
				gameOverCompletion(winningPlayer: .none)
			}
		}
	}
}
