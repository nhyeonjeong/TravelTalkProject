//
//  UILabel+Extension.swift
//  TravelTalkProject
//
//  Created by 남현정 on 2024/01/15.
//

import UIKit

extension UILabel {
    func boldStyleLable(textColor: UIColor = .label, alignment: NSTextAlignment = .left, fontSize: CGFloat = 17, numberOfLines nol: Int = 1) {
        self.textColor = textColor
        self.textAlignment = alignment
        self.font = .boldSystemFont(ofSize: fontSize)
        self.numberOfLines = nol
    }
}
