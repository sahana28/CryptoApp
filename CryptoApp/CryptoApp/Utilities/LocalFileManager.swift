//
//  LocalFileManager.swift
//  CryptoApp
//
//  Created by Sahana  Rao on 18/08/24.
//

import Foundation
import SwiftUI

class LocalFileManager {
    static var instance = LocalFileManager()
    private init() { }
    
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        guard
            let data = image.pngData(),
            let url = getURLForImage(imageName: imageName, folderName: folderName)
        else  {
            return
        }
        
        do {
            try data.write(to: url)
        }
        catch let error {
            print("Error saving imahe :\(error)")
        }
        
    }
    
    func  getImage(imageName: String, foldderName : String)  -> UIImage? {
        
        guard let url = getURLForImage(imageName: imageName, folderName: foldderName),
        FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        return UIImage(contentsOfFile: url.path)
        
    }
    
    
    private func createFolderIfNedded(folderName : String)  {
        guard let url = getURLForFolder(name: folderName) else { return }
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            }
            catch let error {
                print("Error creating directoru : \(error)")
            }
        }
    }
    
    
    
    private func getURLForFolder(name: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(name)
    }
    
    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let url = getURLForFolder(name: folderName) else  { return nil}
        return  url.appendingPathComponent(imageName + ".png")
    }
    
    
    
    
    
    
}

