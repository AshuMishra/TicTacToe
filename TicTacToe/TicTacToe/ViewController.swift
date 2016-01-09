//
//  ViewController.swift
//  TicTacToe
//
//  Created by Susmita Horrow on 09/01/16.
//  Copyright © 2016 Ashutosh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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

	@IBOutlet weak var label: UILabel!
	@IBOutlet weak var PlayerTurnsLabel: UILabel!
	@IBOutlet weak var playAgainButton: UIButton!


	var goNumber = 1
	var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
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


}

