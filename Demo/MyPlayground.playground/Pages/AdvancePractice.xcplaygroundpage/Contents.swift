// Advance Practice


/**
 Functions
 */

// Without parameters and return value
func greeting() {
    print("Welcome!!")
}
greeting()

// With parameters and return value
func sum(_ n1: Int, _ n2: Int) -> Int {
    return n1 + n2
}

print("5 + 5 =", sum(5, 5))

// With parameters and without return value
func greeting(_ name: String? = nil) {
    print("Welcome \(name ?? "unknown")!")
}

greeting("Krunal")
greeting(nil)
greeting() // Executes ln:9

// Without parameters and with return value
func getVersion() -> String {
    return "Swift 5.7.2"
}

// Implicit return
func getVersion2() -> String {
    "Swift 5.7.2"
}

print("Current version:", getVersion2())

// Default Parameter Values
func defaultP(_ str: String = "empty") {
    print(str)
}
defaultP()

// Find boundary
func findBoundary(arr: [Int]) -> (large: Int, small: Int) {
    return (
        arr.max() ?? 0,
        arr.min() ?? 0
    )
}
let (max, min) = findBoundary(arr: [4, 2, 9, 20, 15, -5])
print("min: \(min), max: \(max)")


// Optional return
func getVersion(v version: String?) -> String? {
    guard let version else {
        return nil
    }
    return "Swift \(version)"
}

print("Current version:", getVersion(v: nil) ?? "unknown")


// Parameter scope
var num = 5
func change(num: Int) {
    //    num = 100 // Arguments are constant
    let num = 100
    print("inside num:", num)
}

change(num: num)
print("outside num:", num)


// External Parameter Names
func swapNew(num1 n1: Int, n2: Int) -> (num1: Int, num2: Int) {
    return (n2, n1)
}
var a = 5
var b = 7
print("before a: \(a), b: \(b)")
(a, b) = swapNew(num1: a, n2: b)
print("after a: \(a), b: \(b)")


// Variadic Parameters
func vari<N>(e: N...) {
    e.forEach { print($0) }
}
vari(e: "a", "b", "c")
vari(e: 1.5, 7, 0, -5)
vari(e: true)


// I/O Parameters
func swap<T>(e1: inout T, e2: inout T) {
    let temp = e1
    e1 = e2
    e2 = temp
}

var ele1 = "Hello"
var ele2 = "World"
swap(e1: &ele1, e2: &ele2)
print(ele1, ele2, "!!")
var n1 = 5
//swap(e1: &ele1, e2: &n1) error: cannot convert value of type 'Int' to expected argument type 'String'


// Function Types as Parameter Types
func inc(_ n: inout Int, by: Int = 1) {
    n += by
}

func printByFun(fun: (inout Int, Int) -> Void, num: Int) {
    var n = num
    fun(&n, 10)
    print(n)
}

printByFun(fun: inc, num: 5)


// Nested Functions
func fun1() -> () -> () -> Void {
    let a = "Hello"
    func fun2() -> () -> Void {
        let b = "World"
        func fun3() {
            print(a, b)
        }
        return fun3
    }
    return fun2
}

let f1: () -> () -> Void = fun1()
let f2 = f1()
f2()


/**
 Closures
 */
let welcome = {
    print("Welcome")
}
welcome()

let sumc: (Int, Int) -> Int = { (a, b) -> Int in
    a + b
}
print(sumc(5, 5))

// Optional closure
let mayWelcome: (() -> Void)? = {
    print("Welcome")
}
if let mayWelcome {
    mayWelcome()
}

let backward = { (e1: Int, e2: Int) in
    e1 < e2
}
func backwardFun(_ e1: Int, _ e2: Int) -> Bool {
    e1 > e2
}

var arr = [4, 6, 2, 4, 3, 4, -1]
arr.sort(by: backwardFun)
print(arr)

// Trailing closure
func delete(path: String, onSuccess: () -> String, onComplete: (Bool) -> ()) {
    print(path)
    print(onSuccess())
    onComplete(true)
}
delete(path: "/photo.png", onSuccess: { "Done" }) {
    print("Success:", $0)
}


/**
 Enumeration
 */

enum Genre {
    case action
    case fiction
    case fantasy
    case thriller
    case novel
    case mystry
}

var hp = Genre.fiction
hp = .fantasy

switch hp {
case .action:
    print("action")
case .fiction:
    print("fiction")
case .fantasy:
    print("fantasy")
case .thriller:
    print("thriller")
case .novel:
    print("novel")
case .mystry:
    print("mystry")
}

enum Color : String, CaseIterable {
    case red, blue, pink
}
let red = Color(rawValue: "red")
print(Color.allCases.count)
print(Color.blue.rawValue)
print(red!.rawValue)

let black = Color(rawValue: "black")
if let black {
    print("dark")
} else {
    print("light")
}

for (i, c) in Color.allCases.enumerated() {
    print(i, c)
}

enum Response {
    case Loading
    case Downloading(done: Float, total: Int)
    case Success(body: String)
    case Error(msg: String?)
}

let resp = Response.Downloading(done: 40, total: 100)

switch resp {
case .Loading:
    print("Page is loading...")
case .Downloading(done: let done, total: let total):
    print("[Downloading]: \((done/Float(total))*100)%")
case .Success(body: let body):
    print(body)
case .Error(msg: let msg):
    print("[Error]:", msg ?? "")
}


/**
 Structures and Classes
 */

enum House: String {
    case Gryffinder = "Bravery"
    case Ravenclaw = "Intelligence"
    case Hufflepuff = "Empathy"
    case Slytherin = "Ambition"
}

struct Name {
    var fName: String
    var mName: String?
    var lName: String
}

class Wizard {
    var name = Name(fName: "Harry", lName: "Potter")
    var age = 20
    let school = "Hogwarts"
    var house: House? = nil
}

var wiz = Wizard()
wiz.age = 16
wiz.house = House.Gryffinder

print("name:", wiz.name.fName, wiz.name.lName)
print("age:", wiz.age)
print("school:", wiz.school)
print("house:", wiz.house!, wiz.house!.rawValue)
