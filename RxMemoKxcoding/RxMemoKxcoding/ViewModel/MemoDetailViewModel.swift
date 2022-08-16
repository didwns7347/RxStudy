//
//  MemoDetailViewModel.swift
//  RxMemoKxcoding
//
//  Created by yangjs on 2022/08/11.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class MemoDetailViewModel:CommonViewModel{
    let bag = DisposeBag()
    var selectedMemo : Memo
    private var formatter : DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "ko_kr")
        f.dateStyle = .medium
        f.timeStyle = .medium
        return f
    }()
    
    var contents : BehaviorSubject<[String]>
    var activity : BehaviorSubject<UIActivityViewController?>
    
    init(title: String, memo:Memo, sceneCoordinator:SceneCoordinatorType, storage: MemoStorageType){
        self.selectedMemo = memo
        contents = BehaviorSubject<[String]>(value: [memo.content, formatter.string(from: memo.insertDate)])
        activity = BehaviorSubject<UIActivityViewController?>(value: nil)
        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage)
    }
    lazy var popAction = CocoaAction { [unowned self] in
        return self.sceneCoordinator.close(animated: true)
            .asObservable()
            .map{ _ in }
    }
    func performUpdate(memo: Memo)-> Action<String, Void>{
        return Action { input in
            self.storage.update(memo: memo, content: input)
                .do(onNext: {self.selectedMemo = $0})
                .map{
                    return [$0.content, self.formatter.string(from: $0.insertDate)]
                }
                .bind(onNext: {self.contents.onNext($0)})
                .disposed(by: self.bag)
            return Observable.empty()
        }
    }
    func makeEditAction() -> CocoaAction{
        return CocoaAction{ _ in
            let composeViewModel = MemoComposeViewModel(title: "메모 편집", content: self.selectedMemo.content, sceneCoordinator: self.sceneCoordinator, storage: self.storage, saveAction: self.performUpdate(memo: self.selectedMemo), cancelAction: nil)
            let composeScene = Scene.compose(composeViewModel)
            
            return self.sceneCoordinator.transition(to: composeScene, using: .modal, animiate: true)
                .asObservable()
                .map{_ in }
            
        }
    }
    
    func deleteAction()->CocoaAction{
        return CocoaAction { _ in
            self.storage.delete(memo: self.selectedMemo)
            return self.sceneCoordinator.close(animated: true)
                .asObservable()
                .map{ _ in }
            
        }
    }
    
    
    
}
