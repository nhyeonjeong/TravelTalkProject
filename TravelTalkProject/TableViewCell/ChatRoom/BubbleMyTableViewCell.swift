//
//  BubbleMyTableViewCell.swift
//  TravelTalkProject
//
//  Created by 남현정 on 2024/01/15.
//

import UIKit

class BubbleMyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myChatView: UIView!
    @IBOutlet weak var myChatLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    let format = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        designCell()
        
    }
    func designCell() {
        myChatLabel.boldStyleLable(fontSize: 15, numberOfLines: 0)
        myChatView.layer.cornerRadius = 10
        myChatView.layer.borderWidth = 1
        myChatView.layer.borderColor = UIColor.gray.cgColor
        myChatView.backgroundColor = .systemGray5
//        myChatLabel.clipsToBounds = true
        
        dateLabel.boldStyleLable(textColor: .gray, alignment: .right, fontSize: 13, numberOfLines: 1)
    }

    func configureCell(data: Chat) {
        myChatLabel.text = data.message
        dateLabel.text = getDate(dateString: data.date)
    }
    
    func getDate(dateString: String) -> String{
        format.dateFormat = "yyyy-MM-dd hh:mm"

        let backToDate: Date = format.date(from: dateString) ?? Date()
        
        format.dateFormat = "hh:mm a"
        let result = format.string(from: backToDate)
        
        return result
    }
    
}
