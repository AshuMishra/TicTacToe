//
//  GameBoardView.swift
//  TicTacToe
//
//  Created by Ashutosh Mishra on 09/01/16.
//  Copyright © 2016 Ashutosh. All rights reserved.
//

import Foundation
import UIKit

protocol GameBoardViewDelegate {
	func handleButtonPress(index: Int)
}

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
	@IBOutlet var buttonCollection: [UIButton]!

	var delegate: GameBoardViewDelegate?
	private var line = CAShapeLayer()

	func markPosition(position: Int, player: Player) {
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
		line.strokeColor = UIColor.clearColor().CGColor
	}

	func drawLine(combination: [Int]) {
		var points = [CGPoint]()
		for index in combination {
			let button = buttonCollection.filter({ (button) -> Bool in
				return button.tag == index
			}).first
			points.append(CGPoint(x: CGRectGetMidX(button!.frame), y: CGRectGetMidY(button!.frame)))
		}
		drawLine(points[0], end: points[2])
	}

	func drawLine(start: CGPoint, end: CGPoint) {
		let linePath = UIBezierPath()
		linePath.moveToPoint(start)
		linePath.addLineToPoint(end)
		line.path = linePath.CGPath
		line.fillColor = nil
		line.opacity = 1.0
		line.lineWidth = 10.0
		line.strokeColor = UIColor.blackColor().CGColor
		layer.addSublayer(line)
	}

	@IBAction func buttonPressed(sender: UIButton) {
		let buttonIndex = sender.tag
		if let delegate = delegate {
			delegate.handleButtonPress(buttonIndex)
		}
	}
}