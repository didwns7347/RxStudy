//
//  BeerListCell.swift
//  RXTableViewSampleCode
//
//  Created by yangjs on 2022/10/20.
//

import UIKit
import Kingfisher
import SnapKit

class BeerListCell : UITableViewCell{
    let beerImgView = UIImageView()
    let nameLabel = UILabel()
    let taglineLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [beerImgView,nameLabel,taglineLabel].forEach{
            contentView.addSubview($0)
        }
        
        beerImgView.contentMode = .scaleAspectFit
        
        nameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        nameLabel.numberOfLines = 2
        
        taglineLabel.font = .systemFont(ofSize: 14, weight: .light)
        taglineLabel.textColor = .systemBlue
        taglineLabel.numberOfLines = 0
        
        beerImgView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.top.bottom.equalToSuperview().inset(20)
            make.width.equalTo(80)
            make.height.equalTo(120)
        }
        
        nameLabel.snp.makeConstraints{
            $0.leading.equalTo(beerImgView.snp.trailing).offset(10)
            $0.bottom.equalTo(beerImgView.snp.centerY)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        taglineLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
        }
    }
    
    func getConfigure(with beer: Beer){
        let imageURL = URL(string: beer.imageURL ?? "")
        beerImgView.kf.setImage(with: imageURL, placeholder: UIImage(named: "beer_icon"))
        nameLabel.text = beer.name ?? "이름 없는 맥주"
        taglineLabel.text = beer.tagLine
        accessoryType = .disclosureIndicator
    }
}
