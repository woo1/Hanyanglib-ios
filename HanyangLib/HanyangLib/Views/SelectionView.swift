//
//  SelectionView.swift
//  HanyangLib
//
//  Created by wijang's mac on 2017. 5. 3..
//  Copyright © 2017년 wooil. All rights reserved.
//

import UIKit

class SelectionView: UIView {

    @IBOutlet var selLabel1: UILabel!
    @IBOutlet var selLabel2: UILabel!
    var btn1Clicked : ((Void)->Void)?
    var btn2Clicked : ((Void)->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(parentView: UIView, text1: String, text2: String, btn1Clicked:((Void)->Void)?, btn2Clicked:((Void)->Void)?){
        let vWidth = UIScreen.main.bounds.width - 40
        let vY     = (UIScreen.main.bounds.height - 75) / 2
        let fullFrame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        self.init(frame: fullFrame)
        
        let bgView = UIView.init(frame: fullFrame)
        bgView.backgroundColor = UIColor.black
        bgView.alpha = 0.8
        self.addSubview(bgView)
        
        
        let selView = Bundle.main.loadNibNamed("SelectionView", owner: self, options: nil)![0] as! UIView
        selView.frame = CGRect.init(x: 20, y: vY, width: vWidth, height: 75)
        self.addSubview(selView)
        
        self.selLabel1.text = text1
        self.selLabel2.text = text2
        
        self.btn1Clicked = btn1Clicked
        self.btn2Clicked = btn2Clicked
        
        parentView.addSubview(self)
    }

    @IBAction func btn1Clicked(_ sender: Any) {
        self.removeFromSuperview()
        if self.btn1Clicked != nil {
            self.btn1Clicked!()
        }
    }
    
    @IBAction func btn2Clicked(_ sender: Any) {
        self.removeFromSuperview()
        if self.btn2Clicked != nil {
           self.btn2Clicked!()
        }
    }
}
