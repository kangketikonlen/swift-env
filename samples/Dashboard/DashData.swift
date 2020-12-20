//
//  AdminData.swift
//  samples
//
//  Created by Gilang Pratama Priadi on 11/12/20.
//
import SwiftUI

struct LevelData: Codable {
    var data: [listLevel]
    var sessions: sessionData
}

struct listLevel: Codable {
    var levels_id: Int
    var levels_name: String
    var levels_desc: String
    var created_date: String
    var updated_date: String
    var deleted: Bool
}

struct sessionData: Codable {
    var id: Int
    var level: Int
    var nama: String
    var iat: Int
}

class fetchLevel {
    func getLevel(Authorization: String, completion: @escaping ([sessionData]) -> ()) {
        guard let url = URL(string: "http://localhost:8080/api/levels") else { return }
        
        //let newUsersData = userData(users_login: username, users_pass: password)
        //let jsonUsers = try! JSONEncoder().encode(newUsersData)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer kangketik " + Authorization, forHTTPHeaderField: "Authorization" )
        //request.httpBody = jsonUsers
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error took place \(error)")
                return
            }
            let jsonData = try! JSONDecoder().decode([sessionData].self, from: data!)
            DispatchQueue.main.async {
                completion(jsonData)
            }
        }
        .resume()
    }
}
