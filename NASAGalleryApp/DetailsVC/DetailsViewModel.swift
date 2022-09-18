//
//  DetailsViewModel.swift
//  NASAGalleryApp
//
//  Created by Rahul Sharma on 18/09/22.
//

import Foundation
class DetailsViewModel{
    let items: [NASAItem]
    var selectedIndex: Int = 0
    init(items: [NASAItem]){
        self.items = items
    }
    
}
