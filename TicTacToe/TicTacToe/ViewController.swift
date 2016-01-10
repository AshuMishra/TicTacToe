//
//  ViewController.swift
//  TicTacToe
//
//  Created by Ashutosh Mishra on 09/01/16.
//  Copyright © 2016 Ashutosh. All rights reserved.
//

import UIKit

struct GameHistory {
	var gameNumber: Int
	var winner : Player
}

class ViewController: UIViewController {

	@IBOutlet weak var label: UILabel!
	@IBOutlet weak var PlayerTurnsLabel: UILabel!
	@IBOutlet weak var playAgainButton: UIButton!
	@IBOutlet weak var gameBoardView: GameBoardView!
	var game = Game()
	var matches = [GameHistory]()
	var goNumber = 1
	var lastPlayer = Player.first
	var winningCombinations = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
	var gameCount = 0

	override func viewDidLoad() {
		super.viewDidLoad()
		game.gameBoard = gameBoardView
		game.isTwoPlayerGame = false
		game.currentPlayer = .first
		game.gameOverCompletion = {[weak self] winner in
			guard let weakSelf = self else {
				return
			}
			weakSelf.gameCount++
			let history = GameHistory(gameNumber: weakSelf.gameCount, winner: winner)
			weakSelf.matches.append(history)
			print("***********************\n")
			for match in weakSelf.matches {
				print("Matches = \(match)")
			}
			if winner == Player.first {
				weakSelf.lastPlayer = Player.first
				weakSelf.PlayerTurnsLabel.text = "Player 1 won"
			}else if winner == Player.second {
				 weakSelf.lastPlayer = Player.second
				weakSelf.PlayerTurnsLabel.text = "Player 2 won"
			}else {
				weakSelf.lastPlayer = weakSelf.game.currentPlayer
				weakSelf.PlayerTurnsLabel.text = "Match Drawn"
			}
		}
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func startNew() {
		PlayerTurnsLabel.text = "Get 3 in a Row to Win"
	}

	@IBAction func playAgainButtonPressed(sender: UIButton){
		game.currentPlayer = lastPlayer
		startNew()
		goNumber = 1
		label.hidden = true
		game.startGame()
	}
}


