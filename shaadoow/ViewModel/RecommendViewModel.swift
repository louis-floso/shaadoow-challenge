//
//
//
//  Created by Louis Faria-Softly on 09/04/2021.

import Foundation

class RecommendViewModel : NSObject {
    
    private var apiService : APIService!
    private(set) var empData : RecommendModel! {
        didSet {
            self.bindRecommendViewModelToController()
        }
    }
    
    
    
    var bindRecommendViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService =  APIService()
        callFuncToGetEmpData()
    }
    
    func callFuncToGetEmpData() {
        self.apiService.recommendData{ [weak self] (empData) in
            self?.empData = empData
        }
        
        
    }
}
