//
//  ViewController.swift
//  CountOnMe
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    

    var calcul: Calculation!

    override func viewDidLoad() {
        calcul = Calculation()
    }


    // MARK: - Outlets

    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!

    // MARK: - Action

    @IBAction func tappedNumberButton(_ sender: UIButton) {
        for (i, numberButton) in numberButtons.enumerated() {
            if sender == numberButton {
                calcul.addNewNumber(i)
                updateDisplay()
            }
        }
    }

    @IBAction func plus() {
        if calcul.canAddOperator {
        	calcul.addNewOperator("+")
            updateDisplay()
        }else{
            if calcul.isStarted {
                showAlertWrongExpression()
            } else {
                showAlertBeginNewCalcul()
            }
        }
    }

    @IBAction func minus() {
        if calcul.canAddOperator {
            calcul.addNewOperator("-")
            updateDisplay()
        }else{
            if calcul.isStarted {
                showAlertWrongExpression()
            } else {
                showAlertBeginNewCalcul()
            }
        }
    }

    @IBAction func equal() {
        if calcul.isExpressionCorrect {
            let total = calcul.calculateTotal()
            textView.text = "\(total)"
            calcul.clear()
        }else{
            if calcul.isStarted {
                showAlertWrongExpression()
            } else {
                showAlertBeginNewCalcul()
            }
        }
    }
    
    @IBAction func clear() {
        calcul.previousResult = ""
        calcul.clear()
        updateDisplay()
    }
    
    private func updateDisplay() {
        textView.text = calcul.toText()
    }

    private func showAlertWrongExpression() {
        let alertVC = UIAlertController(title: "Zéro!", message: "Expression incorrecte !", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

    private func showAlertBeginNewCalcul() {
        let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
