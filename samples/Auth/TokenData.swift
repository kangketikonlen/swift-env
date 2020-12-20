//
//  TokenData.swift
//  samples
//
//  Created by Gilang Pratama Priadi on 11/12/20.
//

import SwiftUI

struct userData: Codable {
    var users_login: String
    var users_pass: String
}

struct Token: Codable {
    var accessToken: String
    var refreshToken: String
}

class fetchAPI {
    func getTokens(username: String, password: String, completion: @escaping ([Token]) -> ()) {
        guard let url = URL(string: "http://localhost:8080/api/auth") else { return }
        
        let newUsersData = userData(users_login: username, users_pass: password)
        let jsonUsers = try! JSONEncoder().encode(newUsersData)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonUsers
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error took place \(error)")
                return
            }
            let tokens = try! JSONDecoder().decode([Token].self, from: data!)
            DispatchQueue.main.async {
                completion(tokens)
            }
        }
        .resume()
    }
}
