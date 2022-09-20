//
//  NASAItem.swift
//  NASAGalleryApp
//
//  Created by Rahul Sharma on 18/09/22.
//

import Foundation

class NASAItem{

    let copyright: String
    let date: String
    let explanation: String
    let hdurl: String
    let media_type: String
    let service_version: String
    let title: String
    let url: String
    let dateD: Date


    init(data: [String:String]){
        copyright   = data["copyright"] ?? "N/A"
        date        = data["date"] ?? "N/A"
        explanation = data["explanation"] ?? "N/A"
        hdurl       = data["hdurl"] ?? "N/A"
        media_type  = data["media_type"] ?? "N/A"
        service_version     = data["service_version"] ?? "N/A"
        title       = data["title"] ?? "N/A"
        url         = data["url"] ?? "N/A"
        dateD = date.getDate(withFormat: "yyyy-MM-dd")
        
    }

}

