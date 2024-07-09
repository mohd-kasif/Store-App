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
    case invalidResponse(description:String="")
    
    var description:String{
        switch self{
        case .invalidUrl:
            return "invalid url"
        case  .requestFailed(_):
            return ""
        case .failedSerialization:
            return "failed serialization"
        case .invalidResponse(_):
            return ""
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
    
    func request<T:Codable>(url:URL, type:T.Type, httpMethod:HttpMethod = .Get, httpBody:Data?=nil, completion:@escaping(APIError?, T?)->Void){
//        guard let url=URL(string: url) else{
//           return completion(APIError.invalidUrl, nil)
//           
//        }
        var request=URLRequest(url: url)
        request.httpMethod=httpMethod.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody=httpBody
        let dataTask=self.session?.dataTask(with: request){data, resposne, error in
            DispatchQueue.main.async {
                if let error=error{
                    completion(APIError.requestFailed(description: error.localizedDescription),nil)
                    return
                }
                guard let response=resposne as? HTTPURLResponse else {
                    return completion(APIError.requestFailed(description: "invalid response"), nil)
                }
                guard let data=data else {
                    return completion(APIError.requestFailed(description: "data is nil"), nil)
                }
                if (200...299).contains(response.statusCode){
                    do{
                        let decoder=JSONDecoder()
                        let decodedObject=try decoder.decode(type, from: data)
                        completion(nil, decodedObject)
                    } catch let error{
                        print(error,"decoding error")
                        completion(APIError.failedSerialization, nil)
                    }
                } else {
                    completion(APIError.invalidResponse(description: "Invalid response code \(response.statusCode)"), nil)
                }
                
            }
        }
        dataTask?.resume()
    }
    
    
    func encode<T:Codable>(model:T)->Data?{
        let data=try? JSONEncoder().encode(model)
        return data
    }
}

extension NetworkLayer{
    func deleteProduct(id: Int) async throws-> Bool{
        var request=URLRequest(url: URL.deleteProduct(id))
        request.httpMethod="DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let (data, response)=try await URLSession.shared.data(for: request)
        guard let response=response as? HTTPURLResponse, response.statusCode==200 else {
            throw APIError.invalidResponse(description: "invalid status code")
        }
        let isDeleted=try JSONDecoder().decode(Bool.self, from: data)
        return isDeleted
    }
}
