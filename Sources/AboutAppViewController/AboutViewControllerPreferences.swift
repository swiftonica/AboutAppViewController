//
//  File.swift
//  
//
//  Created by Jeytery on 25.01.2023.
//

import Foundation
import UIKit

public struct AboutViewControllerPreferences {
    struct AboutButton {
        let url: String
        let title: String
    }
    
    typealias AboutButtons = [AboutButton]

    let appIcon: UIImage
    let appName: String
    let appVersionName: String?
    
    let versionNumber: String
    let build: Int
    
    let copyrightText: String
    let buttons: AboutButtons?
    
    var appNameAttributedString: NSAttributedString {
        let font1 = UIFont.systemFont(ofSize: 40, weight: .medium)
        let font2 = UIFont.systemFont(ofSize: 40, weight: .light)
        
        let attributes1: [NSAttributedString.Key: Any] = [
            .font: font1,
            .foregroundColor: UIColor.label,
        ]
        
        let attributes2: [NSAttributedString.Key: Any] = [
            .font: font2,
            .foregroundColor: UIColor.label,
        ]
        
        let string1 = NSMutableAttributedString(
            string: self.appName,
            attributes: attributes1)
        if let appVersionName = appVersionName {
            let string2 = NSMutableAttributedString(
                string: " " + appVersionName,
                attributes: attributes2)
            string1.append(string2)
        }
        return string1
    }
}
