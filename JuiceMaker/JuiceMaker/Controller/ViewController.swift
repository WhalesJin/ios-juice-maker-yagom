//
//  JuiceMaker - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {

    @IBOutlet var strawberryJuiceButton: UIButton!
    @IBOutlet var bananaJuiceButton: UIButton!
    @IBOutlet var pineappleJuiceButton: UIButton!
    @IBOutlet var kiwiJuiceButton: UIButton!
    @IBOutlet var mangoJuiceButton: UIButton!
    @IBOutlet var strawberryBananaJuiceButton: UIButton!
    @IBOutlet var mangoKiwiJuiceButton: UIButton!
    @IBOutlet var stockChangeButton: UIBarButtonItem!
    
    let juiceMaker = JuiceMaker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTabStockChangeButton(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func didTabStrawberryJuiceButton(_ sender: UIButton) {
//        juiceMaker.takeOrder(.strawberryJuice)
    }
    @IBAction func didTabBananaJuiceButton(_ sender: UIButton) {
        if juiceMaker.takeOrder(.bananaJuice) {
            let juiceCompletionAlert = UIAlertController(title: nil,
                                          message: "바나나 쥬스가 나왔습니다! 맛있게 드세요!",
                                          preferredStyle: UIAlertController.Style.alert)
            let closeAction = UIAlertAction(title: "닫기", style: UIAlertAction.Style.default)
            juiceCompletionAlert.addAction(closeAction)
            present(juiceCompletionAlert, animated: true, completion: nil)
        } else {
            let juiceFailureAlert = UIAlertController(title: nil,
                                          message: "재료가 모자라요. 재고를 수정할까요?",
                                          preferredStyle: UIAlertController.Style.alert)
            let stockChangeAction = UIAlertAction(title: "예",
                                                  style: UIAlertAction.Style.destructive,
                                                  handler: { stockChangeAction in self.didTabStockChangeButton(self.stockChangeButton) })
            let closeAction = UIAlertAction(title: "아니오", style: UIAlertAction.Style.cancel)
            juiceFailureAlert.addAction(stockChangeAction)
            juiceFailureAlert.addAction(closeAction)
            present(juiceFailureAlert, animated: true, completion: nil)
        }
    }
    @IBAction func didTabPineappleJuiceButton(_ sender: UIButton) {
//        juiceMaker.takeOrder(.pineappleJuice)
    }
    @IBAction func didTabKiwiJuiceButton(_ sender: UIButton) {
//        juiceMaker.takeOrder(.kiwiJuice)
    }
    @IBAction func didTabMangoJuiceButton(_ sender: UIButton) {
//        juiceMaker.takeOrder(.mangoJuice)
    }
    @IBAction func didTabStrawberryBananaJuiceButton(_ sender: UIButton) {
//        juiceMaker.takeOrder(.strawberryBananaJuice)
    }
    @IBAction func didTabMangoKiwiJuiceButton(_ sender: UIButton) {
//        juiceMaker.takeOrder(.mangoKiwiJuice)
    }
    
    
}

