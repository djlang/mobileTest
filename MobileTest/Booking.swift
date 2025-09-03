//
//  Booking.swift
//  MobileTest
//
//  Created by dengjinlang on 2025/9/3.
//

import Foundation

struct Booking: Codable {
    let shipReference: String
    let shipToken: String
    let canIssueTicketChecking: Bool
    let expiryTime: String
    let duration: Int
    let segments: [Segment]
}

struct Segment: Codable {
    let id: Int
    let originAndDestinationPair: OriginAndDestinationPair
}

struct OriginAndDestinationPair: Codable {
    let destination: City
    let destinationCity: String
    let origin: City
    let originCity: String
}

struct City: Codable {
    let code: String
    let displayName: String
    let url: String
}
