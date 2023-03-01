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
if let house = wiz.house {
    print("house:", house, house.rawValue)
} else {
    print("no house")
}



// Identity Operator
let wiz2 = wiz
print(wiz === wiz2)


/**
 Higher Order Function
 */

var numArr = [10, 23, 9, -6, 0, 23, 7]

// Sort
var aNumArr = numArr.sorted(by: < )
print("ascending:", aNumArr)
var dNumArr = numArr.sorted { $0 > $1 }
print("descending:", dNumArr)

// For-each
numArr.forEach { n in
    print(n%2 == 0 ? "even" : "odd", terminator: ", ")
}
print()

let printer = { e in
    print(e, terminator: ", ")
}
numArr.forEach(printer)
print()

// Filter
var oddArr = numArr.filter { $0%2 != 0 }
print("odd:", oddArr)

// Map
func toString(_ e: Int) -> String {
    String(e)
}
let strNumArr = numArr.map(toString)
print("string num:", strNumArr)

// Compact map
let mixArr: [Any?] = ["1", 2, true, "Hello", 5, 1, 2, nil, 4, 7]
let iArr = mixArr.compactMap { $0 as? Int }
print(iArr)

// Flat map
let tdArr = [
    [2, 4, 6, 8],
    [1, 3, 5, 7]
]
let newTdArr = tdArr.flatMap { arr in
    arr.filter { $0 > 3 }
}
print(newTdArr)

// Reduce
let total = strNumArr.reduce(0, { (res, e) in
    res + (Int(e) ?? 0)
})
print("total:", total)


// Chain
mixArr
    .compactMap { $0 as? Int }
    .filter { $0%2 == 0}
    .map { $0 * 10}
    .forEach(printer)
print()


/**
 Properties
 */

// Stored properties

struct Book1 {
    let name: String
    var genre: [Genre] = []
    var author: String?
}

var book1 = Book1(name: "Harry Potter and the philosopher's stone", genre: [.fiction, .fantasy])

let book2 = book1
//book2.genre.append(.thriller) error: cannot use mutating member on immutable value

book1.author = "J. K. Rowling"

print(book1)
print(book2)


// Lazy properties
struct Book2 {
    let name: String
    var genre: [Genre] = []
    var author: String?
    lazy var rating: Int = {
        print("rating initialized")
        return 0
    }()
}

var book21 = Book2(name: book1.name)
print(book21.name)
book21.rating

// Calculated properties
struct Book3 {
    let name: String
    var genre: [Genre] = []
    var author: String?
    var rating: Int = 0
    var read: Int {
        get {
            return rating + 1
        }
//        set(val) {
//            rating = val * 10
//        }
        set {
            rating = newValue * 10
        }
    }
}

var book31 = Book3(name: book1.name)
print(book31.read)
book31.read = 5
print(book31.read)

// Read-Only Computed Properties
struct Book4 {
    let name: String
    var length: Int {
        name.count
    }
}
var book41 = Book4(name: "123456")
print(book41.length)
//book41.length = 10 error: cannot assign to property: 'length' is a get-only property


class Book5 {
    var name: String = "" {
        willSet {
            print("[willSet] newValue:", newValue)
        }
        didSet {
            print("[didSet] oldValue:", oldValue)
        }
    }
}
let book51 = Book5()
book51.name = book1.name
print(book51)

func change(_ e: inout String) {
    e = "Changed value"
}
change(&book51.name)


/**
 Propertt wrapper
 */

@propertyWrapper
struct EvenOnly {
    private var num = 0
    var wrappedValue: Int {
        get { num }
        set {
            if(newValue%2 != 0) {
                print("can't use odd numbers")
                return
            }
            num = newValue
        }
    }
}

class Lift {
    @EvenOnly var floors: Int
}

let lift = Lift()
lift.floors = 6
lift.floors = 5
print(lift.floors)

/**
@propertyWrapper
class PathFilter {
    private let illigleChars: Set<Character> = ["\\", "/", ":", "*", "?", "\"", "<", ">", "|"]
    private var name: String
    
    var wrappedValue: String {
        get { return name }
        set {
            newValue.forEach {
                if illigleChars.contains($0) {
                    print("invalid file name!")
                    return
                }
            }
            name = newValue
        }
    }
    
    init() {
        name = ""
    }
    
    init(wrappedValue: String) {
        wrappedValue.forEach { //'self' captured by a closure before all members were initialized
            if illigleChars.contains($0) {
                print("invalid file name!")
                return
            }
        }
        name = wrappedValue
    }
}

struct FileProvider {
    @PathFilter var name: String = ""
}
var fp = FileProvider(name: "hello")
print(fp.name)
*/

class Counter {
    var count: Int
    
    init() {
        count = 0
    }
    
    init(initial: Int) {
        count = initial
    }
    
    func inc(by: Int = 1) {
        count += by
    }
    
    func dec(by: Int = 1) {
        count -= by
    }
}

let counter = Counter(initial: 5)
counter.inc()
counter.dec(by: 3)
print(counter.count)


/**
 Mutating
 */

struct Counter2 {
    var count = 0
    
    mutating func inc(by: Int = 1) {
        count += by
    }
    
    mutating func dec(by: Int = 1) {
        count -= by
    }
    
    mutating func reset() {
        self = Counter2()
    }
}

var counter2 = Counter2()
counter2.inc(by: 50)
print(counter2.count)
counter2.reset()
print(counter2.count)

enum Signal: String {
    case green, yellow, red
    
    mutating func next() -> Signal {
        switch self {
        case .green:
            self = .yellow
        case .yellow:
            self = .red
        case .red:
            self = .green
        }
        return self
    }
}
var signal = Signal(rawValue: "green")
print(signal?.rawValue ?? "unknown")
print(signal?.next().rawValue ?? "unknown")
print(signal?.next().rawValue ?? "unknown")
print(signal?.next().rawValue ?? "unknown")

// Type method
class Formatter {
    static var seprator: String = " "
    class func format(_ e: String...) -> String {
        e.joined(separator: seprator)
    }
}
print(Formatter.format("Hello", "World", "!", "!"))

struct FormatterS {
    static func format(_ e: String...) -> String {
        e.joined(separator: " ")
    }
}
print(FormatterS.format("Hello", "World", "!", "!"))


/**
 Subscripts
 */

struct Table {
    var multiplier: Int
    
    subscript(index: Int) -> Int {
        multiplier * index
    }
}
let table = Table(multiplier: 5)
print(table[10])

struct MyDictionary<T: Hashable, V> {
    var d: [T: V] = [:]
    
    subscript(index: T) -> V? {
        get {
            d[index]
        }
        set {
            d[index] = newValue
        }
    }
}

var md = MyDictionary<String, String>()
md["krunal"] = "Welcome"
md["test"] = "Not"

print(md["test"] ?? "unknown")


/**
 Initialization & Deinitialization
 */

class Demo {
    var name = "Name"
 
    init() {
        print("Initialized")
    }
 
    deinit {
        print("Deinitialized")
    }
}

let demo = Demo()
