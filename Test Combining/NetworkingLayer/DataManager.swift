//
//  DataManager.swift
//  Test Combining
//
//  Created by Salah  on 04/01/2021.
//

import Foundation
import Combine
 
enum ConnectionRequestHTTPMethod : Int {
    case get
    case post
    case delete
    case put
}

class DataManager{

    
    var isCompleteURL: Bool = false
    // show loading view when executing the reques
    //private(set) var isShowLoading: Bool = false
    // Request http Method
    private var requestMethod = ConnectionRequestHTTPMethod.get
    // Request URL as string
    private var requestURL: String = ""
    // Request to be passed to the session
    private(set) var request: URLRequest?
    // Parameters of the request
    private var parameters : [String: Any]? = [String: Any]()

        
    
    init(requestURL: String, requestMethod: ConnectionRequestHTTPMethod, parameters: [String: Any]?/*, isShowLoading: Bool*/) {
        self.requestURL = requestURL
        self.requestMethod = requestMethod
        self.parameters = parameters
        //self.isShowLoading = isShowLoading
        isCompleteURL = false
    }


    
    func begin(){
        setUp()
    }
    
    
    private func setUp() {
        request = URLRequest(url: setUpURL())
        if requestMethod == .get {
            request?.httpMethod = "GET"
            setUpHeader()
        }
        else if requestMethod == .post {
            request?.httpMethod = "POST"
            setUpHeader()
            setUpBody()
            }
        else if requestMethod == .delete {
            request?.httpMethod = "DELETE"
            setUpHeader()
            setUpBody()
        }
        else if requestMethod == .put {
            request?.httpMethod = "PUT"
            setUpHeader()
            setUpBody()
        }

    }

    private func setUpURL() -> URL {
        var urlString: String = ""
        // If the request URL is complete URL then we don't need to appened the service url from the configurations manager
        if isCompleteURL {
            urlString = requestURL
        }
        else {
            urlString = "Base url\(requestURL)"
        }
        
        // if the request method is get then we need to appened the parameters into the url itself
        if requestMethod == .get {
            
            if parameters == nil {
                parameters = [String: String]()
            }
            
        }
        return URL(string: urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
    }

    func setUpHeader(){
        request?.addValue("headers", forHTTPHeaderField: "Authorization")
    }
    
    func setUpBody(){
        let bodyData: Data? = try? JSONSerialization.data(withJSONObject: parameters!, options: [])
        request?.httpBody = bodyData
    }


    
    func startRequest<T: Decodable>(type: T) -> AnyPublisher<T, Error> {
        setUp()
        return URLSession.shared.dataTaskPublisher(for: request!)
                .map(\.data)
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        }
    
    
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
