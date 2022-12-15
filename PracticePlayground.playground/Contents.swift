import UIKit

//
//class Person{
//    let name : String
//    let age: Int
//    init(name:String, age:Int){
//        self.name = name
//        self.age = age
//    }
//    func getName()->String{
//        return self.name
//    }
//}
//
//extension Person{
//    override func getName()->String{
//        return "KING"
//    }
//}
let sum = (1...10).reduce(0){$0+$1}
print(sum)
