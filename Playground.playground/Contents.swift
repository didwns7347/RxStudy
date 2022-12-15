import UIKit

class Test{
    private var num = 10{
        didSet{
            //바뀐후
            print("didset called \(oldValue)")
            if num>10{
                num=0
            }
            print(num)
            
        }
        willSet{
            //바뀌기전
            print("willSet Called \(newValue)")
            print(num)
        }
    }
    var cNum :Int {
        get{
            return num
        }
        set{
            num = newValue
        }
    }
}

let t = Test()
t.cNum = 11
for _ in (1...13){
    t.cNum += 1
    print(t.cNum)
}
