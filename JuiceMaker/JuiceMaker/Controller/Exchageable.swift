//
//  Exchageable.swift
//  JuiceMaker
//
//  Created by Whales on 2023/05/27.
//

protocol Exchangeable: AnyObject { // 클래스만 채택할 수 있다.
    func exchangeInventory(inventory: [Fruit: Int])
    func takeCurrentInventory() -> [Fruit: Int] // 정보제공 X, 현재 값 가져와
}
