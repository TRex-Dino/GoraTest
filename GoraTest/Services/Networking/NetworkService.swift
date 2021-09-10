//
//  NetworkService.swift
//  GoraTest
//
//  Created by Dmitry on 10.09.2021.
//

import Foundation

class NetworkService {
    
    static let shared = NetworkService()
    private let url = "https://jsonplaceholder.typicode.com"
    private init() {}
    
    
    func fetchUsersData(complition: @escaping (Result<[User], Error>) -> Void) {
        let usersURL = url + "/users"
        
        guard let url = URL(string: usersURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "no description")
                return
            }
            
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                complition(.success(users))
            } catch {
                complition(.failure(error))
            }
        }.resume()
    }
    
    func fetchUserPhotos(photoId: Int, complition: @escaping (Result<[Photo], Error>) -> Void) {
        
        let usersURL = url + "/photos?" + "\(photoId)"
        
        guard let url = URL(string: usersURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            guard let data = data else {
                print(error?.localizedDescription ?? "no description")
                return
            }
            
            do {
                let photos = try JSONDecoder().decode([Photo].self, from: data)
                complition(.success(photos))
            } catch {
                complition(.failure(error))
            }
        }.resume()
    }
}
