import Foundation

/**
 Exercise
 */

// Print Hello World in swift Play Ground
print("Hello World")


/**
 Variables
 */

// Create variables of different types and print it
var name = "Krunal"
var age = 20
let empId = 7
let dob: String? = "05-Aug-2002"
var isLearning = true

print("name: \(name)", "age: \(20)", "Employee ID: \(empId)", "DOB: \(dob ?? "unknown")", separator: "\n")
print("Learning: \(isLearning ? "Yes" : "No")")

// Create one integer and perform addition with 5 to that and print values
var value = 10
value += 5
print(value)


// There is one constant with value of interest rate (15%) create one playground for calculate interest for given amount and duration
let r = 15
var p, t: Double
p = 100
t = 10
let intrest = (p * Double(r) * t) / 100
print("S.I. : \(intrest)")

/**
 Operator
 */

// Create example for String concate using operators
let fname = "Harry"
let lname = "Potter"
let fullName = fname + " " + lname
print(fullName)


// Create one example for show usage of operator"s addition, multiplication, division for integers and floats
var n1: Float = 0
var n2: Int = 15
var op: Character = "/"

switch op {
case "+":
    print("addition:", n1 + Float(n2))
case "-":
    print("substraction:", n1 - Float(n2))
case "*":
    print("multiplication:", n1 * Float(n2))
case "/" where n1 != 0:
    print("division:", n1 / Float(n2))
default:
    print("[Error]: unknown operation!")
}


// What is turnery operator and show example of usage?
let num = -7
print("Number \(num) is:", num == 0 ? "zero" : (num > 0 ? "positive" : "nagative"))


/**
 Strings
 */

// Write a Swift program to create a new string made of a copy of the first two characters of a given string. If the given string is shorter than length 2, return whatever there is.
let s1 = "Sim"
if (s1.count >= 2) {
    var index = s1.index(s1.startIndex, offsetBy: 2)
    print(s1[..<index])
} else {
    print(s1)
}


// Write a Swift program to create a new string without the first and last character of a given string. The string length must be at least 2.
let s2 = "Simform"
let sIndex = s2.index(s2.startIndex, offsetBy: 1)
let eIndex = s2.index(s2.endIndex, offsetBy: -1)
print(s2[sIndex..<eIndex])

// Write a Swift program that accept two strings and return their concatenation, except the first char of each string. The given strings length must be at least 1.
let str1 = "Hello"
let str2 = "World"
let i1 = str1.index(str1.startIndex, offsetBy: 1)
let i2 = str2.index(str1.startIndex, offsetBy: 1)

print(str1[i1...] + str2[i2...])

// Write a Swift program to move the first two characters of a given string to the end. The given string length must be at least 2.
var s3 = "Swift"
s3.insert(contentsOf: s3.prefix(2), at: s3.endIndex)
s3.removeFirst(2)
print(s3)

// Write a Swift program to test if a given string starts with "Sw".
let s5 = "Simform"
print(s5.hasPrefix("Si"))

// Write a Swift program to create a new string made of the first and last n chars from a given string. The string length will be at least n.
let s6 = "Hello World"
let len = 3
let siS6 = s6.index(s6.startIndex, offsetBy: len)
let eiS6 = s6.index(s6.endIndex, offsetBy: -len)

print(s6[..<siS6] + s6[eiS6...])

// Try all string methods: https://developer.apple.com/documentation/swift/string
var str = "Welcome!"
var str3 = str + " Have a nice time!"
print(str3)

let cafe1 = "Cafe\u{301}"
let cafe2 = "Café"
print(cafe1 == cafe2)

let firstWordIdx = str.firstIndex(of: " ") ?? str.endIndex
print(str[..<firstWordIdx])

let cafe = "Hello\u{301} 🌍"
print(Array(cafe))

let country = "🇮🇳"
print(country.count)
print(country.unicodeScalars.count)
print(country.utf16.count)
print(country.utf8.count)

for i in str.indices {
    print(str[i], terminator: " ")
}

str.append("\n")
str.append("!---!")
print(str)

print("".isEmpty ? "empty" : "not empty")


/**
 Array
 */

// Write a Swift program to check whether the first element and the last element of a given array of integers are equal. The array length must be 1 or more.
let arr1 = ["a", "b", "c", "a"]
if !arr1.isEmpty {
    print(arr1.first == arr1.last )
}

