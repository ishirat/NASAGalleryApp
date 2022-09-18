//
//  Connection.swift
//  NASAGalleryApp
//
//  Created by Rahul Sharma on 18/09/22.
//

import Foundation
class Connection{
    
    func loadJson(filename fileName: String) -> Any? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                return object
            } catch {
                print("Error!! Unable to parse  \(fileName).json")
            }
        }
        return nil
        
    }
}
