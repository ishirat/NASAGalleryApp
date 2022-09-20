//
//  extension.swift
//  NASAGalleryApp
//
//  Created by Rahul Sharma on 18/09/22.
//

import UIKit

extension String{
    func getDate(withFormat: String ) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = withFormat
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        return dateFormatter.date(from: self) ?? Date()
    }
}

