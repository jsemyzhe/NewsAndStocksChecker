//
//  APICallerNews.swift
//  checker
//
//  Created by Julia Semyzhenko on 7/18/22.
//

import Foundation


final class APICallerNews {
    static let shared = APICallerNews()
    
    struct Constants {
        static let url = URL(
            string: "https://newsapi.org/v2/top-headlines?country=US&apiKey=a9e033a53a744254b22bb0a9848ed805"
        )
    }
    
    private init() {}
    
    public func getNewsData(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = Constants.url else { return  }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APINewsResponse.self, from: data)
                    print(result.articles.count)
                    completion(.success(result.articles))
                    
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
        
        
    }
    
}

struct APINewsResponse: Codable {
    let articles: [Article]
}

struct Article: Codable {
    
    let source: Source
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
}

struct Source: Codable {
    let name: String
}

