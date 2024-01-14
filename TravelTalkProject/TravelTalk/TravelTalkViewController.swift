//
//  TravelTalkViewController.swift
//  TravelTalkProject
//
//  Created by 남현정 on 2024/01/15.
//

import UIKit

protocol ViewSetting{
    func configureView()
}

class TravelTalkViewController: UIViewController {
    @IBOutlet weak var nameSearchBar: UISearchBar!
    
    @IBOutlet weak var talkListTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureView()
        
    }
}

extension TravelTalkViewController: ViewSetting {
    func configureView() {
        navigationItem.title = "TRAVEL TALK"
        nameSearchBar.placeholder = "친구 이름을 검색해보세요"
        
        talkListTableView.delegate = self
        talkListTableView.dataSource = self
        
        // TravelTalkTableViewCell의 xib
        let xib = UINib(nibName: TravelTalkTableViewCell.identifier, bundle: nil)
        talkListTableView.register(xib, forCellReuseIdentifier: TravelTalkTableViewCell.identifier)
    }
}

extension TravelTalkViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockChatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = talkListTableView.dequeueReusableCell(withIdentifier: TravelTalkTableViewCell.identifier, for: indexPath) as! TravelTalkTableViewCell
        // 세팅
        
        cell.configureCell(data: mockChatList[indexPath.row])
//        cell.backgroundColor = .green
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ChatRoomViewController") as! ChatRoomViewController
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
