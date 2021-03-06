//
//  ViewController.swift
//  Guess_the_number
//
//  Created by Stepan Kirillov on 9/17/21.
//

import UIKit

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
		_startNewGame()
		_setStartScreen()
		_assignBackground()
		_sliderView()
		// Do any additional setup after loading the view.
	}
	
	private func _sliderView() {
		let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
		slider.setThumbImage(thumbImageNormal, for: .normal)

		let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
		slider.setThumbImage(thumbImageHighlighted, for: .highlighted)

		let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
		let trackLeftImage = UIImage(named: "SliderTrackLeft")!
		let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
		slider.setMinimumTrackImage(trackLeftResizable, for: .normal)

		let trackRightImage = UIImage(named: "SliderTrackRight")!
		let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
		slider.setMaximumTrackImage(trackRightResizable, for: .normal)
	}
	
	private func _assignBackground(){
		let background = UIImage(named: "Background")

		var imageView : UIImageView!
		imageView = UIImageView(frame: view.bounds)
		imageView.contentMode =  UIView.ContentMode.scaleAspectFill
		imageView.clipsToBounds = true
		imageView.image = background
		imageView.center = view.center
		view.addSubview(imageView)
		self.view.sendSubviewToBack(imageView)
	}
	
	private func _startNewGame() {
		_round = 0
		_score = 0
		_setNewRound()
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
	
	private func _alertAction() {
		_setNewRound()
		_updateLabels()
	}
	
	private func _showFailAlert(difference: Int) {
		let alert = UIAlertController(title: "Failure!",
									  message: "The target Value is \(_targetValue)\n" +
											   "The current Value is \(_currentSliderValue)\n" +
											   "The difference is \(difference)\n",
									  preferredStyle: .alert)
		let action = UIAlertAction(title: "I will try again!", style: .cancel,
								   handler: {
									action in self._alertAction()
								   })
		alert.addAction(action)
		present(alert, animated: true, completion: nil)
	}
	
	private func _showSuccessAlert(difference: Int) {
		let alert = UIAlertController(title: "Success!",
									  message: "The target Value is \(_targetValue)\n" +
											   "The current Value is \(_currentSliderValue)\n" +
											   "The difference is \(difference)",
									  preferredStyle: .alert)
		let action = UIAlertAction(title: "OK!", style: .cancel,
								   handler: {
									action in self._alertAction()
								   })
		alert.addAction(action)
		present(alert, animated: true, completion: nil)
	}

	@IBAction func popUpAlert() {
		let difference = abs(_currentSliderValue - _targetValue)
		if (-_maxDifferenceFromTarget < difference && difference < _maxDifferenceFromTarget) {
			_showSuccessAlert(difference: difference)
			_score += _maxDifferenceFromTarget - difference + 1
		} else {
			_showFailAlert(difference: difference)
		}
	}
	
	@IBAction func sliderMoved(_ slider: UISlider) {
		_currentSliderValue = Int(slider.value)
	}
	
	@IBAction func startOver () {
		_startNewGame()
		_updateLabels()
	}
}

