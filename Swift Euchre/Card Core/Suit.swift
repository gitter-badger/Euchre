//
//  suit.swift
//  Swift Euchre
//
//  Created by Chris Matlak on 12/7/15.
//  Copyright © 2015 Euchre US!. All rights reserved.
//

import Foundation

public enum Suit: Int {
	case joker = 0
	case clubs, diamonds, spades, hearts
	case trump
	
	func dispName() -> String {
		switch self {
		case .joker:
			return "Joker"
		case .clubs:
			return "Clubs"
		case .diamonds:
			return "Diamonds"
		case .spades:
			return "Spades"
		case .hearts:
			return "Hearts"
		case .trump:
			return "Trump"
		}
	}
	
	func shortName() -> Character {
		switch self {
		case .joker:
			return "🃏"
		case .clubs:
			return "♣️"
		case .diamonds:
			return "♦️"
		case .spades:
			return "♠️"
		case .hearts:
			return "♥️"
		case .trump:
			return "🌟"
		}
	}
	
	func oppositeSuit() -> Suit {
		switch self {
		case .clubs:
			return .spades
		case .diamonds:
			return .hearts
		case .spades:
			return .clubs
		case .hearts:
			return .diamonds
		default:
			return self
		}
	}
	
	// These functions also have pass-throughs in the Card class
	
	func isSuit(_ suit: Suit) -> Bool {
		return self == suit
	}
	
	func isTrump() -> Bool {
		return isSuit(.trump)
	}
	func isJoker() -> Bool {
		return isSuit(.joker)
	}
	
	func isRed() -> Bool {
		return isSuit(.diamonds) || isSuit(.hearts)
	}
	func isBlack() -> Bool {
		return isSuit(.clubs) || isSuit(.spades)
	}
	
	func isNotTrump() -> Bool {
		return !isTrump()
	}
	func isPlayable() -> Bool {
		return !isJoker()
	}
	
	func isNormalSuit() -> Bool {
		if !isTrump() && !isJoker() {
			return true
		} else {
			return false
		}
	}
	func isUnusualSuit() -> Bool {
		if isTrump() || isJoker() {
			return true
		} else {
			return false
		}
	}
}

public func <(left: Suit, right: Suit) -> Bool {
	return left.rawValue < right.rawValue
}
