//
//  ImageManager.swift
//  Storm
//
//  Created by Aziz Kızgın on 22.06.2024.
//

import Foundation
import SwiftUI

class ImageManager {
    
    static let shared = ImageManager()
    private init() {}
    
    func convertImageToString(for img: UIImage) -> String? {
        guard let imageData = img.jpegData(compressionQuality: 1) else {
            return nil
        }
        let base64String = imageData.base64EncodedString()
        return base64String
    }

    func convertStringToImage(for imgString: String) -> UIImage? {
        guard let imageData = Data(base64Encoded: imgString) else {
            return nil
        }
        return UIImage(data: imageData)
    }
    
    func convertStringToImageData(for imgString: String, completion: @escaping (Data?) -> Void) {
        DispatchQueue.global().async {
            let imageData = Data(base64Encoded: imgString)
            DispatchQueue.main.async {
                completion(imageData)
            }
        }
    }
    
    func convertStringArrayToImageDataArray(for imgStrings: [String], completion: @escaping ([Data]) -> Void) {
        DispatchQueue.global().async {
            let imageDataArray = imgStrings.compactMap { Data(base64Encoded: $0) }
            DispatchQueue.main.async {
                completion(imageDataArray)
            }
        }
    }
}
