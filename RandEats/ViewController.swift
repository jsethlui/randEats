//
//  ViewController.swift
//  RandEats
//
//  Created by Jeremy Louie on 12/20/20.
//  Copyright © 2020 Jeremy Louie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	var locations: [Location] = []
	
	let locationLabel = UILabel()
	let reviewLabel = UILabel()
	let bodyLabel = UILabel()
	let stackView = UIStackView()
	
	let findFoodButton = UIButton()
	let findDrinkButton = UIButton()
	
	// buttons currently disabled
	fileprivate func setupButtons() {
		// green food button
		findFoodButton.frame = CGRect(x: view.frame.minX + 5, y: view.frame.midY - 50, width: 5, height: 100)
		findFoodButton.layer.cornerRadius = 2.5
		findFoodButton.clipsToBounds = true
		findFoodButton.backgroundColor = UIColor(red: 130.0 / 255.0, green: 182.0 / 255.0, blue: 172.0 / 255.0, alpha: 1.0)
		//view.addSubview(findFoodButton)
		
		// pink drink button
		findDrinkButton.frame = CGRect(x: view.frame.maxX - 10, y: view.frame.midY - 50, width: 5, height: 100)
		findDrinkButton.layer.cornerRadius = 2.5
		findDrinkButton.clipsToBounds = true
		findDrinkButton.backgroundColor = UIColor(red: 232.0 / 255.0, green: 127.0 / 255.0, blue: 177.0 / 255.0, alpha: 1.0)
		//view.addSubview(findDrinkButton)
	}
	
	fileprivate func setupLabels() {
		// location label
		locationLabel.numberOfLines = 0
		locationLabel.textAlignment = .center
//		locationLabel.text = "Location"
		locationLabel.textColor = UIColor.white
		locationLabel.font = UIFont.systemFont(ofSize: 35, weight: UIFont.Weight.bold)
		
		// review label
		reviewLabel.numberOfLines = 0
		reviewLabel.textAlignment = .center
//		reviewLabel.text = "\(location.review) / 5.0"
		reviewLabel.text = "6 / 5"
		reviewLabel.textColor = UIColor.white
		reviewLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
		
		// body label
		bodyLabel.numberOfLines = 0
		bodyLabel.textAlignment = .center
		bodyLabel.text = "This is about the location. It has some quick bites or good drinks, but not both; it's either one or the other!"
		bodyLabel.textColor = UIColor.white
		bodyLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
	}
	
	fileprivate func setupStackView() {
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
				self.stackView.transform = CGAffineTransform(translationX: -20, y: 0)
		}) { (_) in
			UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations:  {

				self.stackView.transform = self.locationLabel.transform.translatedBy(x: -385, y: 0)
			})
		}
	}
	
	fileprivate func generateAndSetLocations() {
		// location currently set for New York
		let CPLatitude = 40.782483
		let CPLongitude = -73.963540
		retrieveAllLocations(latitude: CPLatitude, longitude: CPLongitude, category: "food", limit: 20, sortBy: "distance", locale: "en_US") { (response, error) in
			if let response = response {
				self.locations = response	// location array generated here
				
				DispatchQueue.main.async {
					self.locationLabel.text = self.locations[0].name
					self.reviewLabel.text = "\(self.locations[0].review) / 5"
				}
			}
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.view.backgroundColor = UIColor(red: 28.0 / 255.0, green: 29.0 / 255.0, blue: 31.0 / 255.0, alpha: 1.0)
		
		generateAndSetLocations()
		setupButtons()
		setupLabels()
		setupStackView()

		// setting up tap and swipe animations
		let tap = UITapGestureRecognizer(target: self, action: #selector(handleAnimation))
		self.stackView.addGestureRecognizer(tap)
		
		let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleAnimation))
		swipeLeft.direction = .left
		self.stackView.addGestureRecognizer(swipeLeft)
		
		let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleAnimation))
		swipeRight.direction = .right
		self.stackView.addGestureRecognizer(swipeRight)
	}

	@objc func handleAnimation(gesture: UIGestureRecognizer) {
		var setTranslationX: CGFloat = 0
		var setY: CGFloat = 0
	
		if let swipeGesture = gesture as? UISwipeGestureRecognizer {
			switch swipeGesture.direction {
				case .right:
					print("right")
					setTranslationX = 20
					setY = 0
				case .left:
					print("left")
					setTranslationX = -20
					setY = 0
				default:
					setTranslationX = 0
					setY = 20
					print("tap")
			}
		}

	
		// animating location label
		UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
			self.locationLabel.transform = CGAffineTransform(translationX: setTranslationX, y: setY)
		}) { (_) in
			UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations:  {
				
				self.locationLabel.alpha = 0
				self.locationLabel.transform = self.locationLabel.transform.translatedBy(x: 0, y: -150)
			})
		}
		
		// animating reviews
		UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
			self.reviewLabel.transform = CGAffineTransform(translationX: setTranslationX, y: setY)
		}) { (_) in
			UIView.animate(withDuration: 0.5, delay: 0.25, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations:  {
				
				self.reviewLabel.alpha = 0
				self.reviewLabel.transform = self.locationLabel.transform.translatedBy(x: 0, y: -150)
			})
		}
		
		// animating body label
		UIView.animate(withDuration: 0.5, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
			self.bodyLabel.transform = CGAffineTransform(translationX: setTranslationX, y: setY)
		}) { (_) in
			UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations:  {
				
				self.bodyLabel.alpha = 0
				self.bodyLabel.transform = self.locationLabel.transform.translatedBy(x: 0, y: -150)
			})
		}
	}
}

extension ViewController {
	func retrieveAllLocations(latitude: Double,
							  longitude: Double,
							  category: String,
							  limit: Int,
							  sortBy: String,
							  locale: String,
							  completionHandler: @escaping([Location]?, Error?) -> Void) {
		let apiKey = "VV6lqYVeipQ-1KBYzs280Rc7j3CzB1QCn_d-hArzhLoMgaIEagm1XxKsFscP_IqMvrSdYRI0al1MPZYvmO0NhCYKVuQ46mmuZ3PpCS4SNW0K0f4LDBoSZtabE0a_X3Yx"
		let baseURL = "https://api.yelp.com/v3/businesses/search?latitude=\(latitude)&longitude=\(longitude)&categories=\(category)&limit=\(limit)&sort_by=\(sortBy)&locale=\(locale)"
		let url = URL(string: baseURL)
		
		// creating request
		var request = URLRequest(url: url!)
		request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
		request.httpMethod = "GET"
		
		URLSession.shared.dataTask(with: request) { (data, response, error) in
			if let error = error {
				completionHandler(nil, error)
			}
			do {
				// reading data as JSON
				let json = try JSONSerialization.jsonObject(with: data!, options: [])
				
				// main dictionary
				guard let resp = json as? NSDictionary else { return }
				
				// businesses
				guard let businesses = resp.value(forKey: "businesses") as? [NSDictionary] else { return }
				
				var locationList = [Location]()
				
				for business in businesses {
					let location = Location()
					location.name = business.value(forKey: "name") as! String
					location.review = business.value(forKey: "rating") as! Float
					location.isClosed = business.value(forKey: "is_closed") as! Bool
					locationList.append(location)
				}
				completionHandler(locationList, nil)
			} catch {
				print("Caught error")
				completionHandler(nil, error)
			}
			}.resume()
	}
}

