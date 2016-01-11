//
//  ScoreTableViewController.swift
//  TicTacToe
//
//  Created by Susmita Horrow on 11/01/16.
//  Copyright © 2016 Ashutosh. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
	var matches = [GameHistory]()

	override func viewDidLoad() {
		super.viewDidLoad()
	}
}

extension ScoreViewController: UITableViewDataSource {
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let history = matches[section]
		return history.gameResults.count
	}

	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return matches.count
	}

	func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return String("Match \(section)")
	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("scoreCell")
		let history = matches[indexPath.section]
		let gameInfo = history.gameResults[indexPath.row]
		let info = String("Game# \(indexPath.row)   \(gameInfo.stringForResult) against \(history.opponentName)")
		cell?.textLabel?.text  = info
		return cell!
	}
}


