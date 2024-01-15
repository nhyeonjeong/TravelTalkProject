//
//  Enumeration.swift
//  TravelTalkProject
//
//  Created by 남현정 on 2024/01/15.
//

import UIKit


// Q 이렇게 하는 경우도 있나1?! 그냥 한 번에 label을 지정해주고 싶어서..
enum LabelStyle {
    case nickname
    case recentMessage
    case chatRoomNickname
    case chatRoomMessage
    case date
    func labelSetting(_ label: UILabel) -> UILabel {
        switch self {
        case .nickname:
            return label.boldStyleLable(fontSize: 15, numberOfLines: 1)
        case .recentMessage:
            return label.boldStyleLable(textColor: .gray, fontSize: 14, numberOfLines: 1)
        case .chatRoomMessage:
            return label.boldStyleLable(fontSize: 14, numberOfLines: 0)
        case .chatRoomNickname:
            return label.boldStyleLable(fontSize: 14)
        case .date:
            return label.boldStyleLable(textColor: .gray, fontSize: 13, numberOfLines: 1)
        }
    }
}

enum FontStyle {
    static let nickname: UIFont = .boldSystemFont(ofSize: 15)
    static let recentMessage: UIFont = .boldSystemFont(ofSize: 14)
    static let chatRoomNickname: UIFont = .boldSystemFont(ofSize: 14)
    static let chatRoomMessage: UIFont = .boldSystemFont(ofSize: 14)
    static let date: UIFont = .boldSystemFont(ofSize: 13)
}

enum TextColor {
    static let nickname: UIColor = .label
    static let recentMessage: UIColor = .gray
    static let chatRoomNickname: UIColor = .label
    static let chatRoomMessage: UIColor = .label
    static let date: UIColor = .systemGray2
}

enum BubbleColor {
    static let opponentBackColor: UIColor = .systemBackground
    static let userBackColor: UIColor = .systemGray5
    static let borderColor: CGColor = UIColor.gray.cgColor
}
