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
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func someOneWon() {
	}


	func NoOneWon() {

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
		gameBoardView.resetPositions()
	}

	@IBAction func buttonPressed(sender: UIButton) {

//		if gameState[sender.tag] == 0 && winner == 0
//		{
//			var image = UIImage()
//
//			if goNumber % 2 == 0
//			{
//				image = UIImage(named: "Triangle.png")!
//
//				gameState[sender.tag] = 2
//				PlayerTurnsLabel.text = "It's Circles Turn"
//			}
//			else
//			{
//				image = UIImage(named: "circle.png")!
//				gameState[sender.tag] = 1
//				PlayerTurnsLabel.text = "It's Triangles Turn"
//
//			}
//
//			for combination in winningCombinations
//			{
//				if gameState[combination[0]] == gameState[combination[1]] &&
//					gameState[combination[0]] == gameState[combination[2]] &&
//					gameState[combination[0]] != 0
//				{
//					winner = gameState[combination[0]]
//				}
//			}
//
//			if winner != 0
//			{
//				someOneWon()
//				self.label.transform = CGAffineTransformMakeTranslation(-350, 0)
////				springWithDelay(0.9, delay: 0.2, animations: {
////					self.label.transform = CGAffineTransformMakeTranslation(0, 0)
////				})
//
//
//				if winner == 1
//				{
//					label.text = "Circle has won!"
//					PlayerTurnsLabel.text = ""
//				}
//				else
//				{
//					label.text = "Triangle has won!"
//					PlayerTurnsLabel.text = ""
//				}
//
//				UIView.animateWithDuration(0.5, animations:
//					{
//
//						self.label.hidden = false
//
//						self.playAgainButton.alpha = 1
//
//						self.playAgainButton.transform = CGAffineTransformMakeTranslation(0, -450)
////						springWithDelay(0.9, delay: 0.2, animations: {
////							self.playAgainButton.transform = CGAffineTransformMakeTranslation(0, 0)
////						})
//					}
//				)
//			}
//
//			goNumber++
//			sender.setImage(image, forState: UIControlState.Normal)
//
//			if goNumber == 10 && winner == 0
//			{
//				NoOneWon()
//				label.text = "No winner!"
//				UIView.animateWithDuration(0.5, animations:
//					{
//						self.label.hidden = false
//						self.label.center = CGPointMake(self.label.center.x + 400, self.label.center.y)
//						self.playAgainButton.alpha = 1
//						self.PlayerTurnsLabel.text = ""
//					}
//				)
//			}
//		}
	}

}


