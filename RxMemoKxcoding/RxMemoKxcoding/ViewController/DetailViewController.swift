//
//  DetailViewController.swift
//  RxMemoKxcoding
//
//  Created by yangjs on 2022/08/11.
//

import UIKit

class DetailViewController: UIViewController , ViewModelBindableType{
    var viewModel : MemoDetailViewModel!
    
    @IBOutlet weak var contentTableView: UITableView!
    @IBOutlet weak var delete: UIBarButtonItem!
    @IBOutlet weak var share: UIBarButtonItem!
    @IBOutlet weak var edit: UIBarButtonItem!
    
    
    func bindViewModel() {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
