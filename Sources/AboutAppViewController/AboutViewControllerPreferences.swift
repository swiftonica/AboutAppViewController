//
//  File.swift
//  
//
//  Created by Jeytery on 25.01.2023.
//

import Foundation
import UIKit

public struct AboutViewControllerPreferences {
    public init(
        appIcon: UIImage,
        appName: String,
        appVersionName: String?,
        versionNumber: String,
        build: Int,
        copyrightText: String,
        buttons: AboutViewControllerPreferences.AboutButtons?
    ) {
        self.appIcon = appIcon
        self.appName = appName
        self.appVersionName = appVersionName
        self.versionNumber = versionNumber
        self.build = build
        self.copyrightText = copyrightText
        self.buttons = buttons
    }
    
    public struct AboutButton {
        public init(url: String, title: String) {
            self.url = url
            self.title = title
        }
        
        public let url: String
        public let title: String
    }
    
    public typealias AboutButtons = [AboutButton]

    public let appIcon: UIImage
    public let appName: String
    public let appVersionName: String?
    
    public let versionNumber: String
    public let build: Int
    
    public let copyrightText: String
    public let buttons: AboutButtons?
    
    public var appNameAttributedString: NSAttributedString {
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
