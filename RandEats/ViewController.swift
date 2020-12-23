//
//  ViewController.swift
//  RandEats
//
//  Created by Jeremy Louie on 12/20/20.
//  Copyright © 2020 Jeremy Louie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	let location = Location()
	
	let locationLabel = UILabel()
	let reviewLabel = UILabel()
	let bodyLabel = UILabel()
	let stackView = UIStackView()
	
	let findFoodButton = UIButton()
	let findDrinkButton = UIButton()
	
	fileprivate func setupButtons() {
		// green food button
		findFoodButton.frame = CGRect(x: view.frame.minX + 5, y: view.frame.midY - 50, width: 5, height: 100)
		findFoodButton.layer.cornerRadius = 2.5
		findFoodButton.clipsToBounds = true
		findFoodButton.backgroundColor = UIColor(red: 130.0 / 255.0, green: 182.0 / 255.0, blue: 172.0 / 255.0, alpha: 1.0)
		view.addSubview(findFoodButton)
		
		// pink drink button
		findDrinkButton.frame = CGRect(x: view.frame.maxX - 10, y: view.frame.midY - 50, width: 5, height: 100)
		findDrinkButton.layer.cornerRadius = 2.5
		findDrinkButton.clipsToBounds = true
		findDrinkButton.backgroundColor = UIColor(red: 232.0 / 255.0, green: 127.0 / 255.0, blue: 177.0 / 255.0, alpha: 1.0)
		view.addSubview(findDrinkButton)
	}
	
	fileprivate func setupLabels() {
		// location label
		locationLabel.numberOfLines = 0
		locationLabel.textAlignment = .left
		locationLabel.text = "Location"
		locationLabel.textColor = UIColor.white
		locationLabel.font = UIFont.systemFont(ofSize: 35, weight: UIFont.Weight.bold)
		
		// review label
		reviewLabel.numberOfLines = 0
		reviewLabel.textAlignment = .left
		reviewLabel.text = "\(location.review) / 5.0"
		reviewLabel.textColor = UIColor.white
		reviewLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
		
		// body label
		bodyLabel.numberOfLines = 0
		bodyLabel.textAlignment = .left
		bodyLabel.text = "This is about the location. It has some quick bites or good drinks, but not both; it's either one or the other!"
		bodyLabel.textColor = UIColor.white
		bodyLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
	}
	
	fileprivate func setupStackView() {
		//let stackView = UIStackView(arrangedSubviews: [locationLabel, reviewLabel, bodyLabel])
		stackView.insertArrangedSubview(locationLabel, at: 0)
		stackView.insertArrangedSubview(reviewLabel, at: 1)
		stackView.insertArrangedSubview(bodyLabel, at: 2)
		stackView.axis = .vertical
		stackView.spacing = 8
		view.addSubview(stackView)
		
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: self.view.center.x + 200).isActive = true
		stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
		stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100).isActive = true

		// animating stackview label
		UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
				//stackView.transform = CGAffineTransform(translationX: -20, y: 0)
				self.stackView.transform = CGAffineTransform(translationX: -20, y: 0)
		}) { (_) in
			UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations:  {

				//stackView.transform = self.locationLabel.transform.translatedBy(x: -385, y: 0)
				self.stackView.transform = self.locationLabel.transform.translatedBy(x: -385, y: 0)
			})
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.view.backgroundColor = UIColor(red: 28.0 / 255.0, green: 29.0 / 255.0, blue: 31.0 / 255.0, alpha: 1.0)
		
		setupButtons()
		setupLabels()
		setupStackView()
		
		// setting up animations
		let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapAnimation))
		self.stackView.addGestureRecognizer(tap)
		
		let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeLeft))
		swipeLeft.direction = .left
		self.stackView.addGestureRecognizer(swipeLeft)
		
		let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeRight))
		swipeRight.direction = .right
		self.stackView.addGestureRecognizer(swipeRight)
	}
	
	@objc func handleTapAnimation() {
		// animating location label
		UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
			self.locationLabel.transform = CGAffineTransform(translationX: -20, y: 0)
		}) { (_) in
			UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations:  {
				
				self.locationLabel.alpha = 0
				self.locationLabel.transform = self.locationLabel.transform.translatedBy(x: 0, y: -150)
			})
		}
		
		// animating reviews
		UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
			self.reviewLabel.transform = CGAffineTransform(translationX: -20, y: 0)
		}) { (_) in
			UIView.animate(withDuration: 0.5, delay: 0.25, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations:  {
				
				self.reviewLabel.alpha = 0
				self.reviewLabel.transform = self.locationLabel.transform.translatedBy(x: 0, y: -150)
			})
		}
		
		// animating body label
		UIView.animate(withDuration: 0.5, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
			self.bodyLabel.transform = CGAffineTransform(translationX: -20, y: 0)
		}) { (_) in
			UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations:  {
				
				self.bodyLabel.alpha = 0
				self.bodyLabel.transform = self.locationLabel.transform.translatedBy(x: 0, y: -150)
			})
		}
	}
	
	@objc func handleSwipeLeft() {
		print("swipe left")
	}
	
	@objc func handleSwipeRight() {
		print("swipe right")
	}
}

