//
//  JuiceMaker - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class JuiceOrderViewController: UIViewController, Exchangeable {
    @IBOutlet private weak var strawberryStockLabel: UILabel!
    @IBOutlet private weak var bananaStockLabel: UILabel!
    @IBOutlet private weak var pineappleStockLabel: UILabel!
    @IBOutlet private weak var kiwiStockLabel: UILabel!
    @IBOutlet private weak var mangoStockLabel: UILabel!
    
    @IBOutlet private weak var strawberryJuiceButton: UIButton!
    @IBOutlet private weak var bananaJuiceButton: UIButton!
    @IBOutlet private weak var pineappleJuiceButton: UIButton!
    @IBOutlet private weak var kiwiJuiceButton: UIButton!
    @IBOutlet private weak var mangoJuiceButton: UIButton!
    @IBOutlet private weak var strawberryBananaJuiceButton: UIButton!
    @IBOutlet private weak var mangoKiwiJuiceButton: UIButton!
    
    @IBOutlet private weak var stockChangeButton: UIBarButtonItem!
    
    private var juiceMaker: JuiceMaker = JuiceMaker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStockLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        changeFruitInventory()
        configureStockLabel()
    }
    
    func configureStockLabel() { // 언제나 최근값을 들고오면
        let fruitInventory = juiceMaker.readFruitInventory()
        
        guard let strawberryStock = fruitInventory[.strawberry],
              let bananaStock = fruitInventory[.banana],
              let pineappleStock = fruitInventory[.pineapple],
              let kiwiStock = fruitInventory[.kiwi],
              let mangoStock = fruitInventory[.mango]
        else {
            return
        }
        
        strawberryStockLabel.text = String(strawberryStock)
        bananaStockLabel.text = String(bananaStock)
        pineappleStockLabel.text = String(pineappleStock)
        kiwiStockLabel.text = String(kiwiStock)
        mangoStockLabel.text = String(mangoStock)
    }
    
    @IBAction func didTapOrderButton(_ sender: UIButton) {
        let juice: Juice
        
        switch sender {
        case strawberryJuiceButton:
            juice = .strawberryJuice
        case bananaJuiceButton:
            juice = .bananaJuice
        case pineappleJuiceButton:
            juice = .pineappleJuice
        case kiwiJuiceButton:
            juice = .kiwiJuice
        case mangoJuiceButton:
            juice = .mangoJuice
        case strawberryBananaJuiceButton:
            juice = .strawberryBananaJuice
        case mangoKiwiJuiceButton:
            juice = .mangoKiwiJuice
        default:
            return
        }
        
        order(juice)
    }
    
    func order(_ juice: Juice) {
        do {
            try juiceMaker.takeOrder(juice)
            configureStockLabel()
            showAlert(.completion(juice))
        } catch FruitStoreError.insufficientFruit {
            showAlert(.failure)
        } catch {
            showAlert(.error)
        }
    }
    
    func showAlert(_ result: JuiceOrderResult) {
        let alert = UIAlertController(
            title: nil,
            message: result.message,
            preferredStyle: UIAlertController.Style.alert
        )
        
        let closeAction = UIAlertAction(
            title: result.closeActionTitle,
            style: UIAlertAction.Style.default
        )
        
        if result == .failure {
            let stockChangeAction = UIAlertAction(
                title: "예",
                style: UIAlertAction.Style.destructive
            ) { _ in
                self.didTapStockChangeButton(self.stockChangeButton)
            }
            
            alert.addAction(stockChangeAction)
        }
        
        alert.addAction(closeAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func didTapStockChangeButton(_ sender: UIBarButtonItem) {
        guard let nextStockChangeViewController = storyboard?.instantiateViewController(
            identifier: "StockChangeViewController"
        ) as? StockChangeViewController else {
            return
        }
        
        nextStockChangeViewController.delegate = self
        nextStockChangeViewController.modalPresentationStyle = .fullScreen
        
        self.present(
            nextStockChangeViewController,
            animated: true
        )
    }
    
    func exchangeInventory(inventory: [Fruit : Int]) {
        juiceMaker.changeFruitInventory(inventory)
    }
    
    func takeCurrentInventory() -> [Fruit : Int] {
        juiceMaker.readFruitInventory()
    }
    
//    func changeFruitInventory() {
//        let strawberryChangedStock = changeToInt(strawberryStockLabel.text)
//        let bananaChangedStock = changeToInt(bananaStockLabel.text)
//        let pineappleChangedStock = changeToInt(pineappleStockLabel.text)
//        let kiwiChangedStock = changeToInt(kiwiStockLabel.text)
//        let mangoChangedStock = changeToInt(mangoStockLabel.text)
//
//        juiceMaker.changeFruitStock(.strawberry, amount: strawberryChangedStock)
//        juiceMaker.changeFruitStock(.banana, amount: bananaChangedStock)
//        juiceMaker.changeFruitStock(.pineapple, amount: pineappleChangedStock)
//        juiceMaker.changeFruitStock(.kiwi, amount: kiwiChangedStock)
//        juiceMaker.changeFruitStock(.mango, amount: mangoChangedStock)
//    }
    
    func changeToInt(_ text: String?) -> Int {
        guard let text = text, let convertedNumber = Int(text) else {
            return -1
        }
        
        return convertedNumber
    }
}
