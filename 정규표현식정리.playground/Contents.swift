import UIKit

//문자열 범위는 [] 사용
//숫자가 포함되는 문자열
let regex1 = "[0-9]"
let test1_1 = "1".range(of: regex1, options: .regularExpression) != nil
let test1_2 = "1a".range(of: regex1, options: .regularExpression) != nil
let test1_3 = "abc".range(of: regex1, options: .regularExpression) != nil
let test1_4 = "!1".range(of: regex1, options: .regularExpression) != nil
print(test1_1, test1_2, test1_3, test1_4)
// true true false true


//시작: ^ 끝: $
//숫자로만 이루어진 문자열
let regex2 = "^[0-9]$"
let test2_1 = "1".range(of: regex2, options: .regularExpression) != nil
let test2_2 = "1a".range(of: regex2, options: .regularExpression) != nil
let test2_3 = "abc".range(of: regex2, options: .regularExpression) != nil
let test2_4 = "!1".range(of: regex2, options: .regularExpression) != nil
print(test2_1, test2_2, test2_3, test2_4)

//모든 문자열:. 0회이상: *
//모든문자열
let regex3 = "^(.*)$"
let test3_1 = "1".range(of: regex3, options: .regularExpression) != nil
let test3_2 = "1a".range(of: regex3, options: .regularExpression) != nil
let test3_3 = "abc".range(of: regex3, options: .regularExpression) != nil
let test3_4 = "".range(of: regex3, options: .regularExpression) != nil
print(test3_1, test3_2, test3_3, test3_4)

//범위넣기
//한글자음 ㄱ-ㅎ 모음 ㅏ-ㅣ 소문자 a-z 대문자 A-Z 숫자 0-9
//한글 알파벳 숫자가 있는지 보는 문자열
let regex4 = "[가-힣ㄱ-하-ㅣa-zA-Z0-9]"
let test4_1 = "1".range(of: regex4, options: .regularExpression) != nil
let test4_2 = "가".range(of: regex4, options: .regularExpression) != nil
let test4_3 = "abc".range(of: regex4, options: .regularExpression) != nil
let test4_4 = "".range(of: regex4, options: .regularExpression) != nil
print(test4_1, test4_2, test4_3, test4_4)


//핸드폰 번호 정규식
let phoneRegex = "^01[0-1,7]?-[0-9]{3,4}?-[0-9]{4}$"
let test6_1 = "010-1111-2222".range(of: phoneRegex, options: .regularExpression) != nil
let test6_2 = "0101234567".range(of: phoneRegex, options: .regularExpression) != nil
let test6_3 = "011".range(of: phoneRegex, options: .regularExpression) != nil
let test6_4 = "12311112222".range(of: phoneRegex, options: .regularExpression) != nil
print(test6_1, test6_2, test6_3, test6_4)
