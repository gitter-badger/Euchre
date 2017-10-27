//
//  Hand.swift
//  Swift Euchre
//
//  Created by Chris Matlak on 12/6/15.
//  Copyright © 2015 Euchre US!. All rights reserved.
//

import Foundation

final class Hand: CardCollection {
	func index(after i: Int) -> Int {
		return i + 1
	}


	var collective = [Card]()
	init() { }
	
	func playCard(_ loc: Int) -> Card {
		return collective.remove(at: loc)
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
			print(String(format: "%02d", i), terminator: "\t")
		}
		print("") // add newline to end of each Hand
	}
}

protocol HandPossessor {
	var hand: Hand { get set }
	func playCard() -> Card
	mutating func sort()
}

extension HandPossessor {
	
}
