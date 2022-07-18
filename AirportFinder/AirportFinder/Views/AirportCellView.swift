//
//  AirportCellView.swift
//  AirportFinder
//
//  Created by Ritchie R. Rolloque on 7/18/22.
//

import SwiftUI

struct AirportCellView: View {
    let airport: Airport
        
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.blue)
            VStack {
                HStack {
                    Text(airport.airportName)
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                        .padding(5)
                    Spacer()
                }
                HStack {
                    Text(airport.country.countryName)
                        .foregroundColor(Color.white)
                        .padding(5)
                    Spacer()
                    Text(airport.region.regionName)
                        .foregroundColor(Color.white)
                        .padding(5)
                }
            }
            
        }
    }
}
