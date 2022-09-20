//
//  DetailsViewController.swift
//  NASAGalleryApp
//
//  Created by Rahul Sharma on 18/09/22.
//

import UIKit

class DetailsViewController: UIViewController {
    var viewModel: DetailsViewModel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "DetailsCVCell", bundle: nil), forCellWithReuseIdentifier: "DetailsCVCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewWillLayoutSubviews() {
       super.viewWillLayoutSubviews()
        collectionView.scrollToItem(at: IndexPath(item: viewModel.selectedIndex, section: 0), at: [.centeredVertically,.centeredHorizontally], animated: false)
        
       }
   }
    


extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCVCell", for: indexPath) as? DetailsCVCell{
            
            cell.setDataToCell(viewModel.items[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 10, height: collectionView.frame.height)
        
    }
    
}
