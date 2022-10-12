//
//  CapturedView.swift
//  CapturePrevent
//
//  Created by yangjs on 2022/09/27.
//

import UIKit
class CapturedView: UIView{
    
    private let xibName = "CapturedView"

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    private func commonInit(){
        let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
}
