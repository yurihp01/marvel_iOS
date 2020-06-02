//
//  MarvilAPI.swift
//  desafio-ios-yuri-pedroso
//
//  Created by Yuri on 01/06/20.
//  Copyright © 2020 DevVenture. All rights reserved.
//

import Foundation


class MarvelAPI {
    private static var session = URLSession(configuration: configuration)
    
    private static let publicKey = "9a52b6623a6daf0fdecf96f87210188f"
    private static let privateKey = "7ab60909f2f5558ddb9f1e68da5312d2fcf03fa9"
    
    private static let parameters: [String:String] = {
        let timestamp = "\(Date().timeIntervalSince1970)"
        let hash = (timestamp + privateKey + publicKey).md5
        
        let parameters =
        [
            "ts":"\(timestamp)",
            "apikey":"\(publicKey)",
            "hash":"\(hash)"
        ]
        
        return parameters
    }()
    
    private static let configuration: URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = true
        configuration.timeoutIntervalForRequest = 30
        configuration.httpAdditionalHeaders = ["Content-Type":"application/json"]
        return configuration
    }()
    
    
    private init(){}
    
    private static func getComponent(offset: Int?, _ marvelPath: MarvelPath) -> URL? {
        var charParams = parameters
        
        if let offset = offset {
            charParams["offset"] = "\(offset)"
            charParams["orderBy"] = "name"
        }
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "gateway.marvel.com"
        
        switch marvelPath {
        case .characters:
            components.path = "/v1/public/characters"
        case .comic(let characterId):
            components.path = "/v1/public/characters/\(characterId)/comics"
        }
        
        components.queryItems = charParams.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
    
        return components.url
    }
    
    static func getChars(offset: Int, onComplete: @escaping (Result<[Char], APIError>, Int?) -> Void) {
        
        guard let url = getComponent(offset: offset, .characters) else {
            return onComplete(.failure(.badURL), nil)
        }
        
        session.dataTask(with: url) {
            (data, response, error) in
            
            guard error == nil else {
                return onComplete(.failure(.responseMessage(error!.localizedDescription)), nil)
            }
            
            guard let response = response as? HTTPURLResponse else {
                onComplete(.failure(.badResponse), nil)
                return
            }
            
            if response.statusCode != 200 {
                return onComplete(.failure(.invalidStatusCode(response.statusCode)), nil)
            }
            
            guard let data = data else {
                onComplete(.failure(.noData), nil)
                return
            }
            
            do {
                let total = try JSONDecoder().decode(MarvelResponse<Char>.self, from: data).data.total
                let chars = try JSONDecoder().decode(MarvelResponse<Char>.self, from: data).data.results
                onComplete(.success(chars), total)
            } catch {
                onComplete(.failure(.invalidJson), nil)
            }
        }.resume()
        
    }
    
    static func getComic(charId: Int, onComplete: @escaping (Result<[Comic], APIError>) -> Void) {
        guard let url = getComponent(offset: nil, .comic(characterId: charId)) else {
            return onComplete(.failure(.badURL))
        }
        
        session.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                return onComplete(.failure(.responseMessage(error!.localizedDescription)))
            }
            
            guard let data = data else {
                return onComplete(.failure(.noData))
            }
            
            guard let response = response as? HTTPURLResponse else {
                return onComplete(.failure(.badResponse))
            }
        
            guard response.statusCode == 200 else {
                return onComplete(.failure(.invalidStatusCode(response.statusCode)))
            }
            
            do {
                let comics = try JSONDecoder().decode(MarvelResponse<Comic>.self, from: data).data.results
                guard !comics.isEmpty else {
                    return onComplete(.failure(.isEmpty))
                }
                onComplete(.success(comics))
            } catch {
                onComplete(.failure(.invalidJson))
            }
        }.resume()
    }
}