// Write a Swift program to create a new array with double the length of a given array of integers and its last element is the same as the given array. The given array will be length 1 or more. By default, a new integer array contains all 0's.
let arr21 = [1, 2, 3, 4]
var arr22 = Array(repeating: 0, count: arr21.count * 2)
arr22[arr22.count - 1] = arr21.last!
print(arr22)

// Write a Swift program to create a new array, taking first two elements from a given array of integers. If the length of the given array is less than 2 use the single element of the given array
let arr31 = [0, 1, 2]
let arr32 = arr31.prefix(2)
print(arr32)

// Write a Swift program to take one array and find out maximum number from that array
let arr4 = [0, 50, 100, 250, 80, 150]
var max4 = 0
arr4.forEach { i in
    if i > max4 {
        max4 = i
    }
}
//max4 = arr4.max() ?? 0
print(max4)

// Write a Swift program to take one array and sort it in descending order.
var arr5 = [0,5,6,2,10]
arr5.sort(by: { i, j in
    i > j
})
print(arr5)

// Print all the numbers from listOfNumbers that are divisible by at least one number from divisors
var listOfNumbers = [1, 2, 3, 10, 100]
var divisors = [2, 5]

let arr6 = listOfNumbers.filter( { n in
    var flag = false
    for div in divisors {
        if (n%div == 0) {
            flag = true
            break
        }
    }
    return flag
})

print(arr6)

// Try all Array methods: new

var arr7 = [1, 2, 3, 4, 5]

arr7.append(6)
arr7.remove(at: 3)
arr7.removeAll(where: { i in
    i%2==0
})

print(arr7.contains([1, 3, 5]))

let arr72 = ["a", "b", "c", "d"]
for (index, val) in arr72.enumerated() {
    print("\(index): \(val)")
}


/**
 Control Flow
 */

// Print the powers of 2 that are less than or equal to N
let N = 100
var power: Int = 1
while true {
    power *= 2
    if power > 100 {
        break
    }
    print(power)
}

// Given an integer N draw a square of N x N asterisks. Look at the examples
let N2 = 4

for _ in 1...N2 {
    for _ in 1...N2 {
        print("*", terminator: "")
    }
    print("")
}

// Given an integer N draw a triangle of asterisks. The triangle should have N lines, the i-th line should have i asterisks on it
let N3 = 5
for i in 1...N3 {
    for _ in 1...i {
        print("*", terminator: "")
    }
    print("")
}

// Given an integer N draw a pyramid of asterisks. The pyramid should have N lines.
// On the i-th line there should be N-i spaces followed by i*2-1 asterisks.
let N4 = 4

for i in 1...N4 {
    for _ in 1...(N4-i+1) {
        print(terminator: " ")
    }
    for _ in 1..<i*2 {
        print("*", terminator: "")
    }
    print("")
}


// You are given a number. Print "prime" if the number is a prime and "not prime" otherwise.
// A number is a prime if it has exactly 2 distinct divisors (1 and itself).
let N5 = 29
var flag = true
for i in 2...Int(sqrt(27)) {
    if N5 % i == 0 {
        flag = false
        break
    }
}

print("\(N5) is \(flag ? "prime" : "not prime")")


/**
 Dictionary
 */

// You are given a dictionary code of type [String:String] which has values for all lowercase letters. The codedictionary represents a way to encode a message. For example if code["a"] = "z" and code["b"] = "x" the encoded version if "ababa" will be "zxzxz". You are also given a encodedMessage which contains only lowercase letters and spaces. Use the codedictionary to decode the message and print it. Write a Swift program to decode the message and print final output string

var code = [
"a" : "b",
"b" : "c",
"c" : "d",
"d" : "e",
"e" : "f",
"f" : "g",
"g" : "h",
"h" : "i",
"i" : "j",
"j" : "k",
"k" : "l",
"l" : "m",
"m" : "n",
"n" : "o",
"o" : "p",
"p" : "q",
"q" : "r",
"r" : "s",
"s" : "t",
"t" : "u",
"u" : "v",
"v" : "w",
"w" : "x",
"x" : "y",
"y" : "z",
"z" : "a"
]
var encodedMsg = "uijt nfttbhf jt ibse up sfbe"
var decodedMsg = encodedMsg.map({ ch in
    code.first(where: {String(ch) == $0.value})?.key ?? " "
}).joined()

