import UIKit

var greeting = "Hello, playground"
class Book{
    let title:String
    init(title:String){
        self.title = title
    }
}
struct Product{
    let book : Book
}
class User{
    private var year : Int = 2020 // 저장 프로퍼티
    var x : Int { // 연산 프로퍼티
        get{
            return year
        }
        set(abcdef){
            self.year = abcdef * 2
        }
    }

}
let a = Product(book: Book(title: "이기진"))
let b = a
//=== a의 인스턴스와 b의 인스턴스가 같은지 비교
a.book === b.book
let user = User()
user.x

print(user.x)
