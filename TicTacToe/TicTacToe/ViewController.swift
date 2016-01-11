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
	@IBOutlet weak var segmentControl: UISegmentedControl!
	var game = Game()
	var matches = [GameHistory]()
	var gameCount = 0
	var nextTurn = Player.first
	var playerAI = Player.second

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
			for match in weakSelf.matches {
				print("Matches = \(match)")
			}
			if winner == Player.first {
				weakSelf.PlayerTurnsLabel.text = "Player 1 won"
				weakSelf.nextTurn = Player.first
			}else if winner == Player.second {
				weakSelf.PlayerTurnsLabel.text = "Player 2 won"
				weakSelf.nextTurn = Player.second
			}else {
				weakSelf.PlayerTurnsLabel.text = "Match Drawn"
				weakSelf.nextTurn = weakSelf.game.playerLastTapped!
			}
		}
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func playAgainButtonPressed(sender: UIButton) {
		game.currentPlayer = nextTurn
		PlayerTurnsLabel.text = "Get 3 in a Row to Win"
		label.hidden = true
		
		if game.isTwoPlayerGame == false {
			if nextTurn == playerAI { // AI won
				game.currentPlayer = nextTurn
				game.firstMoveByAI()
			} else {
				game.startGame()
			}
		}else {
			game.startGame()
		}
	}

	@IBAction func handlePlayerMode(sender: AnyObject) {
		game.isTwoPlayerGame =  segmentControl.selectedSegmentIndex == 1
		playAgainButtonPressed(playAgainButton)
	}
}


