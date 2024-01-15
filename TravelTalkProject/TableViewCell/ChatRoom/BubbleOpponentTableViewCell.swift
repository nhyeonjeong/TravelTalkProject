//
//  BubbleOpponentTableViewCell.swift
//  TravelTalkProject
//
//  Created by 남현정 on 2024/01/15.
//

import UIKit

class BubbleOpponentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var opponentChatView: UIView!
    @IBOutlet weak var opponentImageView: UIImageView!
    @IBOutlet weak var opponentNameLabel: UILabel!
    @IBOutlet weak var opponentChatLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    let format = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        designCell()
    }
    
    func configureCell(data: Chat) {
        opponentImageView.image = UIImage(named: data.user.profileImage)
        opponentNameLabel.text = data.user.rawValue
        opponentChatLabel.text = data.message
        
        dateLabel.text = getDate(dateString: data.date)
    }
    
    func designCell() {
        opponentImageView.layer.cornerRadius = opponentImageView.frame.width / 2
        
        opponentChatView.backgroundColor = BubbleColor.opponentBackColor

        opponentNameLabel.font = FontStyle.chatRoomNickname
        opponentNameLabel.textColor = TextColor.chatRoomNickname

        opponentChatLabel.font = FontStyle.chatRoomMessage
        opponentChatLabel.numberOfLines = 0
        opponentChatLabel.textColor = TextColor.chatRoomMessage

        dateLabel.font = FontStyle.date
        dateLabel.textColor = TextColor.date
        dateLabel.textAlignment = .left
        /*
        opponentNameLabel.boldStyleLable(fontSize: 15, numberOfLines: 1)
        opponentChatLabel.boldStyleLable(fontSize: 15, numberOfLines: 0)
        dateLabel.boldStyleLable(textColor: .gray, fontSize: 13, numberOfLines: 1)
         */
        opponentChatView.layer.borderColor = BubbleColor.borderColor
        opponentChatView.layer.borderWidth = 1
        opponentChatView.layer.cornerRadius = 10
         
    }
    
    func getDate(dateString: String) -> String{
        format.dateFormat = "yyyy-MM-dd HH:mm"

        let backToDate: Date = format.date(from: dateString) ?? Date()
        
        format.dateFormat = "hh:mm a"
        let result = format.string(from: backToDate)
        
        return result
    }
    
}
