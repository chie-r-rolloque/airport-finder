//
//  Airport.swift
//  AirportFinder
//
//  Created by Ritchie R. Rolloque on 7/18/22.
//

import Foundation

struct Airport: Decodable, Hashable {
    var airportCode: String
    var internationalAirport: Bool
    var domesticAirport: Bool
    var regionalAirport: Bool
    var onlineIndicator: Bool
    var airportName: String
    var country: Country
    var region: Region
}
