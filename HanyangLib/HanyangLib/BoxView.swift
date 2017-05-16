//
//  BoxView.swift
//  HanyangLib
//
//  Created by wijang's mac on 2017. 4. 29..
//  Copyright © 2017년 wooil. All rights reserved.
//

import UIKit

class BoxView: UIView {
    @IBOutlet var label: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    func xibSetup() {
        let view = Bundle.main.loadNibNamed("BoxView", owner: self, options: nil)![0] as! UIView
        view.frame = self.bounds
        self.addSubview(view)
        
    }


}
