//
//  NetworkManager.swift
//  TrafficCameraDemo
//
//  Created by eslam mohamed on 07/07/2022.
//

import UIKit

protocol INetworkManager{
    func fetchDataFromApi<B:Codable>(urlString: String, baseModel: B.Type ,completion: @escaping (Result<B,ErrorMessages>)->Void )
    
    func downloadImg(from urlString: String, completion: @escaping (Result<Data, ErrorMessages>) -> Void)
}

class NetworkManager:INetworkManager{
    
    static let shared = NetworkManager()
    let cache         = NSCache<NSString, UIImage>()
    private init(){}
    
    func fetchDataFromApi<B>(urlString: String, baseModel: B.Type, completion: @escaping (Result<B, ErrorMessages>) -> Void) where B : Decodable, B : Encodable {
        let endpoint = urlString
        guard let url = URL(string: endpoint) else{
            completion(.failure(.invalidUrl))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure(.noInternet))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .useDefaultKeys
                let resultData = try decoder.decode(B.self, from: data)
                completion(.success(resultData))
            }catch{
                print(error.localizedDescription)
                completion(.failure(.invalidDataAfterDecoding))
            }
        }
        task.resume()
    }
    
    
    func downloadImg(from urlString: String, completion: @escaping (Result<Data, ErrorMessages>) -> Void){
        guard let url = URL(string: urlString) else{
            return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {return}
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else{return}
            guard let data     = data   else{return}
            completion(.success(data))
        }
        task.resume()
        
    }
    
    
    
}
