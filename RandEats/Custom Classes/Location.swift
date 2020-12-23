//
//  Location.swift
//  RandEats
//
//  Created by Jeremy Louie on 12/20/20.
//  Copyright © 2020 Jeremy Louie. All rights reserved.
//

import Foundation

struct Type {
	var restaurant = "Restaurant"
	var drinks = "Drinks"
	var none = "None"
}

class Location {
	let locationType = Type()
	
	var name: String
	var review: Int
	var type: String
	
	init() {
		self.name = "N/A"
		self.review = -1
		self.type = locationType.none
	}
}
