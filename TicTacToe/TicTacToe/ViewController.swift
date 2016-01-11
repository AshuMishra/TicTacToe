//
//  ViewController.swift
//  TicTacToe
//
//  Created by Ashutosh Mishra on 09/01/16.
//  Copyright © 2016 Ashutosh. All rights reserved.
//

import UIKit

enum GameResult {
	case win
	case lose
	case draw

	var stringForResult: String {
		switch self {
		case .win:
			return "Won"
		case .lose:
			return "Lost"
		case .draw:
			return "Draw"
		}
	}
}

struct GameHistory {
	var opponentName = String()
	var gameResults = [GameResult]()
}

class ViewController: UIViewController {

	@IBOutlet weak var PlayerTurnsLabel: UILabel!
	@IBOutlet weak var playAgainButton: UIButton!
	@IBOutlet weak var segmentControl: UISegmentedControl!
	@IBOutlet weak var gameBoardView: GameBoardView!

	var game = Game()
	var matches = [GameHistory]()
	var gameCount = 0
	var nextTurn = Player.first
	var playerAI = Player.second

	override func viewDidLoad() {
		super.viewDidLoad()
		game.isTwoPlayerGame = false
		game.gameBoard = gameBoardView
		game.currentPlayer = .first
		segmentControl.selectedSegmentIndex = 0
		startMatch()
		game.gameOverCompletion = {[weak self] winner in
			guard let weakSelf = self else {
				return
			}
			var history = weakSelf.matches.last
			weakSelf.gameCount++
			if winner == Player.first {
				weakSelf.PlayerTurnsLabel.text = "Player 1 won"
				weakSelf.nextTurn = Player.first
				history!.gameResults.append(GameResult.win)
			}else if winner == Player.second {
				weakSelf.PlayerTurnsLabel.text = "Player 2 won"
				weakSelf.nextTurn = Player.second
				history!.gameResults.append(GameResult.lose)
			}else {
				weakSelf.PlayerTurnsLabel.text = "Match Drawn"
				weakSelf.nextTurn = weakSelf.game.playerLastTapped!
				history!.gameResults.append(GameResult.draw)
			}
			weakSelf.matches.removeLast()
			weakSelf.matches.append(history!)
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func playAgainButtonPressed(sender: UIButton) {
		game.currentPlayer = nextTurn
		PlayerTurnsLabel.text = "Get 3 in a Row to Win"
		
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
		startMatch()
		playAgainButtonPressed(playAgainButton)
	}

	func startMatch() {
		let player = game.isTwoPlayerGame ?  "Player 2" : "Computer"
		let history = GameHistory(opponentName: player, gameResults: [])
		matches.append(history)
	}

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "viewScore" {
			let destinationVC = segue.destinationViewController as! ScoreViewController
			destinationVC.matches = matches
		}
	}
}


