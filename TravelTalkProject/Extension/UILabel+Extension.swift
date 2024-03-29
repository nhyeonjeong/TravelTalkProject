//
//  UILabel+Extension.swift
//  TravelTalkProject
//
//  Created by 남현정 on 2024/01/15.
//

import UIKit

extension UILabel {
    func boldStyleLabel(textColor: UIColor = .label, alignment: NSTextAlignment = .left, fontSize: CGFloat = 17, numberOfLines nol: Int = 1) -> UILabel {
        self.textColor = textColor
        self.textAlignment = alignment
        self.font = .boldSystemFont(ofSize: fontSize)
        self.numberOfLines = nol
        
        return self
    }
}
