//
//  Deck.swift
//  Swift Euchre
//
//  Created by Chris Matlak on 12/6/15.
//  Copyright © 2015 Euchre US!. All rights reserved.
//

import Foundation
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


class Deck: CardCollection {
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

	
	// Make Deck
	var collective = [Card]()
	convenience required init() {
		self.init()
	}
	init(_ lowRank: Int, _ highRank: Int, number: Int?=1) {
		for _ in 1...number! {
			for suit in 1...4 {
				for rank in lowRank...highRank {
					collective.append(Card(rnk: rank, sut: suit))
				}
			}
		}
	}
	convenience init(lowRank: Rank, highRank: Rank, number: Int?=1) {
		self.init(lowRank.rawValue, highRank.rawValue, number: number)
	}
	
	// Deal
	func deal(_ hands: [Player], kitty: Hand?=nil, deadSize: Int?=0) {
		var kitty = kitty
		collective.shuffleInPlace()
		// Make sure the deal will work
		guard deadSize < self.count  else {
			print("No cards dealt, as reserved card count (\(deadSize)) is more than the deck size (\(self.count)).")
			return
		}
		
		// Set aside a guaranteed number of cards that will not be dealt
		let loc = deadSize
		
		// Give all players an equivalent number of cards
		while self.count-deadSize! >= hands.count {
			for var player in hands {
				// is there a way to treat self like hand and use it as a var instead of a let?
				player.hand.append(self.collective.remove(at: loc!))
			}
		}
		
		// Everyone sort your hands!
		for var player in hands {
			player.sort()
		}
		
		// Shove the remaining cards into the kitty (if provided)
		/* If a kitty is not provided, all remaining cards will remain in the deck
		and be visible to AI.  To have a separate kitty and discard piles, call this function twice
		*/
		guard kitty != nil else { return }
		for _ in self {
			kitty?.append(self.collective.removeFirst())
		}
	}
	
	// Since Swift does not yet have splats
	/*func deal(hands: Hand..., kitty: Hand?, deadSize: Int?) {
		deal(hands, kitty: kitty, deadSize: deadSize)
	}*/ // can't even use this anyway, since trying to do so causes the compiler to segfault 11
}

// Dislpay a deck
extension Deck: CustomStringConvertible {
	var description: String {
		let lines = 4
		let number = self.count / lines
		var out = ""
		for line in 0..<lines {
			for pos in 0..<number {
				out += self[line*number + pos].shortName()
				out += " "
			}
			out += "\n"
		}
		return out
	}
}

func makeEuchreDeck(_ number: Int?=1) -> Deck {
	return Deck.init(lowRank: (Rank).nine, highRank: (Rank).hiAce, number: number!)
}

func makeDoubleEuchreDeck() -> Deck {
	return makeEuchreDeck(2)
}

func makePinochleDeck() -> Deck {
	return makeDoubleEuchreDeck()
}

func makeStandardDeck(_ number: Int?=1) -> Deck {
	return Deck.init(lowRank: (Rank).two, highRank: (Rank).hiAce, number: number!)
}


enum deckType {
	case poker, standard, euchre, doubleEuchre, pinochle, other
	func makeDeck() -> Deck {
		switch self {
		case .poker:
			return makeStandardDeck()
		case .standard:
			return makeStandardDeck()
		case .doubleEuchre:
			return makeDoubleEuchreDeck()
		case .pinochle:
			return makePinochleDeck()
		default:
			return Deck.init()
		}
	}
}
