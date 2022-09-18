//
//  ViewController.swift
//  NASAGalleryApp
//
//  Created by Rahul Sharma on 18/09/22.
//

import UIKit

class ListVC: UIViewController {
    
    var viewModel: ListVCVM?
    var offset: CGFloat = 0
    var selectedCell = UICollectionViewCell()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ListVCVM(connection: Connection())
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.navigationController?.delegate = self
        
        offset = (self.navigationController?.navigationBar.frame.height ?? 66.0) + UIApplication.shared.statusBarFrame.size.height
        createLayout()
        viewModel?.getNASA_GalleryList(complition: {[weak self] status in
            guard let weakSelf = self else { return }
            if status{
                weakSelf.collectionView.reloadData()
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "NewVCSegue") {
            let vc = segue.destination as! DetailsViewController
            if let selecetedCell = selectedCell as? NASAImageCVCell , let items = viewModel?.items{

                vc.viewModel = DetailsViewModel(items: items)
                vc.viewModel?.selectedIndex = selecetedCell.tag
            }
        }
    }
}

extension ListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NASAImageCVCell", for: indexPath) as? NASAImageCVCell{
            cell.imgView.downloadImageFrom(urlString: viewModel?.getImageURLfor(index: indexPath.row) ?? "" , imageMode: .scaleAspectFill)
            cell.tag = indexPath.row
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsPerRow:CGFloat = 3
        let hardCodedPadding:CGFloat = 2
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = itemWidth
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCell = collectionView.cellForItem(at: indexPath)!
        selectedCell.tag = indexPath.row
        performSegue(withIdentifier: "NewVCSegue", sender: nil)
        
    }
    
    func createLayout(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: width , height: width )
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
    }
}

extension ListVC: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        switch operation {
            
        case .push:
            let animator = PresentAnimator()
            animator.originFrame = selectedCell.frame
            animator.offset = offset
            return animator
            
        case .pop:
            let animator = DismissAnimator()
            animator.originFrame = selectedCell.frame
            animator.offset = offset
            return animator
            
        default:return nil
        }
    }
}
