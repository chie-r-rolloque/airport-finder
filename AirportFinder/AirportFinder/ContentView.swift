//
//  ContentView.swift
//  AirportFinder
//
//  Created by Ritchie R. Rolloque on 7/18/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = AirportViewModel()
        
        var body: some View {
            NavigationView {
                ZStack {
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.airports ?? [Airport](), id: \.self) { value in
                                NavigationLink(destination: AirportDetailView(model: value)) {
                                                                AirportCellView(airport: value)
                                                                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                                                            }
                            }
                        }
                    }
                }
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
