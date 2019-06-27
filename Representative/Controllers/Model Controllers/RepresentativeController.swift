//
//  RepresentativeController.swift
//  Representative
//
//  Created by Darin Marcus Armstrong on 6/27/19.
//  Copyright © 2019 Darin Marcus Armstrong. All rights reserved.
//

import Foundation

class RepresentativeController {
    
    static let shared = RepresentativeController()
    
    static let baseURL = URL(string: "https://whoismyrepresentative.com/getall_reps_bystate.php")
    
    static func searchRepresentatives(forState state: String, completion: @escaping ([Representative]) -> Void) {
        guard let url = baseURL else {completion([]); return}
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {completion([]); return}
        let searchQueryItems = URLQueryItem(name: "state", value: state)
        let jsonQueryItem = URLQueryItem(name: "output", value: "json")
        components.queryItems = [searchQueryItems, jsonQueryItem]
        
        guard let finalURL = components.url else {completion([]); return}
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("There was an error: \(error.localizedDescription)")
                completion([]); return
            }
            
            guard let data = data else {completion([]); return}
            
            guard let newData = String(data: data, encoding: .ascii)?.data(using: .utf8) else {completion([]); return}
            
            do {
                let decoder = JSONDecoder()
                let topLevelJSON = try decoder.decode(TopLevelJSON.self, from: newData)
                completion(topLevelJSON.results)
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
                completion([])
                return
            }
        }.resume()
        
    }
    
}
