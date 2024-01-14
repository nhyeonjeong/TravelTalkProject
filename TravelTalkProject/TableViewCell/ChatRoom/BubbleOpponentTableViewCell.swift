//
//  BubbleOpponentTableViewCell.swift
//  TravelTalkProject
//
//  Created by 남현정 on 2024/01/15.
//

import UIKit

protocol BubbleTableViewCellSetting {
    static var identifier: String { get }
    func configureCell(data: Chat)
    
}
class BubbleOpponentTableViewCell: UITableViewCell, BubbleTableViewCellSetting {
    
    static let identifier = "BubbleOpponentTableViewCell"
    
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
        
        opponentNameLabel.boldStyleLable(fontSize: 15, numberOfLines: 1)
        opponentChatLabel.boldStyleLable(fontSize: 15, numberOfLines: 0)
        opponentChatView.layer.borderColor = UIColor.gray.cgColor
        opponentChatView.layer.borderWidth = 1
        opponentChatView.layer.cornerRadius = 10
        
        dateLabel.boldStyleLable(textColor: .gray, fontSize: 13, numberOfLines: 1)
    }
    
    func getDate(dateString: String) -> String{
        format.dateFormat = "yyyy-MM-dd HH:mm"

        let backToDate: Date = format.date(from: dateString) ?? Date()
        
        format.dateFormat = "hh:mm a"
        let result = format.string(from: backToDate)
        
        return result
    }
    
}
