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
	private let _failAlert		= AlertData(controllerTitle: "You failed",
										  controllerMessage: "Sucker, target value is: ",
										        actionTitle: "Sorry masta")
	private let _successAlert	= AlertData(controllerTitle: "You Did well",
										  controllerMessage: "pussy BOIIIII, target value is:",
											    actionTitle: "Ok")
	@IBOutlet weak var slider: UISlider!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		_targetValue = 1 + Int(arc4random_uniform(100))
		_currentSliderValue = Int(slider.value)
		print(_currentSliderValue)
		// Do any additional setup after loading the view.
	}

	private func _showFailAlert() {
		let controllerMsg = _failAlert.controllerMessage + String(_targetValue)
		let alert = UIAlertController(title: _failAlert.controllerTitle,
									  message: controllerMsg,
									  preferredStyle: .alert)
		let action = UIAlertAction(title: _failAlert.actionTitle, style: .cancel,
								   handler: nil)
		alert.addAction(action)
		present(alert, animated: true, completion: nil)
	}
	
	private func _showSuccessAlert() {
		let controllerMsg = _successAlert.controllerMessage + String(_targetValue)
		let alert = UIAlertController(title: _successAlert.controllerTitle,
									  message: controllerMsg,
									  preferredStyle: .alert)
		let action = UIAlertAction(title: _successAlert.actionTitle, style: .cancel,
								   handler: nil)
		alert.addAction(action)
		present(alert, animated: true, completion: nil)
	}

	@IBAction func popUpAlert() {
		let difference = _currentSliderValue - _targetValue
		if (-10 < difference && difference < 10) {
			_showSuccessAlert()
		} else {
			_showFailAlert()
		}
		_targetValue = 1 + Int(arc4random_uniform(100))
	}
	
	@IBAction func sliderMoved(_ slider: UISlider) {
		_currentSliderValue = Int(slider.value)
	}
}

