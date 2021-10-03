//
//  AboutViewController.swift
//  Guess_the_number
//
//  Created by Stepan Kirillov on 9/29/21.
//

import UIKit

class AboutViewController: UIViewController {

	override func viewDidLoad() {
        super.viewDidLoad()
		_assignBackground()
        // Do any additional setup after loading the view.
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
	
	@IBAction func close() {
		dismiss(animated: true, completion: nil)
	}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
