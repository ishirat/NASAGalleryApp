//
//  ListVCVM.swift
//  NASAGalleryApp
//
//  Created by Rahul Sharma on 18/09/22.
//

import Foundation
class ListVCVM{
    
    private let fileName = "data"
    
    var items: [NASAItem]?
    
    var connection: Connection
    
    init (connection: Connection){
        self.connection = connection
    }

    func getNASA_GalleryList(complition: @escaping(Bool) -> Void){
        
        guard let objects = connection.loadJson(filename: fileName) as? [[String: String]] else{
            complition(false)
            return
        }
        items = objects.map{ NASAItem(data: $0) }.sorted(by: { $0.dateD > $1.dateD })
        
        complition(true)
    }
    
    
    func getItemOn(index: Int) -> NASAItem?{
        if let item = items?[index]{
            return item
        }
        return nil
    }
    
    func getImageURLfor(index: Int) -> String{
        if let url = getItemOn(index: index)?.url{
            return url
        }
        return ""
    }
}
