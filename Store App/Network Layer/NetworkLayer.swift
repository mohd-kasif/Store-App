//
//  NetworkLayer.swift
//  Store App
//
//  Created by Mohd Kashif on 26/06/24.
//

import Foundation

enum APIError:Error{
    case invalidUrl
    case requestFailed(description:String="")
    case failedSerialization
    
    var description:String{
        switch self{
        case .invalidUrl:
            return "invalid url"
        case  let .requestFailed(description):
            return ""
        case .failedSerialization:
            return "failed serialization"
        }
    }
}

enum HttpMethod:String{
    case Post="POST"
    case Get="GET"
    case delete="DELETE"
    case update="UPDATE"
}
class NetworkLayer{
    private var session:URLSession?
    var sessionCofiguration:URLSessionConfiguration
    init() {
        sessionCofiguration=URLSessionConfiguration.default
        sessionCofiguration.timeoutIntervalForRequest=90
        sessionCofiguration.timeoutIntervalForResource=90
        sessionCofiguration.urlCache=nil
        self.session=URLSession(configuration: sessionCofiguration)
    }
    
     func request<T:Codable>(url:URL, type:T.Type, httpMethod:HttpMethod = .Get, completion:@escaping(APIError?, T?)->Void){
//        guard let url=URL(string: url) else{
//           return completion(APIError.invalidUrl, nil)
//           
//        }
        var request=URLRequest(url: url)
        request.httpMethod=httpMethod.rawValue
        let dataTask=self.session?.dataTask(with: request){data, resposne, error in
            DispatchQueue.main.async {
                if let error=error{
                    completion(APIError.requestFailed(description: error.localizedDescription),nil)
                    return
                }
                guard let response=resposne as? HTTPURLResponse else {
                    return completion(APIError.requestFailed(description: "invalid response code"), nil)
                }
                guard let data=data else {
                    return completion(APIError.requestFailed(description: "data is nnil"), nil)
                }
                if response.statusCode==200{
                    do{
                        let decoder=JSONDecoder()
                        let decodedObject=try decoder.decode(type, from: data)
                        completion(nil, decodedObject)
                    } catch let error{
                        print(error,"serialization error")
                        completion(APIError.failedSerialization, nil)
                    }
                }
            }
        }
        dataTask?.resume()
    }
}
