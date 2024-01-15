//
//  TravelTeamTalkTableViewCell.swift
//  TravelTalkProject
//
//  Created by 남현정 on 2024/01/15.
//

import UIKit

class TravelTeamTalkTableViewCell: UITableViewCell {

    @IBOutlet weak var imageUIView: UIView!
    @IBOutlet var userImageViews: [UIImageView]! // 4 개 다 이어주는 거 잊지 말깈ㅋ
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var recentMessageLabel: UILabel!
    @IBOutlet weak var recentDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageUIView.backgroundColor = .clear
        designCell()
    }
    
    /// 데이터 가져와서 띄우기
    func configureCell(data: ChatRoom) {
        for i in 0..<4 {
            userImageViews[i].image = UIImage(named: data.chatroomImage[i])
        }

        nicknameLabel.text = data.chatroomName
        recentMessageLabel.text = data.chatList.last?.message // 마지막 요소가 있을 때 가져오기
        
        guard let lastChat = data.chatList.last else {
            return
        }
        recentDateLabel.text = DateFormatter.format.getDate(dateString: lastChat.date, newDateFormat: "yy.MM.dd")
  
    }
    
    /// 셀 요소 디자인
    func designCell() {
        
        for i in 0..<4 {
            userImageViews[i].contentMode = .scaleAspectFill
            userImageViews[i].layer.cornerRadius = userImageViews[i].frame.width / 3
        }

        // Label
        nicknameLabel.font = FontStyle.nickname
        nicknameLabel.textColor = TextColor.nickname
        
        recentMessageLabel.font = FontStyle.recentMessage
        recentMessageLabel.textColor = TextColor.recentMessage
        
        recentDateLabel.font = FontStyle.date
        recentDateLabel.textColor = TextColor.date
        recentDateLabel.textAlignment = .right

        /*
        opponentNicknameLabel.boldStyleLable(fontSize: 15)
        recentTalkLabel.boldStyleLable(textColor: .gray, fontSize: 14, numberOfLines: 1)
        recentDateLabel.boldStyleLable(textColor: .systemGray2, alignment: .right, fontSize: 14, numberOfLines: 1)
         */
        
    }
    
    

}
