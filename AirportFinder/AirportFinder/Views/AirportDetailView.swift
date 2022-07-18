//
//  AirportDetailView.swift
//  AirportFinder
//
//  Created by Ritchie R. Rolloque on 7/18/22.
//

import SwiftUI

struct AirportDetailView: View {
    @ObservedObject var viewModel = AirportDetailViewModel()
        
    var airport: Airport
    
    init(model: Airport) {
        airport = model
    }
    
    var body: some View {
        ZStack {
            VStack {
                Text("Airport Details")
                    .font(.title)
                AirportCellView(airport: airport)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(10)
                HStack {
                    Text("Code: ")
                    Text(airport.airportCode)
                }
                HStack {
                    Text("Online: ")
                    Text(String(airport.onlineIndicator))
                }
                HStack {
                    Text("International: ")
                    Text(String(airport.internationalAirport))
                }
                HStack {
                    Text("Domestic: ")
                    Text(String(airport.domesticAirport))
                }
                HStack {
                    Text("Region: ")
                    Text(String(airport.regionalAirport))
                }
                Spacer()
            }
            Spacer()
        }
    }
}
