//
//  DetailsCVCell.swift
//  NASAGalleryApp
//
//  Created by Rahul Sharma on 18/09/22.
//

import UIKit

class DetailsCVCell: UICollectionViewCell {

    var item: NASAItem!
    @IBOutlet weak var tableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.register(UINib(nibName: "ImageTVCell", bundle: nil), forCellReuseIdentifier: "ImageTVCell")
        tableView.register(UINib(nibName: "TextTVCell", bundle: nil), forCellReuseIdentifier: "TextTVCell")
        tableView.dataSource = self
        tableView.delegate = self
        // Initialization code
    }

    func setDataToCell(_ item: NASAItem){
        self.item = item
        tableView.reloadData()
    }
    
}

extension DetailsCVCell:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTVCell", for: indexPath) as? ImageTVCell{
                cell.imgView.image = nil
                cell.imgView.downloadImageFrom(urlString: item!.hdurl, imageMode: .scaleAspectFit)
                cell.selectionStyle = .none
                return cell
            }
        }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TextTVCell", for: indexPath) as? TextTVCell{
            
            switch indexPath.row{
            case 1:
                cell.txtLabel.text = item?.title
                cell.txtLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            case 2:  cell.txtLabel.text = "Date: "+item!.date
                cell.txtLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
                
            case 3:  cell.txtLabel.text = item?.explanation
                cell.txtLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            default: cell.txtLabel.text = "Copyright: " + item!.copyright
                cell.txtLabel.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
            }
            cell.txtLabel.numberOfLines = 0
            cell.selectionStyle = .none
           return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


