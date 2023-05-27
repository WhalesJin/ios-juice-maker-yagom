//
//  StockChangeViewController.swift
//  JuiceMaker
//
//  Created by Whales on 2023/05/24.
//

import UIKit

class StockChangeViewController: UIViewController {
    @IBOutlet private weak var strawberryStockLabel: UILabel!
    @IBOutlet private weak var bananaStockLabel: UILabel!
    @IBOutlet private weak var pineappleStockLabel: UILabel!
    @IBOutlet private weak var kiwiStockLabel: UILabel!
    @IBOutlet private weak var mangoStockLabel: UILabel!
    
    @IBOutlet private weak var closeButton: UIBarButtonItem!
    
    @IBOutlet private weak var strawberryStockStepper: UIStepper!
    @IBOutlet private weak var bananaStockStepper: UIStepper!
    @IBOutlet private weak var pineappleStockStepper: UIStepper!
    @IBOutlet private weak var kiwiStockStepper: UIStepper!
    @IBOutlet private weak var mangoStockStepper: UIStepper!
    
    weak var delegate: Exchangeable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureComponents()
    }
    
    func configureComponents() {
        guard let fruitCurrentInvetory = delegate?.takeCurrentInventory() else {
            return
        }
        
        configureStockLabel(fruitCurrentInvetory)
        configureStepper(fruitCurrentInvetory)
    }
    
    func configureStockLabel(_ fruitCurrentInvetory: [Fruit: Int]) {
        strawberryStockLabel.text = String(fruitCurrentInvetory[.strawberry] ?? -1)
        bananaStockLabel.text = String(fruitCurrentInvetory[.banana] ?? -1)
        pineappleStockLabel.text = String(fruitCurrentInvetory[.pineapple] ?? -1)
        kiwiStockLabel.text = String(fruitCurrentInvetory[.kiwi] ?? -1)
        mangoStockLabel.text = String(fruitCurrentInvetory[.mango] ?? -1)
    }
    
    func configureStepper(_ fruitCurrentInvetory: [Fruit: Int]) {
        strawberryStockStepper.value = Double(fruitCurrentInvetory[.strawberry] ?? -1)
        bananaStockStepper.value = Double(fruitCurrentInvetory[.banana] ?? -1)
        pineappleStockStepper.value = Double(fruitCurrentInvetory[.pineapple] ?? -1)
        kiwiStockStepper.value = Double(fruitCurrentInvetory[.kiwi] ?? -1)
        mangoStockStepper.value = Double(fruitCurrentInvetory[.mango] ?? -1)
    }
    
    func changeToInt(_ text: String?) -> Int {
        guard let text = text, let convertedNumber = Int(text) else {
            return -1
        }
        
        return convertedNumber
    }
    
    func changeToDouble(_ text: String?) -> Double {
        guard let text = text, let convertedNumber = Double(text) else {
            return -1
        }
        
        return convertedNumber
    }
    
    @IBAction func didTapStockChangeStepper(_ sender: UIStepper) {
        switch sender {
        case strawberryStockStepper:
            strawberryStockLabel.text = String(Int(sender.value))
        case bananaStockStepper:
            bananaStockLabel.text = String(Int(sender.value))
        case pineappleStockStepper:
            pineappleStockLabel.text = String(Int(sender.value))
        case kiwiStockStepper:
            kiwiStockLabel.text = String(Int(sender.value))
        case mangoStockStepper:
            mangoStockLabel.text = String(Int(sender.value))
        default:
            return
        }
    }
    
    @IBAction func didTapCloseButton(_ sender: UIBarButtonItem) {
//        var fruitInventory: [Fruit: String] = [:] // 빈 배열을 메모리 위에 올리겠다.
//
//        if let strawberryChangedStock = strawberryStockLabel.text,
//           let bananaChangedStock = bananaStockLabel.text,
//           let pineappleChangedStock = pineappleStockLabel.text,
//           let kiwiChangedStock = kiwiStockLabel.text,
//           let mangoChangedStock = mangoStockLabel.text {
//            fruitInventory[.strawberry] = strawberryChangedStock
//            fruitInventory[.banana] = bananaChangedStock
//            fruitInventory[.pineapple] = pineappleChangedStock
//            fruitInventory[.kiwi] = kiwiChangedStock
//            fruitInventory[.mango] = mangoChangedStock
//
//            delegate?.exchangeInventory(inventory: fruitInventory)
//        }
        // 6번의 메모리를 거칠걸 한 번에 가능(시간 복잡도 6 -> 1)
        let strawberryChangedStock = changeToInt(strawberryStockLabel.text)
            let bananaChangedStock = changeToInt(bananaStockLabel.text)
            let pineappleChangedStock = changeToInt(pineappleStockLabel.text)
            let kiwiChangedStock = changeToInt(kiwiStockLabel.text)
            let mangoChangedStock = changeToInt(mangoStockLabel.text)
        
        let fruitInventory: [Fruit: Int] = [.strawberry: strawberryChangedStock,
                                               .banana: bananaChangedStock,
                                               .pineapple: pineappleChangedStock,
                                               .kiwi: kiwiChangedStock,
                                               .mango: mangoChangedStock]
        delegate?.exchangeInventory(inventory: fruitInventory)
        self.presentingViewController?.dismiss(animated: true)
    }
}
