//
//  SceneCoordinator.swift
//  RxMemoKxcoding
//
//  Created by yangjs on 2022/08/11.
//

import Foundation
import RxSwift
import RxCocoa
extension UIViewController{
    var sceneViewController : UIViewController{
        return self.children.last ?? self
    }
}
class SceneCoordinator : SceneCoordinatorType{
    private let bag = DisposeBag()
    
    private var window : UIWindow
    private var currentVC : UIViewController
    
    required init(window: UIWindow){
        self.window = window
        currentVC =  window.rootViewController!
    }
    
    
    @discardableResult
    func transition(to scene: Scene, using style: TransitionStyle, animiate: Bool) -> Completable {
        let subject = PublishSubject<Never>()
        
        let target = scene.instantiate()
        
     
        switch style {
        case .root:
            currentVC = target.sceneViewController
            window.rootViewController = target
            subject.onCompleted()
            
        case .push:
            print(currentVC)
            guard let nav = currentVC.navigationController else {
                subject.onError(TransitionError.navigationControllerMissing)
                break
            }
            nav.rx.willShow
                .withUnretained(self)
                .subscribe(onNext:{coordinator,event in
                    coordinator.currentVC = event.viewController.sceneViewController
                }).disposed(by: bag)
            
            nav.pushViewController(target, animated: animiate)
            currentVC = target.sceneViewController
            print(currentVC)
        case .modal:
            currentVC.present(target, animated: animiate){
                subject.onCompleted()
            }
            currentVC = target.sceneViewController
        }
        return subject.asCompletable()
    }
    
    @discardableResult
    func close(animated: Bool) -> Completable {
        
        return Completable.create { [unowned self] completable in
            if let presentingVC = self.currentVC.presentingViewController{
                self.currentVC.dismiss(animated: animated) {
                    self.currentVC = presentingVC.sceneViewController
                    completable(.completed)
                }
            }
            else if let nav = self.currentVC.navigationController{
                guard nav.popViewController(animated: animated) != nil else{
                    completable(.error(TransitionError.cannotPop))
                    return Disposables.create()
                }
                self.currentVC = nav.viewControllers.last!.sceneViewController
                completable(.completed)
            }
            else{
                completable(.error(TransitionError.unknown))
            }
            print(currentVC)
            return Disposables.create()
        }
    }
    
    
}
