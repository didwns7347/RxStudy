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

let a = Product(book: Book(title: "이기진"))
let b = a
print(b.book.title)
