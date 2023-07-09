//
//  ViewController.swift
//  Maraphon3rdTask
//
//  Created by Артем Соколовский on 07.07.2023.
//

import UIKit

class ViewController: UIViewController {
	
	let animator = UIViewPropertyAnimator(duration: 1.0, curve: .linear)
	let scaleMultiplier: CGFloat = 1.5
	let degreesRotation: Double = 90
	
	lazy var squareView: UIView = {
		
		let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
		view.backgroundColor = .systemBlue
		view.layer.cornerRadius = 8
		return view
		
	}()
	
	lazy var slider: UISlider = {
		
		let slider = UISlider()
		slider.addTarget(self, action: #selector(sliderValueDidChanged(slider:)), for: .valueChanged)
		slider.addTarget(self, action: #selector(sliderTouchUp(slider:)), for: [.touchUpInside, .touchUpOutside])

		return slider
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		view.addSubview(squareView)
		view.addSubview(slider)
		
	}
	
	override func viewLayoutMarginsDidChange() {
		super.viewLayoutMarginsDidChange()
		
		slider.frame.origin.y = 250
		slider.frame.origin.x = view.layoutMargins.left
		slider.frame.size.width = view.frame.width - (view.layoutMargins.right + view.layoutMargins.left)
		
		let layoutEdge = slider.frame.size.width + slider.frame.origin.x
		
		configureStartAnimations()
		configureEndAnimations(layoutEdge: layoutEdge)
	}
	
	func configureStartAnimations() {
		squareView.frame.origin.y = 100
		squareView.frame.origin.x = view.layoutMargins.left
	}
	
	func configureEndAnimations(layoutEdge: CGFloat) {
		animator.addAnimations {
			self.squareView.frame.origin.x = layoutEdge - (self.squareView.frame.width * self.scaleMultiplier) + self.view.layoutMargins.right + 4
			self.squareView.transform = CGAffineTransform(rotationAngle: CGFloat(self.degreesRotation * Double.pi / 180)).concatenating(CGAffineTransform(scaleX: self.scaleMultiplier, y: self.scaleMultiplier))
		}
		animator.pausesOnCompletion = true
	}
	
	@objc func sliderValueDidChanged(slider: UISlider) {
		animator.fractionComplete = CGFloat(slider.value)
		
	}

	@objc func sliderTouchUp(slider: UISlider) {
		animator.startAnimation()
		slider.setValue(1.0, animated: true)
		
	}
}

