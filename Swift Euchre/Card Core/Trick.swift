//
//  Trick.swift
//  Swift Euchre
//
//  Created by Chris Matlak on 12/15/15.
//  Copyright © 2015 Euchre US!. All rights reserved.
//

import Foundation

class Trick: CardCollection {
	/// Returns the position immediately after the given index.
	///
	/// The successor of an index must be well defined. For an index `i` into a
	/// collection `c`, calling `c.index(after: i)` returns the same index every
	/// time.
	///
	/// - Parameter i: A valid index of the collection. `i` must be less than
	///   `endIndex`.
	/// - Returns: The index value immediately after `i`.
	func index(after i: Int) -> Int {
		return i + 1
	}

	var collective = [Card]()
	required init() {  }
	
	// Return the position of the winning card
	func score(_ alt: Bool, alternateScoring: (Card, Card) -> Bool?=LoNo, scoringfunction: (Card, Card, (Card, Card) -> Bool?) -> Bool?=beats) -> Int {
		var winPos = 0
		for rLoc in 1..<self.count-1 {
			if beats(self[winPos], self[rLoc], SortFunction: alt ? LoNo : SuitSorted) { // since I can't use alt ? LoNo : nil for some reason
				winPos = rLoc
			}
		}
		return winPos
	}
	
	deinit {
		empty(nil)
	}
	
	func returnToDeck(loc pos: Int?=nil, deck: Deck?) -> Card? {
		var deck = deck
		if let pos = pos {
			guard pos < self.count else {
				print("Index \(pos) is greater than trick size (\(self.count))")
				return nil
			}
			let 🎴 = collective.remove(at: pos)
			deck!.append(🎴)
			return 🎴
		} else {
			return returnToDeck(loc: 0, deck: deck)
		}
	}
	
	func empty(_ deck: Deck?) {
		for _ in 1...self.count {
			returnToDeck(loc: 0, deck: deck)
		}
	}
	
}

extension Trick: CustomStringConvertible {
	var description: String {
		var out = ""
		for 🎴 in self {
			out += 🎴.shortName() + " "
		}
		return out
	}
}

// Returns whether the R card beats the L card (must follow suit or be trump)
func beats(_ L🎴: Card, _ R🎴: Card, SortFunction: (Card, Card) -> Bool?=SuitSorted) -> Bool {
	if R🎴.suit != L🎴.suit && R🎴.suit != (Suit).trump {
		return false
	}
	return SortFunction(L🎴, R🎴)!
}

func LoNo(_ L🎴: Card, _ R🎴: Card) -> Bool {
	return R🎴.suit == L🎴.suit && R🎴 < L🎴
}