print("Decoded msg:", decodedMsg)

// You are given an array of dictionaries. Each dictionary in the array contains exactly 2 keys “firstName” and “lastName”. Create an array of strings called firstNames that contains only the values for “firstName” from each dictionary.

var people: [[String:String]] = [
    [
        "firstName": "Calvin",
        "lastName": "Newton"
    ],
    [
        "firstName": "Garry",
        "lastName": "Mckenzie"
    ],
    [
        "firstName": "Leah",
        "lastName": "Rivera"
    ],
    [
        "firstName": "Sonja",
        "lastName": "Moreno"
    ],
    [
        "firstName": "Noel",
        "lastName": "Bowen"
    ]
]
let firstName: [String] = people.map { $0["firstName"]! }
print(firstName)


// You are given an array of dictionaries. Each dictionary in the array contains exactly 2 keys “firstName” and “lastName”. Create an array of strings called fullNames that contains the values for “firstName” and “lastName” from the dictionary separated by a space.

let fullName2 = people.map { p in
    p["firstName"]! + " " + p["lastName"]!
}
print(fullName2)

// You are given an array of dictionaries. Each dictionary in the array describes the score of a person. Find the person with the lowest score and print his full name.
var people2: [[String:Any]] = [
    
    [
        "firstName": "Calvin",
        "lastName": "Newton",
        "score": 13
    ],
    [
        "firstName": "Garry",
        "lastName": "Mckenzie",
        "score": 12
    ],
    [
        "firstName": "Leah",
        "lastName": "Rivera",
        "score": 10
    ],
    [
        "firstName": "Sonja",
        "lastName": "Moreno",
        "score": 3
    ],
    [
        "firstName": "Noel",
        "lastName": "Bowen",
        "score": 16
    ]
]

let fName = people2.min { p1, p2 in
    (p1["score"] as! Int) < (p2["score"] as! Int)
}!
print("\(fName["firstName"]!) \(fName["lastName"]!)")

// You are given an array of dictionaries. Each dictionary in the array describes the score of a person. Print the leaderboard in the following format:

people2.enumerated().forEach { i, p in
    print("\(i + 1). \(p["firstName"]!) \(p["lastName"]!) - \(p["score"]!)")
}

// You are given an array of integers. Find out the frequency of each one.The frequency of a number is the number of times it appears in the array.Print the numbers in ascending order followed by their frequency.
var numbers = [1, 2, 3, 2, 3, 5, 2, 1, 3, 4, 2, 2, 2]
var freq: [Int: Int] = [:]
numbers.forEach { n in
    if let f = freq[n] {
        freq[n] = f + 1
    } else {
        freq[n] = 1
    }
}

freq.sorted() {
    $0.key < $1.key
}.forEach {
    print("\($0) \($1)")
}


/**
 Optionals
 */

// Create an example of demonstrating How to declare optionals in swift
var opNum: Int?

// What is force unwrapping in optionals show usage in example.

// print(opNum!) Fatal error: Unexpectedly found nil while unwrapping an Optional value
opNum = 7
print(opNum)

// Create one example of show usage of optional binding
if var opNum {
    opNum = 10
    print(opNum)
}
print(opNum)

var opNum2: Int?
if let opNum, let opNum2 {
    print(opNum + opNum2)
} else if let opNum {
    print(opNum)
} else {
    print("No number exist!")
}

opNum2 = 3
while let num = opNum2 {
    opNum2 = num + 1
    print(num)
    if(num > 5) {
        opNum2 = nil
    }
}

// Create one example using guard-let

func sum(_ num1: Int? = nil, _ num2: Int? = nil) {
    guard let num1 = num1 else {
        print("Num1 is nil") // error: 'guard' body must not fall through, consider using a 'return' or 'throw' to exit the scope
        return
    }

    guard let num2 else {
        print("Num2 is nil")
        return
    }

    print("\(num1) + \(num2) = \(num1+num2)")
}

sum(5, 10)


// Create one example using nil colloison operator
var nilName: String?
print(nilName ?? "unknown")
