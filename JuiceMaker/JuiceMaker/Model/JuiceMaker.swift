//
//  JuiceMaker - JuiceMaker.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

struct JuiceMaker {
    private var fruitStore: FruitStore = FruitStore() // 메서드로만 움직여서 은닉화 가능.
    
    func readFruitInventory() -> [Fruit: Int] {
        return fruitStore.readFruitInventory()
    }
    
    func takeOrder(_ juice: Juice) throws {
        try verifyStock(for: juice)
        consumeFruit(for: juice)
    }

    private func verifyStock(for juice: Juice) throws {
        for (fruit, amount) in juice.recipe {
            try fruitStore.isStockSufficient(fruit, with: amount)
        }
    }
        
    private func consumeFruit(for juice: Juice) {
        for (fruit, amount) in juice.recipe {
            fruitStore.decreaseFruitStock(fruit, by: amount)
        }
    }
    
//    func changeFruitStock(_ fruit: Fruit, amount: Int) {
//        fruitStore.changeFruitStock(fruit, by: amount)
//    }
    
    func changeFruitInventory(_ changedInventory: [Fruit: Int]) {
        fruitStore.changeFruitInventory(changedInventory)
    }
}
