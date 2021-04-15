//
//  
//
//  Created by Louis Faria-Softly on 09/04/2021.


import UIKit

class ArtistCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var followersLabel: UILabel!
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        profileImage?.layer.masksToBounds = true
        
        profileImage?.layer.cornerRadius = 40
        profileImage?.clipsToBounds = true
        
        
    }
    
    
    
}


