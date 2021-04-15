//
//
//
//  Created by Louis Faria-Softly on 09/04/2021.

import Foundation


struct RecommendModel: Decodable {
    let success: Bool
    let data: [RecommendData]
}

struct ArtistModel: Decodable {
    let success: Bool
    let data: [ArtistData]
}

struct RecommendData: Decodable {
    
    let child: ChildObject
    
    enum CodingKeys: String, CodingKey {
        
        case child = "recording_details"
        
    }
    
    class ChildObject : Codable {
        let child1 : String
        
        
        enum CodingKeys: String, CodingKey {
            
            case child1 = "cover_img_url"
        }
    }
}

struct ArtistData: Decodable {
    
    let name : String
    let followers : Int
    let cover_img_url : String
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name"
        case followers = "followers"
        case cover_img_url = "cover_img_url"
        
    }
    
    
}

