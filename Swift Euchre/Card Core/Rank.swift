//
//  rank.swift
//  Swift Euchre
//
//  Created by Chris Matlak on 12/7/15.
//  Copyright © 2015 Euchre US!. All rights reserved.
//

import Foundation


public enum Rank: Int {
	case loAce = 0
	case deuce, two, three, four, five, six, seven, eight, nine, ten
	case jack, queen, king, hiAce, leftBower, rightBower
	case invalid = -1
	case blank = -2
	
	func dispName() -> String {
		switch self {
		case .loAce:
			return "Ace"
		case .deuce:
			return "Deuce"
		case .two:
			return "Two"
		case .three:
			return "Three"
		case .four:
			return "Four"
		case .five:
			return "Five"
		case .six:
			return "Six"
		case .seven:
			return "Seven"
		case .eight:
			return "Eight"
		case .nine:
			return "Nine"
		case .ten:
			return "Ten"
		case .jack:
			return "Jack"
		case .queen:
			return "Queen"
		case .king:
			return "King"
		case .hiAce:
			return "Ace"
		case .leftBower:
			return "Left Bower"
		case .rightBower:
			return "Right Bower"
		default:
			return ""
		}
	}
	
	// Leaving in trumpAware in case it's useful to have that hard-coded here.
	func shortName(trumpAware: Bool = false) -> Character {
		if trumpAware && (self == .leftBower || self  == .rightBower) {
			return "J"
		}
		switch self {
		case .deuce:
			return "2"
		case .loAce:
			return "A"
		case .ten:
			return "⒑" // need this or some other non-ASCII representation of 10 to prevent runtime errors
		case .jack:
			return "J"
		case .queen:
			return "Q"
		case .king:
			return "K"
		case .hiAce:
			return "A"
		case .leftBower:
			return "◀"
		case .rightBower:
			return "▶"
		default:
			return Character(String(self.rawValue))
		}
	}
	
	func isValue(_ value: Rank) -> Bool {
		return self == value
	}
	func isNotValue(_ value: Rank) -> Bool {
		return !isValue(value)
	}
	
	func isAce() -> Bool {
		return isValue(.loAce) || isValue(.hiAce)
	}
	
	func is2() -> Bool {
		return isValue(.deuce) || isValue(.two)
	}
	
	func isBower() -> Bool {
		return isValue(.leftBower) || isValue(.rightBower)
	}
	
	func isValid() -> Bool {
		return !invalidRank()
	}
	func invalidRank() -> Bool {
		return isValue(.invalid) || isValue(.blank)
	}
}

public func <(left: Rank, right: Rank) -> Bool {
	return left.rawValue < right.rawValue
}
