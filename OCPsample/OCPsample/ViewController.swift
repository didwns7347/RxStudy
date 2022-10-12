//
//  ViewController.swift
//  OCPsample
//
//  Created by yangjs on 2022/10/05.
//

import UIKit
import RxSwift
import SnapKit



class ViewController: UIViewController {
    let viewModel: ColorViewModel!
    let bag = DisposeBag()
    
    lazy var buttonContainerStackView: UIStackView = {
        let view = UIStackView()
        view.spacing = 16.0
        return view
    }()
    
    lazy var leftButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("파란색 버튼", for: .normal)
        return button
    }()
    
    lazy var rightButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("빨간색 버튼", for: .normal)
        return button
    }()
    
    lazy var infoLabel : UILabel  = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupViews()
        addSubviews()
        makeConstraints()
        bindInput()
        bindOutput()
    }
    
    init(viewModel:ColorViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
private extension ViewController{
    func setupViews(){
        view.backgroundColor = .white
    }
    
    func addSubviews(){
        view.addSubview(buttonContainerStackView)
        [leftButton,rightButton].forEach{buttonContainerStackView.addArrangedSubview($0)}
        view.addSubview(infoLabel)
    }
    
    func makeConstraints(){
        buttonContainerStackView.snp.makeConstraints{
            $0.centerX.centerY.equalToSuperview()
        }
        infoLabel.snp.makeConstraints{
            $0.top.equalTo(buttonContainerStackView.snp.bottom).offset(16)
            $0.centerX.equalTo(view.snp.centerX)
        }
    }
    
    func bindInput(){
        leftButton.rx.tap
            .subscribe(onNext:{[weak self] in
                self?.viewModel.didTapBlueButton()
            }).disposed(by: bag)
        
        rightButton.rx.tap
            .subscribe(onNext:{
                self.viewModel.didTapRedButton()
            }).disposed(by: bag)
    }
    
    func bindOutput(){
        viewModel.buttonInfo.bind(to: infoLabel.rx.text)
            .disposed(by: bag)
    }
}
