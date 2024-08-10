//
//  NetworkManager.swift
//  Appmini
//
//  Created by Woo on 8/9/24.
//

import Foundation
import RxSwift
import RxCocoa

enum netError : Error {
    case invalidURL
    case unknownResponse
    case statusError
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init () { }
    
    func callRequest(item : String) -> Observable<Music>{
        let url = "https://itunes.apple.com/search?term=\(item)&country=KR"
        print("\(url)")
        let result = Observable<Music>.create { observer in
            guard let url = URL(string: url) else {
                print("netError.invalidURL")
                observer.onError(netError.invalidURL)
                return Disposables.create()
            }
            URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil {
                    print("netError.unknownRespons")
                    observer.onError(netError.unknownResponse)
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
                    print("netError.statusError")
                    observer.onError(netError.statusError)
                    return
                }
                if let data = data, let appData = try? JSONDecoder().decode(Music.self, from: data) {
//                    print("appData \(appData)")
                    observer.onNext(appData)
                    observer.onCompleted()
                }else {
                    print("응답은 왔으나 디코딩 실패")
                    observer.onError(netError.unknownResponse)
                    return
                }
            }.resume()
            
            return Disposables.create()
        }
//            .debug("🎧음악조회🎧")
        
        return result
                
        }
    }


