//
//
//
//  Created by Louis Faria-Softly on 09/04/2021.
import Foundation


class APIService :  NSObject {
    
    private let artistURL = URL(string: "https://dev.shaadoow.com/api/artists/auth-less/list?page=1&limit=5")!
    
    func artistData(completion : @escaping (ArtistModel) -> ()){
        
        URLSession.shared.dataTask(with: artistURL) { [weak self]  (data, urlResponse, error) in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                
                let empData2 = try! jsonDecoder.decode(ArtistModel.self, from: data)
                print(empData2)
                completion(empData2)
            }
            
        }.resume()
    }
    
    private let sourcesURL = URL(string: "https://dev.shaadoow.com/api/posts/recommended_for_you?page=1&limit=18")!
    
    func recommendData(completion : @escaping (RecommendModel) -> ()){
        
        URLSession.shared.dataTask(with: sourcesURL) { [weak self] (data, urlResponse, error) in
            if let data = data {
                
                let jsonDecoder = JSONDecoder()
                
                let empData = try! jsonDecoder.decode(RecommendModel.self, from: data)
                
                completion(empData)
            }
            
        }.resume()
    }
    
    
    
}
