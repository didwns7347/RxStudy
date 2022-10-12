//
//  Mastering RxSwift
//  Copyright (c) KxCoding <help@kxcoding.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit
import RxSwift

/*:
 # flatMap
 */

let disposeBag = DisposeBag()

//let redCircle = "🔴"
//let greenCircle = "🟢"
//let blueCircle = "🔵"
//
//let redHeart = "❤️"
//let greenHeart = "💚"
//let blueHeart = "💙"
//
//Observable.from([redCircle,greenCircle,blueCircle])
//    .flatMap{circle -> Observable<String> in
//        switch circle{
//        case redCircle:
//            return Observable.repeatElement(redHeart).take(5)
//        case greenCircle:
//            return Observable.repeatElement(greenHeart).take(5)
//        case blueCircle:
//            return Observable.repeatElement(blueHeart).take(5)
//        default:
//            return Observable.just("")
//        }
//    }.subscribe{print($0)}
//    .disposed(by: disposeBag)
//
//
//struct Student {
//    var score: BehaviorSubject<Int>
//}
//
//let ryan = Student(score: BehaviorSubject(value: 80))
//let charlotte = Student(score: BehaviorSubject(value: 90))
//
//// 2
//let student = PublishSubject<Student>()
//
//// 3
//let fmEx = student
//    .flatMap{ a in
//        a.score
//    }
//let mEx = student
//    .map{$0.score}
//// 4
//    mEx.subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)
//
//// 5
//student.onNext(ryan)    // Print: 80
//
//// 6
//ryan.score.onNext(85)   // Print: 80 85
//
//// 7
//student.onNext(charlotte)   // Print: 80 85 90
//
//// 8
//ryan.score.onNext(95)   // Print: 80 85 90 95
//
//// 9
//charlotte.score.onNext(100)


let a = Observable.of(1,2,3)
let o1 = a.subscribe { event in
    print("o1 \(event)")
}.disposed(by: disposeBag)

let o2 = a.subscribe { event in
    print("o2 \(event)")
}

a.flatMap { a -> Observable<String> in
    return Observable.create { observer in
        observer.onNext("TRANS")
        return Disposables.create()
    }
}.subscribe{
    print($0)
}

