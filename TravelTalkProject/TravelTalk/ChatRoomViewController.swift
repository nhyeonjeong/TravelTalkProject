//
//  ChatRoomViewController.swift
//  TravelTalkProject
//
//  Created by 남현정 on 2024/01/15.
//

import UIKit

class ChatRoomViewController: UIViewController {
    

    @IBOutlet weak var chatRoomTableView: UITableView!
    
    @IBOutlet weak var chatRoomTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    var navigationTitle: String = ""
    var chatList: [Chat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
        designView()
    }
    
    func designView() {
        chatRoomTextField.backgroundColor = .systemGray6
        chatRoomTextField.layer.cornerRadius = 10
        chatRoomTextField.placeholder = "메세지를 입력하세요"
        
        sendButton.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        sendButton.tintColor = .systemGray4
    }
    


}

extension ChatRoomViewController: ViewSetting {
    func configureView() {
        navigationItem.title = navigationTitle
        
        chatRoomTableView.delegate = self
        chatRoomTableView.dataSource = self
        
        let xib = UINib(nibName: BubbleMyTableViewCell.identifier, bundle: nil)
        chatRoomTableView.register(xib, forCellReuseIdentifier: BubbleMyTableViewCell.identifier)
        
        let xib2 = UINib(nibName: BubbleOpponentTableViewCell.identifier, bundle: nil)
        chatRoomTableView.register(xib2, forCellReuseIdentifier: BubbleOpponentTableViewCell.identifier)
        
    }
}

extension ChatRoomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 자기 자신이면
        if chatList[indexPath.row].user == .user {
            let cell = chatRoomTableView.dequeueReusableCell(withIdentifier: BubbleMyTableViewCell.identifier, for: indexPath) as! BubbleMyTableViewCell
            
            cell.configureCell(data: chatList[indexPath.row])
            
            return cell
        } else {
            let cell = chatRoomTableView.dequeueReusableCell(withIdentifier: BubbleOpponentTableViewCell.identifier, for: indexPath) as! BubbleOpponentTableViewCell
            
            cell.configureCell(data: chatList[indexPath.row])
            
            return cell
        }
    }
    
    
}
