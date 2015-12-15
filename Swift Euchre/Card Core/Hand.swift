//
//  Hand.swift
//  Swift Euchre
//
//  Created by Chris Matlak on 12/6/15.
//  Copyright © 2015 Euchre US!. All rights reserved.
//

import Foundation

final class Hand: CardCollection {
	var collective = [Card]()
	init() { }
	
	func playCard(loc: Int) -> Card {
		return collective.removeAtIndex(loc)
	}
	
}

extension Hand: CustomStringConvertible {
	var description: String {
		var out = ""
		for 🎴 in self {
			out += 🎴.shortName() + "\t"
		}
		return out
	}
	func selectionDisplay() {
		print(self)
		for i in 0..<self.count {
			print(i.description + "\t")
		}
	}
}