import UIKit

var luckyNumbers = [7,4,38,21,16,15,1233,31,49]

// Filter out any even numbers
let fullClosureSignature = luckyNumbers.filter({ (number: Int) -> Bool in
    number.isMultiple(of: 2)
   // $0.isMultiple(of: 2)
})
print(fullClosureSignature)

// Sort array in ascending order
let sortNumbers = luckyNumbers.sorted(by: { (num1: Int, num2: Int) -> Bool in
    
    if num1 == 7 {
        return true
    } else if num2 == 7 {
        return false
    }
    return num1 < num2
    //return $0 < $1
})

print(sortNumbers)

let captainFirstTeam = luckyNumbers.sorted(by: { (name1: Int, name2: Int) -> Bool in
    if name1 == 7 {
        return true
    } else if name2 == 7 {
        return false
    }

    return name1 < name2
})

// Map the [Int] to [String] -- "7 is a lucky number"

//var luckyNumbers = [7,4,38,21,16,15,1233,31,49]
let mapped = luckyNumbers.map({ (number: Int) -> String in
    return "\(String(number)) is a lucky number"
    //return "\(String($0))is a lucky number"
})
print(mapped)

/// Functions passin in other functions
/// Can now make arbitrary-sized integer arrays, passing in a function that should be used to generate each number:
func makeArray(size: Int, using generator: () -> Int) -> [Int] {
    
    var numArray = [Int]()
    
    for _ in 0..<size {
        let number = generator()
        numArray.append(number)
    }
    
    return numArray
}

let rolls = makeArray(size: 5) {
    Int.random(in: 1...20)
}
print(rolls)

func generateNumber() -> Int {
    Int.random(in: 1...20)
}

let newRolls = makeArray(size: 10, using: generateNumber)
print(newRolls)

