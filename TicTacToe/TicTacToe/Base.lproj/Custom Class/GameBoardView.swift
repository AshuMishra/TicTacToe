//
//  GameBoardView.swift
//  TicTacToe
//
//  Created by Susmita Horrow on 09/01/16.
//  Copyright © 2016 Ashutosh. All rights reserved.
//

import Foundation
import UIKit

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

	var currentPlayer: Int = 0

	var gameState = [-1, -1, -1, -1, -1, -1, -1, -1, -1]

	func markPosition(position: Int, player: Int) {
		gameState[position] = player
		let image = imageForPlayer(player)
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

	func resetPositions() {
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

	func imageForPlayer(player: Int)-> UIImage {
		switch(player) {
		case 0:
			return UIImage(named: "Triangle.png")!
		case 1:
			return UIImage(named: "circle.png")!
		default:
			return UIImage()
		}
	}

	@IBAction func buttonPressed(sender: UIButton) {
		let buttonIndex = sender.tag
		markPosition(buttonIndex, player: currentPlayer)
		currentPlayer = currentPlayer == 0 ? 1 : 0
	}
}