//
//  Country.swift
//  AirportFinder
//
//  Created by Ritchie R. Rolloque on 7/18/22.
//

import Foundation

struct Country : Decodable, Hashable {
    var countryCode: String
    var countryName: String
}
