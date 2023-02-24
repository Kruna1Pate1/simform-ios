// Practice

/**
 Variable & Constants
*/
var name = "Krunal"
let empId = 7
// empId = 8    error: cannot assign to value: 'empId' is a 'let' constant

var lastName: String
//print(lastName)   error: variable 'lastName' used before being initialized

let 🐶🐮 = "dogcow"

let softWrap = """
Dumbledore said “After all this time,\
 Severus?”

Snape replied "Always ...\"
"""

/**
 Print
 */
print(softWrap)
print("Hello", terminator: "  ")
print("World", "!", separator: "...", terminator: "xD \n")


/**
 Special Characters in String Literals
 */
print("Snape replied \"Always ...\" \u{1F97A}")
print(#"Snape replied \"Always ...\" \u{1F97A}"#)


/**
 Integer bound
 */
var minValue = UInt8.min  // minValue is equal to 0, and is of type UInt8
let maxValue = UInt8.max  // maxValue is equal to 255, and is of type UInt8
print("min: \(minValue)", "max: \(maxValue)", separator: "  ")
//minValue = 256    error: integer literal '256' overflows when stored into 'UInt8'


/**
 Number literal
 */
let decimalInt = 17
let binaryInt = 10001
let octalInt = 0o21
let hexInt = 0x11


/**
 Type aliases
 */
typealias Name = (String, String)

var fullName: Name  = ("Krunal", "Patel")
print(fullName.0)


/**
 Boolean
 */

var flag: Bool = true
if !flag {
    print("In")
} else {
    print("Out")
}


/**
 Tuple
 */

let status = (code: 404, "Not Found", "not required", true)
let (code, msg, _, _) = status
print(status.code, msg)


/**
 Optional
 */
var midName: String?
print(midName)
print(midName ?? "It's nil")
//print(midName!)   Fatal error: Unexpectedly found nil while unwrapping an Optional value

midName = "Not blank"
if midName != nil {
    // Forced unwrapping
    print(midName!)
}


/**
 Optional Binding
 */

if let midNameNotNil = midName {
    print(midName, midNameNotNil)
} else {
    print("nil value")
}

if let midName {
//    midName = "Changed"
    print(midName)
}

if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100 {
    print("\(firstNumber) < \(secondNumber) < 100")
}


/**
 Array
 */
let emptyArr: [Int] = []
let arr: Any? = ["a", "b", 3, false]
var rArr = Array(repeating: 0, count: 10)
rArr[rArr.count - 1] = 3
print(emptyArr + rArr)

/**
 Dictionary
 */
let emptyDir: [String: Int] = [:]
let dic = [
    "First": [10, 8, 5, 20],
    "Secound": [5, 25, 19, 5]
]
print(dic["Secound"])


/**
Sets
 */
var s = Set<Character>()
s.insert("A")
s.insert("B")
s.remove("B")
s.insert("C")
s.removeFirst()
print(s)


/**
 Loops
 */
for i in 1...10 {
    print(i)
}

for (key, numArr) in dic {
    for n in numArr {
        print(key, n, separator: " -> ")
    }
}

for (index, e) in rArr.enumerated() {
    print("\(index): \(e)")
}

var count = 0
while true {
    count += 1
    if count == 10 {
        break
    }
}
print("count: \(count)")

repeat {
    print("In repeat")
} while false


/**
 Conditional Statements
 */
if "a" == String("a") {
    print("Both are same")
} else if false {
    print("Unrechable")
} else {
    print("At the end")
}

let value: Int = 5

switch value {
case nil, ..<0:
    print("Value is nil")
case 1...5:
    print("In range of 1...5")
default:
    print("In default")
}

let point = (2, 0)
switch point {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}


/**
 String Indices & Sub String
 */
var str = "abcdefgh"
print(str[str.startIndex])
print(str[str.index(before: str.endIndex)])
let index = str.index(str.startIndex, offsetBy: 3)
print(str[index])

for i in str.indices {
    if(i >= str.index(str.startIndex, offsetBy: 3)) {
        break
    }
    print(str[i], terminator: "")
}
str.insert("i", at: str.endIndex)
str.insert(contentsOf: "jklm", at: str.endIndex)
str.removeFirst(2)
print(str)

