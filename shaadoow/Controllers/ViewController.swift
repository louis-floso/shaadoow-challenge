//
//
//
//  Created by Louis Faria-Softly on 09/04/2021.

import UIKit

class ViewController: UIViewController{
    
    
    
    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionView2: UICollectionView!
    
    
    
    private var recommendViewModel : RecommendViewModel!
    private var artistViewModel : ArtistViewModel!
    
    private var recommendDataSource : RecommendDataSource<RecommendCell,RecommendData>!
    
    private var artistDataSource : ArtistDataSource<ArtistCell,ArtistData>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let subView = UIView()
        
        //Add your required view as subview of uicollectionview backgroundView view like as
        collectionView.backgroundView = UIView()
        collectionView.backgroundView?.addSubview(subView)
        
        
        callToViewModelForUIUpdate()
    }
    
    
    override func viewDidLayoutSubviews() {
        let per:CGFloat = 100 //percentage of required view to move on while moving collection view
        let offset = (-(per/100)) * (20)
        let value =  -collectionView.contentOffset.y
        
        print(offset)
        let rect = subView.frame
        self.subView.frame = CGRect(x: rect.origin.x, y: value, width: rect.size.width, height: rect.size.height)
        print(self.subView.frame)
    }
    func callToViewModelForUIUpdate(){
        
        self.recommendViewModel =  RecommendViewModel()
        self.recommendViewModel.bindRecommendViewModelToController = {
            self.updateDataSource()           
        }
        
        self.artistViewModel =  ArtistViewModel()
        self.artistViewModel.bindProfileViewModelToController = {
            self.updateDataSource2()
        }
    }
    
    
    
    func updateDataSource(){
        
        self.recommendDataSource = RecommendDataSource(cellIdentifier: "RecommendCell", items: self.recommendViewModel.empData.data, configureCell: { [weak self] (cell, evm) in
            
            print(evm.child.child1)
            
            
            
            
            
            let fileUrl = URL(string: "https://shaadoow.net/\(evm.child.child1)")
            func downloadImage(from url: URL) {
                print("Download Started")
                self?.getData(from: url) { data, response, error in
                    guard let data = data, error == nil else { return }
                    print(response?.suggestedFilename as Any )
                    print("Download Finished")
                    DispatchQueue.main.async() { [weak self] in
                        cell.recommendImage?.image = UIImage(data: (data))
                        cell.indicatorView?.isHidden = true
                        
                    }
                }
            }
            if fileUrl != nil{
                downloadImage(from: fileUrl!)
            }
        })
        
        DispatchQueue.main.async {
            self.collectionView.delegate = self
            self.collectionView.dataSource = self.recommendDataSource
            
            self.collectionView.reloadData()
            
        }
        
    }
    
    
    
    func updateDataSource2(){
        print(self.artistViewModel.empData2.data)
        self.artistDataSource = ArtistDataSource(cellIdentifier: "ArtistCell", items: self.artistViewModel.empData2.data, configureCell: { [weak self] (cell, evm) in
        cell.nameLabel.text = String(evm.name )
        cell.followersLabel.text = String(evm.followers)
        let fileUrl = URL(string: "https://shaadoow.net/\(evm.cover_img_url)")
            cell.profileImage.image = nil
            func downloadImage(from url: URL) {
                print("Download Started")
                self?.getData(from: url) { [weak self] data, response, error in
                guard let data = data, error == nil else { return }
               
                print("Download Finished")
                DispatchQueue.main.async() { [weak self] in
                       cell.profileImage?.image = UIImage(data: (data))
                       cell.indicatorView?.isHidden = true
                    }
                }
            }
            if fileUrl != nil{
                downloadImage(from: fileUrl!)
            }
        })
        DispatchQueue.main.async {
            
            self.collectionView2?.delegate = self
            self.collectionView2?.dataSource = self.artistDataSource
            
            self.collectionView2?.reloadData()
        }
        
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    
    
    
    
    
    
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    

    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath as IndexPath)
        
        headerView.frame.size.height = 600
        
        return headerView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let per:CGFloat = 100 //percentage of required view to move on while moving collection view
        
        if scrollView == collectionView{
            let offset = (-(per/100)) * (scrollView.contentOffset.y)
            let value = offset
            print(scrollView.contentOffset.y)
            let rect = subView.frame
            self.subView.frame = CGRect(x: rect.origin.x, y: value, width: rect.size.width, height: rect.size.height)
            
            print(self.subView.frame)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == collectionView2{
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }else{
            return UIEdgeInsets(top: self.subView.frame.height, left: 0, bottom: 0, right: 0)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if collectionView == collectionView2{
            
            let width  = (collectionView.frame.width-10)/4
            let height  = (collectionView.frame.width)/3.125
            return CGSize(width: width, height: height)
            
            
        }else{
            let width  = (collectionView.frame.width-3)/3
            return CGSize(width: width, height: width)
            
            
        }
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segue", sender: nil)
    }
    
    
}


