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

class Location {

	var name: String
	var review: Float
	var isClosed: Bool
	
	init() {
		self.name = "N/A"
		self.review = -1
		isClosed = true
	}
	
	func printNeatly() {
		var str = "Name: \(name)"
		str += "\nReview: \(review) / 5"
		str += "\nisClosed: \(isClosed)"
		print("\(str)\n")
	}
}
