//
//  Protocol.swift
//  TravelTalkProject
//
//  Created by 남현정 on 2024/01/15.
//

import Foundation
// 재사용성이 있을 때 identifier을 더 간편하게 쓰기 위해서
protocol ReuseableProtocol {
    static var identifier: String { get }
}
