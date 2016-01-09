//
//  ViewController.swift
//  TicTacToe
//
//  Created by Susmita Horrow on 09/01/16.
//  Copyright © 2016 Ashutosh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var label: UILabel!
	@IBOutlet weak var PlayerTurnsLabel: UILabel!
	@IBOutlet weak var playAgainButton: UIButton!
	@IBOutlet weak var gameBoardView: GameBoardView!

	var goNumber = 1
	var winningCombinations = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
	var winner = 0


	override func viewDidLoad() {
		super.viewDidLoad()
		gameBoardView.gameOverCompletion = {[weak self] winner in
			guard let weakSelf = self else {
				return
			}
			if winner == 0 {
				weakSelf.PlayerTurnsLabel.text = "Player 1 won"
			}else if winner == 1 {
				weakSelf.PlayerTurnsLabel.text = "Player 2 won"
			}else {
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
		startNew()
		goNumber = 1
		winner = 0
		label.hidden = true
		playAgainButton.alpha = 0
		gameBoardView.startGame()
	}
}


