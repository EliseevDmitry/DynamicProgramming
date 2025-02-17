//
//  main.swift
//  DynamicProgramming
//
//  Created by Dmitriy Eliseev on 20.01.2025.
//

import Foundation

//-----------------------------------------------------------------------------------------------------------------1
/*
 
 1. Найти самую длинную последовательность гласных
 
 "suoidea" -> 3
 "iiihoovaeaaaoougjyaw" -> 8
 "" -> 0
 
 */

func countLongestVowelsChain(_ string: String) -> Int {
//    if string.isEmpty {
//        return 0
//    }
    guard !string.isEmpty else { return 0}
    let arrString: [Character] = Array(string)
    let vowels: Set<Character>  = Set(Array("euioaEUIOA"))
   // guard let _ = arrString.first else { return 0 }
    var counter = Int()
    var mainCounter = Int()
    for item in 0...arrString.count - 1 {
        if vowels.contains(arrString[item]) {
            counter += 1
        } else {
            if counter > mainCounter {
                mainCounter = counter
            }
            counter = 0
        }
    }
    return counter > mainCounter ? counter : mainCounter
}


//let testString = "iiihoovaeaaaoougjyaw"
//let result = countLongestVowelsChain(testString)
//print(result)

//-----------------------------------------------------------------------------------------------------------------2

/*
 
 2. Найти самую длинную последовательность одинаковых символов
 
 "abbcccd" -> "ccc"
 "abbcccdddd" -> "dddd"
 
 */

func countLongestSubsequence(_ string: String) -> String {
    
    guard !string.isEmpty else { return "" }
    let arrString: [Character] = Array(string)
    var counterOne = String(arrString[0])
    var counterTwo = String()
    for item in 0...arrString.count - 2 {
        if arrString[item] == arrString[item + 1] {
            counterOne.append(arrString[item + 1])
        } else {
            if counterOne.count > counterTwo.count {
                counterTwo = counterOne
            }
            counterOne = String(arrString[item + 1])
        }
    }
    return counterOne.count > counterTwo.count ? counterOne : counterTwo
}

//let testString = "abbcccdddd"
//let result = countLongestSubsequence(testString)
//print(result)

//-----------------------------------------------------------------------------------------------------------------3

/*
 
 3. Разбить строку на N строк
 
 "abcdef", 2 -> ["abc", "def"]
 "abcdef", 3 -> ["ab", "cd", "ef"]
 
 */

func splitNCases(_ string: String, n: Int) -> [String] {
    if string.isEmpty || n < 1 {
        return []
    }
    let arrayString: [Character] = Array(string)
    let length = Int(arrayString.count / n)
    var counter = 1
    var resultArr: [String] = []
    var returnString = ""
    for item in arrayString {
        returnString.append(item)
        if counter < length {
            counter += 1
            continue
        }
        resultArr.append(returnString)
        returnString = ""
        counter = 1
    }
    if !returnString.isEmpty {
        if let string = resultArr.last {
            let lastString = string + returnString
            resultArr[resultArr.count - 1] = lastString
        }
    }
    
    return resultArr
}

//let testString = "abcdef"
//let testCount = 3
//let result = splitNCases(testString, n: testCount)
//print(result)

//-----------------------------------------------------------------------------------------------------------------4

/*
 
 4. Найдите количество всех пар в массиве (использовать не больше 1 цикла)
 
 ["1", "2", "2", "3", "5"] -> 1
 ["1", "2", "2", "3", "5", "5", "1"] -> 3
 
 */
//-----------------------------------------------------------------------------------------------------(Переделано O(n))

func countCouples(array: [Character]) -> Int {
    var counter = (Int(), Int())
    for (index, item) in array.enumerated() {
        if counter.0 != counter.1 {
            counter.0 += 1
            continue
        }
        if index + 1 <= array.count - 1 {
            if item == array[index + 1] {
                counter.1 += 1
            }
        }
    }
    return counter.1
}

let testString: [Character] = ["1", "2", "2", "3", "5", "5", "1"]
let resultFunc = countCouples(array: testString)
print(resultFunc)

/*
func countCouples(array: [Character]) -> Int {
    var dict: [Character : Int] = [:]
    var counter = Int()
    for item in array {
        dict[item, default: 0] += 1
        let value = dict[item, default: 0]
        if value % 2 == 0 {
            counter += 1
        }
    }
//    var counter = Int()
//    for value in dict.values {
//        if value == 2 {
//            counter += 1
//        }
//    }
    return counter
}

//let testString: [Character] = ["1", "2", "2", "3", "5", "5", "1"]
//let result = countCouples(array: testString)
//print(result)
 */

//-----------------------------------------------------------------------------------------------------------------5

/*
 
 5. Вытащить символы которые повторяются в строке больше всех раз
 
 "tomatto" -> ["t"]
 "sarsaparilla" -> ["a"]
 ["abcdefab"] -> ["a", "b"]
 
 */

func appersMode(string: String) -> [String] {
    var dict: [Character : Int] = [:]
    
    var maxCount = Int()
    //O(n)
    for item in string {
        dict[item, default: 0] += 1
        maxCount = maxCount < dict[item, default: 0] ? dict[item, default: 0] : maxCount
    }
    
    //O(n)
    let result = dict.filter({$0.value == maxCount}).map({String($0.key)})
    return result
}

let testStringMax = "abcdefab"
let resultMax = appersMode(string: testStringMax)
print(resultMax)

/*
//переделать - O(n)!!!!

func appersMode(string: String) -> [String] {
    var dict: [Character : Int] = [:]
    for item in string {
        dict[item, default: 1] += 1
    }
    var counter: [(Character, Int)] = []
    for (key, value) in dict {
        counter.append((key, value))
    }
    
    let sortedCounter = counter.filter {$0.1 > 2}.sorted{ $0.1 > $1.1 }
    let resultArr: [String] = sortedCounter.map{String($0.0)}
    
    return resultArr
}
 */

