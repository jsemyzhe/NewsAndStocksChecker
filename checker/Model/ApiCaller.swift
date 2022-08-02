//
//  ApiCaller.swift
//  checker
//
//  Created by Julia Semyzhenko on 7/18/22.
//

import Foundation


final class ApiCaller {
    static let shared = ApiCaller()
    
    struct Constants {
        static let url = URL(string: "https://phisix-api3.appspot.com/stocks.json")
    }
    private init() {}
    
    public func getStocksData(completion: @escaping (Result<[String], Error>) -> Void) {
        guard let url = Constants.url else { return  }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(ApiResponse.self, from: data)
                    print(result)
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
}

// Model
struct ApiResponse: Codable {
    let stock: [Stock]
    
    enum CodingKeys: String, CodingKey {
        case stock
    }
}

struct Stock: Codable {
    let name: String //
    let price: Price
    let percentChange: Double //
    let volume: Int //
    let symbol: String
    
    enum CodingKeys: String, CodingKey {
        case name, price
        case percentChange = "percent_change"
        case volume, symbol
    }
}

struct Price: Codable {
    let currency: Currency
    let amount: Double
}

enum Currency: String, Codable {
    case php = "PHP"
}

