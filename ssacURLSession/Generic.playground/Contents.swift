

import UIKit

// MARK: - Swap

func swapToInts(a: inout Int, b: inout Int) {
    let tempA = a
    a = b
    b = tempA
}

func swapToDouble(a: inout Double, b: inout Double) {
    let tempA = a
    a = b
    b = tempA
}

func swapToString(a: inout String, b: inout String) {
    let tempA = a
    a = b
    b = tempA
}

var apple = "사과"
var banana = "바나나"

swapToString(a: &apple, b: &banana)
print(apple, banana)


// T: type parameter - 함수 정의할때는 타입 모름, 함수 호출 시 매개변수 타입으로 대체
func swapToValues<T>(a: inout T, b: inout T) {
    let tempA = a
    a = b
    b = tempA
}

var a = 3.3
var b = 5.1

swapToValues(a: &a, b: &b)
print(a, b)


// MARK: - Operator Protocol

func total<T: Numeric>(a: [T]) -> T {
    return a.reduce(.zero, +)
}

func total<T: AdditiveArithmetic>(a: [T]) -> T {
    return a.reduce(.zero, +)
}

total(a: [3,4.2,5])


// MARK: - Stack

struct Stack<T> {
    var items = [T]()
    
    mutating func push(_ item: T) {
        items.append(item)
    }
    
    mutating func pop() -> T {
        items.removeLast()
    }
}

extension Stack {
    var topElement: T? {
        return self.items.last
    }
}

extension Array {
    var topArrElement: Element? {
        return self.last
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("T")
stackOfStrings.push("O")
stackOfStrings.push("M")

stackOfStrings.pop()
print(stackOfStrings ,stackOfStrings.topElement)


// MARK: - Equal

func equal<T: Equatable>(a: T, b: T) -> Bool {
    return a == b
}

equal(a: 2, b: 4)


class Animal: Equatable {
    
    static func  == (lhs: Animal, rhs: Animal) -> Bool {
        return lhs.name == rhs.name
    }
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

let one = Animal(name: "dog")
let two = Animal(name: "cat")

equal(a: one, b: two)