//let testString = "tomatto"
//let result = appersMode(string: testString)
//print(result)

//-----------------------------------------------------------------------------------------------------------------6

/*
 6. Написать функцию сжатия RLE
 
 "AABBBXYZDDDDDDD" -> "A2B3XYZD7"
 
 */
//переделать O(n)
func rle(string: String) -> String {
    let stringArr = Array(string)
    var resultString = String()
    var counter = 1
    
    for index in 0...stringArr.count - 1 {
        if index + 1 > stringArr.count - 1 {
            
            // избавиться от этой логики
            if counter == 1 {
                resultString.append(stringArr[index])
            } else {
                resultString.append("\(stringArr[index])\(counter)")
            }
            break
        }
        if stringArr[index] == stringArr[index + 1] {
            counter += 1
        } else {
            if counter == 1 {
                resultString.append(stringArr[index])
            } else {
                resultString.append("\(stringArr[index])\(counter)")
            }
            counter = 1
        }
    }
    return resultString
}

//let testString = "AABBBXYZDDDDDDD"
//let result = rle(string: testString)
//print(result)

//-----------------------------------------------------------------------------------------------------------------7

/*
 
 
 7. Дан массив нужно сгруппировать в массив другого вида
 
 [1, 2, 2, 3, 3, 3] -> [[1], [2,2], [3, 3, 3]]
 
 */


func groupElements(array: [Int]) -> [[Int]] {
    var resultArr: [[Int]] = []
    var intArr: [Int] = []
    
    for item in 0...array.count - 1 {
        if item + 1 > array.count - 1 {
            intArr.append(array[item])
            break
        }
        if array[item] == array[item + 1] {
            intArr.append(array[item])
            continue
        } else {
            intArr.append(array[item])
            resultArr.append(intArr)
            intArr.removeAll()
        }
    }
    if !intArr.isEmpty {
        resultArr.append(intArr)
    }
    return resultArr
}

//let testArr = [1, 2, 2, 3, 3, 3]
//let result = groupElements(array: testArr)
//print(result)


//-----------------------------------------------------------------------------------------------------------------8

/*
 
 8. Дан отсортированный массив, преобразовать в строку сворачивая соседние числа в диапазоны
 [0,1,2,3,4,5,8,9,11] -> "0-5,8-9,11"
 [1,4] -> "1,4"
 
 */


func compressToRanges(array: [Int]) -> String {
    var counter = Int()
    guard let first = array.first else { return "" }
    var firstElement = first
    var resultString = String()
    while counter < array.count - 1 {
        if array[counter] == (array[counter + 1] - 1) {
            counter += 1
            continue
        } else {
            if firstElement != array[counter] {
                resultString.append("\(firstElement)-\(array[counter]), ")
            } else {
                resultString.append("\(firstElement), ")
            }
            firstElement = array[counter + 1]
            counter += 1
        }
    }
    resultString.append("\(firstElement)")
    return resultString
}


////let testArr = [0, 1, 2, 3, 4, 5, 8, 9, 11, 12, 13, 17, 21, 22, 44, 45, 46, 49]
//let testArr = [0, 1, 2, 3, 4, 5, 8, 9, 11]
//let result = compressToRanges(array: testArr)
//print(result)

//-----------------------------------------------------------------------------------------------------------------9
//-----------------------------------------------------------------------(повторить разбиение строки на массив слов)

/*
9. Удалять повторяющиеся слова которые идут последовательно

"alpha beta beta gamma gamma gamma delta alpha beta beta gamma gamma gamma delta"
-> "alpha beta gamma delta alpha beta gamma delta"
*/

func removeDuplicates(string: inout String) {
    let arrStrings: [String] = string.split(separator: " ").map {String($0)}
    string.removeAll()
    var counter = Int()
    while counter < arrStrings.count - 1 {
        if arrStrings[counter] == arrStrings[counter + 1] {
            counter += 1
        } else {
            string.append("\(arrStrings[counter]), ")
            counter += 1
            if counter == arrStrings.count - 1 {
                string.append("\(arrStrings[counter])")
                break
            }
        }
    }
}

//var testString = "alpha beta beta gamma gamma gamma delta alpha beta beta gamma gamma gamma delta"
//removeDuplicates(string: &testString)
//print(testString)

//-----------------------------------------------------------------------------------------------------------------10

/*

10. Даны даты заезда и отъезда каждого гостя. Для каждого гостя дата заезда строго раньше даты отъезда (то есть каждый гость останавливается хотя бы на одну ночь).

В пределах одного дня считается, что сначала старые гости выезжают, а затем въезжают новые

Найти максимальное число постояльцев, которые одновременно проживали в гостинице (считае, что измерение количества постояльцев происходит в конце дня)


[(1,2), (1,3), (2,4), (2,3)] -> 3 (3 посетителя были на 2 день)
 
 */

func maxVisitors(array: [(Int, Int)]) -> String {
    var dict: [Int : Int] = [ : ]
    for item in array {
        for day in item.0 ... item.1 - 1 {
            dict[day, default: 0] += 1
        }
    }
    let day = dict.sorted {$0.value > $1.value}.first?.key ?? 0
    let person = dict.sorted {$0.value > $1.value}.first?.value ?? 0
    return "\(day) - день, \(person) - гостя"
}

//let testArr = [(1,2), (1,3), (2,4), (2,3)]
//let result = maxVisitors(array: testArr)
//print(result)

/*
1
1 2
  2 3
  2
*/
