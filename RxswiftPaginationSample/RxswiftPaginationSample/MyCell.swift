//
//  MyCell.swift
//  RxswiftPaginationSample
//
//  Created by yangjs on 2022/08/30.
//

import UIKit
import RxCocoa
import RxSwift
import Then
import SnapKit
import Kingfisher

final class MyCell : UITableViewCell{
    enum Contant{
        static let id = "MyCell"
        static let imageSize = CGSize(width:120,height: 120)
        static let placeholderImage = UIImage(named: "placeholder")
    }
    private let someImageView = UIImageView()
    
    @available(*, unavailable)
     required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
     }
     
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(someImageView)
        
        someImageView.snp.makeConstraints{
            $0.leading.top.bottom.equalTo(20)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.prepare()
    }
    
    func prepare(imageURL:String? = nil){
        guard let imageURL = imageURL, let url = URL(string: imageURL) else {
            self.someImageView.image = nil
            return
        }
        
        self.someImageView.kf.setImage(
            with: url,
            placeholder: Contant.placeholderImage,
            options: [
                .processor(DownsamplingImageProcessor(size: UIScreen.main.bounds.size)),
                .cacheOriginalImage,
                .keepCurrentImageWhileLoading,
                .progressiveJPEG(ImageProgressive(isBlur: false, isFastestScan: true, scanInterval: 0.1))
            ],
            completionHandler: nil
        )
    }
}



