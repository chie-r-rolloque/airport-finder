//
//  GetAirports.swift
//  AirportFinder
//
//  Created by Ritchie R. Rolloque on 7/18/22.
//

import Foundation
import Combine

import Alamofire

enum AirportURLService: URLRequestConvertible {
    
    case getAirports
    
    var basePath: String {
        return "https://api.qantas.com/flight/refData/"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var route: String {
        return "airport/"
    }
    
    func asURLRequest() -> URLRequest {
        let baseURL = URL(string: self.basePath)!
        let routeURL = baseURL.appendingPathComponent(self.route)
        var requestURL = URLRequest(url: routeURL)
        
        requestURL.httpMethod = self.method.rawValue
        return requestURL
    }
}

class GetAirportsRouter {
    static let shared = GetAirportsRouter();
    
    private var cancellables = Set<AnyCancellable>();
    private init() {}
    
    func getAirports<T: Decodable>(type: T.Type) -> Future<T, Error> {
        return Future<T, Error> { [weak self] promise in
            let urlRequest = AirportURLService.getAirports
            
            URLSession.shared.dataTaskPublisher(for: urlRequest.asURLRequest())
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        throw NetworkError.responseError
                    }
                    return data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { (completion) in
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingError as DecodingError:
                            promise(.failure(decodingError))
                        case let apiError as NetworkError:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(NetworkError.unknown))
                        }
                    }
                }, receiveValue: { promise(.success($0))})
                .store(in: &self!.cancellables)
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case responseError
    case unknown
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "Invalid URL")
        case .responseError:
            return NSLocalizedString("Unexpected status code", comment: "Invalid response")
        case .unknown:
            return NSLocalizedString("Unknown error", comment: "Unknown error")
        }
    }
}
