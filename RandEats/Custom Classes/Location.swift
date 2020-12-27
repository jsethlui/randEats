//
//  Location.swift
//  RandEats
//
//  Created by Jeremy Louie on 12/20/20.
//  Copyright © 2020 Jeremy Louie. All rights reserved.
//

// client key = drkAE7iHjBKdnDLfEhi4AA
// API key = VV6lqYVeipQ-1KBYzs280Rc7j3CzB1QCn_d-hArzhLoMgaIEagm1XxKsFscP_IqMvrSdYRI0al1MPZYvmO0NhCYKVuQ46mmuZ3PpCS4SNW0K0f4LDBoSZtabE0a_X3Yx

import Foundation

struct Type {
	var restaurant = "Restaurant"
	var drinks = "Drinks"
	var none = "None"
}

class Location {
	let locationType = Type()
	
	var name: String
	var review: Float
	var type: String
	var isClosed: Bool
	
	init() {
		self.name = "N/A"
		self.review = -1
		self.type = locationType.none
		isClosed = true
	}
}
