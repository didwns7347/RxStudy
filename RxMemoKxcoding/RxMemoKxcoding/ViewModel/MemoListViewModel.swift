//
//  File.swift
//  RxMemoKxcoding
//
//  Created by yangjs on 2022/08/11.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class MemoListViewModel : CommonViewModel{
    var memoList : Observable<[Memo]>{
        return storage.memoList()
    }
    
    func makeCreateAction() -> CocoaAction{
        return CocoaAction{ _ in
            return self.storage.createMemo(content: "")
                .flatMap{ memo -> Observable<Void> in
                    let composeViewModel = MemoComposeViewModel(title: "새 매모", content: "", sceneCoordinator: self.sceneCoordinator, storage: self.storage, saveAction: self.performUpdate(memo: memo), cancelAction: self.performCancel(memo: memo))
                    let composeScene = Scene.compose(composeViewModel)
                    
                    return self.sceneCoordinator.transition(to: composeScene, using: .modal, animiate: true)
                        .asObservable()
                        .map{ _ in}
                }
        }
    }
  
    
    func performUpdate(memo: Memo)-> Action<String, Void>{
        return Action { input in
            return self.storage.update(memo: memo, content: input).map{_ in}
        }
    }
    
    func performCancel(memo: Memo) -> CocoaAction{
        return Action{
            return self.storage.delete(memo: memo).map { _ in }
        }
    }

    func detailAction12(memo:Memo)->Action<Memo,Void> {
        return Action{ memo in
            let detailVM = MemoDetailViewModel(title: "메모보기", memo:memo, sceneCoordinator:self.sceneCoordinator, storage: self.storage)
            let detailScene = Scene.detail(detailVM)
            return self.sceneCoordinator.transition(to: detailScene, using: .push, animiate: true)
                .asObservable().map{_ in}
        }
    }
    
    lazy var deleteAction: Action<Memo, Void> = {
        return Action{ memo in
            return self.storage.delete(memo: memo)
                .map{_ in }
        }
    }()
 
}
