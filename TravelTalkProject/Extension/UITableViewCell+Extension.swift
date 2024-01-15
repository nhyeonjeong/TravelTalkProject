//
//  UITableViewCell+Extension.swift
//  TravelTalkProject
//
//  Created by 남현정 on 2024/01/15.
//

import UIKit

extension UITableViewCell: ReuseableProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
