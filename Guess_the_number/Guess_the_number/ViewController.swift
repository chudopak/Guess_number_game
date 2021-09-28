//
//  ViewController.swift
//  Guess_the_number
//
//  Created by Stepan Kirillov on 9/17/21.
//

import UIKit

struct AlertData {
	let controllerTitle: String
	let controllerMessage: String
	let actionTitle: String
}

class ViewController: UIViewController
{
	
	private var _currentSliderValue: Int = 0
	private var _targetValue: Int = 0
	private var _score: Int = 0
	private var _round: Int = 0
	private let _sliderMaxValue: Int = 100
	private let _maxDifferenceFromTarget: Int = 3
	private let _maxTarget: Int = 100
	private let _minTarget: Int = 1
	
	@IBOutlet weak var slider: UISlider!
	@IBOutlet weak var score: UILabel!
	@IBOutlet weak var round: UILabel!
	@IBOutlet weak var maxTargetLabel: UILabel!
	@IBOutlet weak var minTargetLabel: UILabel!
	@IBOutlet weak var targetLabel: UILabel!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		_setNewRound()
		_setStartScreen()
		// Do any additional setup after loading the view.
	}
	
	private func _setStartScreen() {
		maxTargetLabel.text = String(_maxTarget)
		minTargetLabel.text = String(_minTarget)
		_updateLabels()
	}
	
	private func _updateLabels() {
		score.text = String(_score)
		targetLabel.text = String(_targetValue)
		round.text = String(_round)
	}
	
	private func _setNewRound() {
		_round += 1
		_targetValue = 1 + Int(arc4random_uniform(UInt32(_sliderMaxValue)))
		slider.value = Float(_sliderMaxValue / 2)
		_currentSliderValue = Int(slider.value)
	}
	
	private func _showFailAlert(difference: Int) {
		let alert = UIAlertController(title: "Failure!",
									  message: "The target Value is \(_targetValue)\n" +
											   "The current Value is \(_currentSliderValue)\n" +
											   "The difference is \(abs(difference))\n",
									  preferredStyle: .alert)
		let action = UIAlertAction(title: "FOOOk, I will try again!", style: .cancel,
								   handler: nil)
		alert.addAction(action)
		present(alert, animated: true, completion: nil)
	}
	
	private func _showSuccessAlert(difference: Int) {
		let alert = UIAlertController(title: "Success!",
									  message: "The target Value is \(_targetValue)\n" +
											   "The current Value is \(_currentSliderValue)\n" +
											   "The difference is \(abs(difference))",
									  preferredStyle: .alert)
		let action = UIAlertAction(title: "My Bigga", style: .cancel,
								   handler: nil)
		alert.addAction(action)
		present(alert, animated: true, completion: nil)
	}

	@IBAction func popUpAlert() {
		let difference = _currentSliderValue - _targetValue
		if (-_maxDifferenceFromTarget < difference && difference < _maxDifferenceFromTarget) {
			_showSuccessAlert(difference: difference)
			_score += _maxDifferenceFromTarget - abs(difference)
		} else {
			_showFailAlert(difference: difference)
		}
		_setNewRound()
		_updateLabels()
	}
	
	@IBAction func sliderMoved(_ slider: UISlider) {
		_currentSliderValue = Int(slider.value)
	}
}

