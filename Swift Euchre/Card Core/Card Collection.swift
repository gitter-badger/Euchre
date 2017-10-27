//
//  CardCollection.swift
//  Swift Euchre
//
//  Created by Chris Matlak on 12/12/15.
//  Copyright © 2015 Euchre US!. All rights reserved.
//

import Foundation

protocol CardCollection : RangeReplaceableCollection, CustomStringConvertible {
	var collective : [Card] { get set }
}

extension CardCollection  {
	var startIndex : Int { return collective.startIndex }
	var endIndex : Int { return collective.endIndex }
	
	subscript(position : Int) -> Card {
		get {
			return collective[position]
			
		}
		set(newElement) {
			collective[position] = newElement
		}
	}
	
	mutating func replaceRange<C : Collection>(_ subRange: Range<Int>, with newElements: C) where C.Iterator.Element == Card {
		collective.replaceSubrange(subRange, with: newElements)
	}
	
	mutating func shuffleInPlace() {
		collective.shuffleInPlace()
	}
	
	mutating func sortInPlace(_ sortFun: (Card, Card) -> Bool?=DisplaySorted) {
		collective.sort(by: {sortFun($0,$1)!})
	}
	
	mutating func sortBySuit() {
		sortInPlace(SuitSorted)
	}
	mutating func sortByRank() {
		sortInPlace(RankSorted)
	}
	mutating func sortForDisplay() {
		sortInPlace(DisplaySorted)
	}
	
	// for some reason, it complains about card being a let variable if I use
	// for card in collective { card.makeTrump(trumpSuit) }
	mutating func convertToTrump(_ trumpSuit: Suit) {
		for i in 0..<collective.count {
			collective[i].makeTrump(trumpSuit)
		}
	}
}



extension Collection {
	/// Return a copy of `self` with its elements shuffled
	func shuffle() -> [Iterator.Element] {
		var list = Array(self)
		list.shuffleInPlace()
		return list
	}
}

extension MutableCollection where Index == Int {
	/// Shuffle the elements of `self` in-place.
	mutating func shuffleInPlace() {
		// empty and single-element collections don't shuffle
		if count < 2 { return }
		let cardCount = self.endIndex - self.startIndex
		for i in self.startIndex ..< self.endIndex {
			let j = Int(arc4random_uniform(UInt32(cardCount - i))) + i
			guard i != j else { continue }
			self.swapAt(i, j)
		}
	}
}
