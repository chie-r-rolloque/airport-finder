//
//  AirportViewModel.swift
//  AirportFinder
//
//  Created by Ritchie R. Rolloque on 7/18/22.
//

import Foundation
import Combine

class AirportViewModel: ObservableObject {
    
    @Published var airports: [Airport]?
    @Published var isLoading = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        GetAirports()
    }
    
    func GetAirports() {
        isLoading = true
        
        GetAirportsRouter.shared.getAirports(type: [Airport].self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case . failure(let err):
                    print("Error is \(err.localizedDescription)")
                case .finished:
                    print("Finished")
                }
            }, receiveValue: { [weak self] airportData in
                self?.airports = airportData
                self?.isLoading = false
            })
            .store(in: &cancellables)
    }
}
