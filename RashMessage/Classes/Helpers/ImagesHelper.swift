
//
//  MessageTableViewCell.swift
//  Pods-RashMessage_Example
//
//  Created by Mahmoud RACHID on 10/09/18.
//

import Foundation
import UIKit

public struct ImagesHelper {
    
    static func loadImage(name: String) -> UIImage? {
        let podBundle = Bundle(for: MessageViewController.self)
        if let url = podBundle.url(forResource: "RashMessageAssets", withExtension: "bundle") {
            let bundle = Bundle(url: url)
            if let path = bundle?.path(forResource: name, ofType: "png") {
                return UIImage.init(contentsOfFile: path)
            }
            return nil
        }
        return nil
    }
}
