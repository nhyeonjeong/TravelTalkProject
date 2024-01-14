//
//  TravelTalkTableViewCell.swift
//  TravelTalkProject
//
//  Created by 남현정 on 2024/01/15.
//

import UIKit

protocol MainTableViewCellSetting {
    static var identifier: String { get }
    func configureCell(data: ChatRoom)
    
}
class TravelTalkTableViewCell: UITableViewCell, MainTableViewCellSetting {

    static let identifier = "TravelTalkTableViewCell"
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var recentTalkLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var recentDateLabel: UILabel!
    let format = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        designCell()
    }
    /// 데이터 가져와서 띄우기
    func configureCell(data: ChatRoom) {
        userImageView.image = UIImage(named: data.chatroomImage[0])
        userNameLabel.text = data.chatroomName
        recentTalkLabel.text = data.chatList.last?.message // 마지막 요소가 있을 때 가져오기
        
        recentDateLabel.text = getDate(chatList: data.chatList)
  
    }
    
    /// 셀 요소 디자인
    func designCell() {
        
        userImageView.contentMode = .scaleAspectFill
        userImageView.layer.cornerRadius = userImageView.frame.width / 2
        // Label
        userNameLabel.boldStyleLable(fontSize: 15)
        recentTalkLabel.boldStyleLable(textColor: .gray, fontSize: 14, numberOfLines: 1)
        recentDateLabel.boldStyleLable(textColor: .systemGray2, alignment: .right, fontSize: 14, numberOfLines: 1)
        
    }
    /// 표기할 날짜
    func getDate(chatList: [Chat]) -> String {
        format.dateFormat = "yyyy-MM-dd hh:mm"
        
        // 마지막 대화가 없다면 빈 문자열을 반환
        guard let lastTalk = chatList.last else {
            return ""
        }
        let backToDate: Date = format.date(from: lastTalk.date) ?? Date()
        
        format.dateFormat = "yy.MM.dd"
        let result = format.string(from: backToDate)
        
        return result
    }
    
}

