//
//
//  Created by Louis Faria-Softly on 09/04/2021.
//
import Foundation

class ArtistViewModel : NSObject {
    
    private var apiService : APIService!
    
    private(set) var empData2 : ArtistModel! {
        didSet {
            self.bindProfileViewModelToController()
        }
    }
    
    var bindProfileViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService =  APIService()
        callFuncToGetEmpData()
    }
    
    func callFuncToGetEmpData() {
        
        
        self.apiService.artistData { [weak self] (empData2) in
            self?.empData2 = empData2
        }
    }
}
