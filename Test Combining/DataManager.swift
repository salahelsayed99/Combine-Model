//
//  DataManager.swift
//  Test Combining
//
//  Created by Salah  on 04/01/2021.
//

import Foundation
import Combine
 

class DataManager{
    
    private let urlString = "https://jsonplaceholder.typicode.com/users"
    
    var publisher:AnyPublisher<[User],Error>{
        let url = URL(string: urlString)!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map({ (($0.data))
                    })
            .decode(type: [User].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
}
