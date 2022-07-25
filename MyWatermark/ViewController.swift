//
//  ViewController.swift
//  WaterMarkTest
//
//  Created by Hyunyou Lim on 2022/07/06.
//

import UIKit

class ViewController: UIViewController {
    
    var watermarkView: UIImageView!
    @IBOutlet var watermarkBtn: UIButton!
    @IBOutlet var changeBackgroundBtn: UIButton!
    
    @IBAction func touchWatermarkBtn(button: UIButton) {
        if button.isSelected == false {
            watermarkView = UIImageView(frame: .zero)
            watermarkView.frame = CGRect(x: 0, y: 0, width: self.view.frame.height * 2, height: self.view.frame.height * 2)
            watermarkView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            
            let watermarkImage = watermark(watermarkView.bounds, text: "WaterMark Adopted!!", device_width: self.view.frame.width)
            watermarkView.image = watermarkImage
            
            self.view.addSubview(watermarkView)
        }
        else{
            watermarkView.removeFromSuperview()
        }
        button.isSelected.toggle()
    }
    
    @IBAction func touchChangeBackgroundBtn(button: UIButton) {
        let r = Int.random(in: 0 ... 200)
        let g = Int.random(in: 0 ... 200)
        let b = Int.random(in: 0 ... 200)
        
        self.view.backgroundColor = UIColor(cgColor: CGColor(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: 0.5))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        watermarkBtn.setTitle("Set Watermark", for: .normal)
        watermarkBtn.setTitle("Undo Watermark", for: .selected)
        watermarkBtn.titleLabel?.textAlignment = .center
        watermarkBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        watermarkBtn.titleLabel?.numberOfLines = 2
        changeBackgroundBtn.setTitle("Change\nBackground Color", for: .normal)
        changeBackgroundBtn.titleLabel?.textAlignment = .center
        changeBackgroundBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        changeBackgroundBtn.titleLabel?.numberOfLines = 2
    }
    
}

func watermark(_ rect: CGRect, text: String, device_width: CGFloat) -> UIImage {
    let renderer = UIGraphicsImageRenderer(bounds: rect)
    
    let image = renderer.image{ (context) in
        
        context.cgContext.translateBy(x: (device_width / 2) - (sqrt(2) / 2 * rect.width), y: rect.height/4)
        
        let angle = CGFloat(-45) * .pi / 180
        context.cgContext.rotate(by: angle)
    
        let font = UIFont.systemFont(ofSize:20)
        let attrs:[NSAttributedString.Key: Any] = [
            .foregroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),
            .font: font,
        ]
        
        let size = (text as NSString).size(withAttributes: attrs)
        
        var x = CGFloat(0)
        var y = CGFloat(0)
        var i = 1
        repeat {
            (text as NSString).draw(at: CGPoint(x: x, y: y), withAttributes : attrs)
            x += 2 * size.width
            if(x >= rect.width){
                x = size.width * CGFloat(i)
                y += 100
                i = ( i == 0 ) ? 1 : 0
            }
            
        }while x < rect.width && y < rect.height
        
    }
    
    return image
}
