//
//  ImageHandler.swift
//  LuncherNetPlus
//
//  Created by Jaylin Phipps on 6/22/18.
//  Copyright © 2018 Jaylin Phipps. All rights reserved.
//

import Foundation
import UIKit

let imageCash = NSCache<NSString, UIImage>()

var urlString: String?

extension UIImageView {
    
    func downloadedFrom(urlString: String){
        let url = URL(string: urlString)!
        
        image = nil
        
        if let imageFromCash = imageCash.object(forKey: urlString as NSString) as? UIImage {
            self.image = imageFromCash
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil{
                print(error)
                return
        }
            DispatchQueue.main.async {
                let imageToCash = UIImage(data: data!)
                imageCash.setObject(imageToCash!, forKey: urlString as NSString)
                self.image = imageToCash
            }
        }).resume()
        
    }
    
//    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleToFill) {
//        contentMode = mode
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard
//                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
//                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
//                let data = data, error == nil,
//                let image = UIImage(data: data)
//                else { return }
//            DispatchQueue.main.async() {
//                let imageToCash = image
//
//                imageCash.setObject(imageToCash, forKey: url)
//
//                self.image = imageToCash
//
////                self.image = image
//            }
//            }.resume()
//    }
}
