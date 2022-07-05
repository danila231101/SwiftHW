//
//  ViewController.swift
//  gmsosnovskiyPW1
//
//  Created by Danila Kokin on 29.06.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var views: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    //function decomposition into new method
    func updateUI() {
        var colorSet = Set<UIColor>()
        var radiusSet = Set<CGFloat>()
        
        while colorSet.count < views.count {
            //generates decimal number between 000000 and FFFFFF
            let randomNumber: Int = .random(in: 0...16777215)
            //converts number to hexadecimal string
            let hexString = String(format:"%06X", randomNumber)
            guard let color = UIColor(hex: hexString) else {
                continue
            }
            colorSet.insert(color)
            radiusSet.insert(CGFloat.random(in: 0...32))
        }
        
        for view in self.views {
            view.layer.cornerRadius = radiusSet.popFirst() ?? 0
            view.backgroundColor = colorSet.popFirst()
        }
    }
    
    @IBAction func ChangeColorButtonPressed(_ sender: Any) {
        let button = sender as? UIButton
        button?.isEnabled = false
        
        UIView.animate(withDuration: 1, animations: {
            self.updateUI()
        }) { completion in
            button?.isEnabled = true
        }
    }
}

// MARK: UIcolor extension
extension UIColor {
    convenience init? (hex: String, opacity: Float = 1) {
        let r, g, b, a: CGFloat
        
        if hex.count == 6 {
        let scanner = Scanner(string: hex)
            var hexNumber: UInt64 = 0

            if scanner.scanHexInt64(&hexNumber) {
                r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                b = CGFloat(hexNumber & 0x0000ff) / 255
                a = CGFloat(opacity)

                self.init(red: r, green: g, blue: b, alpha: a)
                return
            }
        }
        return nil
    }
}

