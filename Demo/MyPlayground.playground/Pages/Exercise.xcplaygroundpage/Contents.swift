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

