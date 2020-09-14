//
//  NetworkManager.swift
//  shopware6shop
//
//  Created by Marcel Romagnuolo on 14.09.20.
//  Copyright © 2020 pickware. All rights reserved.
//

import Alamofire
import Foundation

struct NetworkService {

    static let loginURL = "https://next.pickware.de/api/oauth/token"
    static let getOrderURL = "https://next.pickware.de/api/v3/search/order"
    
    static func login() {
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            AF.request(loginURL,
                       method: .post,
                       parameters: LoginRequest.testuser,
                       encoder: JSONParameterEncoder.default).responseDecodable(of:LoginResponse.self) { response in
                        
                    if let value = response.value {
                        print(response)
                    }
            }
        }
    }
    
    /*
    static func getRequest(tag:Int, completion: @escaping ([Petition]) -> Void) {
        
        let urlString: String

        if tag == 0 {
            // urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            // urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        // see for different async priorities https://www.hackingwithswift.com/read/9/3/gcd-101-async
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    let petitions = NetworkService.parse(json: data)
                    
                    DispatchQueue.main.async {
                        completion(petitions)
                    }
                }
            }
        }
    }
    
    static private func parse(json: Data) -> [Petition] {
        let decoder = JSONDecoder()

        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            return jsonPetitions.results
        } else {
            return [Petition]()
        }
    }
 */
}
