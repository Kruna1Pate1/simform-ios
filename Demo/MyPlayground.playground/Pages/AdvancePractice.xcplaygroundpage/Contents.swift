import Foundation

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
        // Normal way to use setter
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
        print("Initialized", String(describing: self))
    }
 
    deinit {
        print("Deinitialized", String(describing: self))
    }
}

let demo = Demo()

struct DemoS {
    let name: String
    
    init() {
        name = "Hello"
        print("Initializing", String(describing: self))
    }
    
    init(_ name: String? = nil) {
        self.name = name ?? "nil"
        print("Initializing", String(describing: self))
    }
    
    init(fname: String, lname: String) {
        let name = fname + " " + lname
        self.init(name)
        print("Initializing", String(describing: self))
    }
}
let demoS1 = DemoS()
let demoS2 = DemoS("Krunal")
let demoS3 = DemoS(nil)
let demoS4 = DemoS(fname: "Nobita", lname: "Nobi")

// Convenience & Designated intializers

class ConvenienceAndDesignated {
    let name: String
    
    init(_ name: String? = nil) {
        self.name = name ?? "nil"
        print("Initializing", #function)
    }
    
    convenience init() {
        let name = "Hello"
//        print("Initializing", String(describing: self)) error: 'self' used before 'self.init' call or assignment to 'self'
        self.init(fname: name, lname: "")
        print("Initializing", #function)
    }
    
    convenience init(fname: String, lname: String) {
        let name = fname + " " + lname
        self.init(name)
        print("Initializing", #function)
    }
}

let demoCAD1 = ConvenienceAndDesignated()
let demoCAD2 = ConvenienceAndDesignated("Krunal")
let demoCAD3 = ConvenienceAndDesignated(nil)
let demoCAD4 = ConvenienceAndDesignated(fname: "Nobita", lname: "Nobi")


// Failable init
class Positive {
    var num: Int
    
    init?(num: Int) {
        if(num < 0) { return nil }
        self.num = num
    }
}

print(Positive(num: 5))
print(Positive(num: -5))

enum WeekDay {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    
    init?(day: Int) {
        switch (day % 7) {
        case 0:
            self = .sunday
        case 1:
            self = .monday
        case 2:
            self = .tuesday
        case 3:
            self = .wednesday
        case 4:
            self = .thursday
        case 5:
            self = .friday
        case 6:
            self = .saturday
        default:
            return nil
        }
    }
}

print(WeekDay(day: 5))
print(WeekDay(day: -5))


/**
 Replace dictionary keys to values without iterating
 */
var d = ["krunal": "pass", "h": "fail"]
d = Dictionary(uniqueKeysWithValues: zip(d.values, d.keys))
print(d)
//d = NSDictionary(objects: d.values, forKeys: d.keys)
//print(d)

/**
 Optional chaining
 */

class OptionalChaining {
    var colors: [String]? = ["white", "black", "pink", "red", "green"]
    
    init?(_ color: String) {
        guard var colors else {
            return nil
        }
        
        if colors.contains(color) { return nil }
        colors.append(color) // does not change self.colors
    }
}

print(OptionalChaining("white")?.colors?.contains("black"))
print(OptionalChaining("orange")?.colors?.contains("orange"))


/**
 Inheritance
 */

class Animal {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func speak() {
        print("Hello")
    }
    
//    func canKeepHome() -> Bool {
//        return self is Domanstic
//    }
    final var canKeepHome: Bool {
        self is Domanstic
    }
}

protocol Domanstic {
}

class Dog: Animal, Domanstic {
    
    var protcting = false
    
    override init(name: String) {
        super.init(name: name)
    }
    
    convenience init() {
        self.init(name: "Dog")
    }
    
    override func speak() {
        print("bark")
    }
    
    func protact() {
        print("guard mode on")
        protcting = true
    }
    
    func sleep() {
        print("sleeping...")
        protcting = false
    }
}


class Lion : Animal {
    
    override func speak() {
        print("roar")
    }
}

var animal: Animal = Dog()
animal.speak()
print(animal.canKeepHome)

animal = Lion(name: "King")
animal.speak()
print(animal.canKeepHome)


/**
 Nested type
 */

class Wizard2 {
    var details: Details
    var knownSpells: [String] = []
    
    init(name: Details.Name, spells: String...) {
        self.details = Details(name: name, house: Details.House.allCases.randomElement() ?? Details.House.Gryffinder)
    }
    
    struct Details {
        var name: Name
        var house: House
        
        struct Name {
            var fName: String
            var mName: String?
            var lName: String
        }
        
        enum House: CaseIterable {
            case Gryffinder, Ravenclaw, Hufflepuff, Slytherin
        }
    }
}

let wizard = Wizard2(name: Wizard2.Details.Name(fName: "Harry", lName: "Potter"), spells: "Expecto patronum", "Crucio", "Lumos charm", "Nox")
print(wizard)

/**
 Error handling
 */
print("\n\n")

enum LoginError: Error {
    case invalidUsername
    case invalidPassword(attemptLeft: Int)
    case rateLimitReached(secretKey: Int)
    case invalidSecretKey
}

enum ServerError: Int, Error {
    case notFound = 404
    case unreachable = 501
}

class Login {
    private let maxAttempts = 3
    var attempts = 0
    var attemptLeft: Int {
        maxAttempts - attempts
    }
    private let credantials = Credentials()
    
    func login(username user: String, password pass: String) throws -> UUID {
        if attemptLeft == 0 {
            throw LoginError.rateLimitReached(secretKey: credantials.secretKey)
        } else if user != credantials.username {
            attempts += 1
            throw LoginError.invalidUsername
        } else if pass != credantials.pass {
            attempts += 1
            throw LoginError.invalidPassword(attemptLeft: attemptLeft)
        } else {
            print("Login successfull")
            return UUID()
        }
    }
    
    func resetAttempts(secretKey: Int) throws {
        if secretKey != credantials.secretKey {
            throw LoginError.invalidSecretKey
        }
        attempts = 0
    }
    
    private struct Credentials {
        let username: String = "Kruna1Pate1"
        let pass: String = "P455"
        var secretKey: Int
        
        init() {
            self.secretKey = Int.random(in: 1000...9999)
        }
    }
}

let repo = Login()
print("attempts left: ", repo.attemptLeft)


login: while true {
    defer {
        print("Cleaning up...\n")
    }
    do {
        print("Login with wrong cred...")
        try repo.login(username: "Kruna1Pate1", password: "P4SS")
        break login
    } catch LoginError.invalidUsername {
        print("Invalid username")
    } catch LoginError.invalidPassword(let attemptLef) {
        print("Invalid password, \(attemptLef) attempts left")
    } catch LoginError.rateLimitReached(let secretKey) {
        print("rate limit reached, reseting using \(secretKey)")
        
        do {
            try repo.resetAttempts(secretKey: secretKey)
            print("reset success")
            let uuid = try repo.login(username: "Kruna1Pate1", password: "P455")
            print("session id:", uuid)
            break login
        } catch LoginError.invalidSecretKey where repo.attemptLeft <= 0 {
            print("Invalid key")
        }
    } catch is ServerError {
        print("Server error")
    }  catch {
        print("Unexpected error: \(error).")
    }
    do {
        print("Cleaning up 2...\n")
    }
}

// Converting Errors to Optional Values
var uuid = try? repo.login(username: "KrunalPatel", password: "P455")
if var uuid {
    print("Your uuid is:", uuid)
} else {
    
    // Disabling Error Propagation
    let uuid = try! repo.login(username: "Kruna1Pate1", password: "P455")
    print("Your uuid is:", uuid)
}

/**
 Type casting and Checking
 */
class LivingObject {
//    final init() { error: 'final' modifier cannot be applied to this declaration
    init() {
        print("Living Object")
    }
}

class Human: LivingObject {
    override init() {
        print("Human")
    }
}

class NonLivingObject {
    init() {
        print("NonLivingObject")
    }
}

var human = Human()
var stale = NonLivingObject()
print("human is LivingObject:", human is LivingObject)
print("human is NonLivingObject:", human is NonLivingObject)
print("stale is Human:", stale is Human)
print(stale as? Human)
print(human as LivingObject) // can upcast without ? or !
print(human as? NonLivingObject)
//do {
//    try human as? NonLivingObject
//    try [1, 2][3]
//} catch {
//    print("Catch")
//}
//print("Out")
// error("this is compile time error")

/**
 Protocols
 */

protocol Concat {
    var freq: Int { get }
    func concat(_ e: String...) -> String
    
    init(freq: Int)
}

class SpaceConcat: Concat {
    var freq: Int
    
    func concat(_ e: String...) -> String {
        let space = String(repeating: " ", count: freq)
        return e.reduce("", {r, e in r + space + e})
    }
    
    required init(freq: Int) {
        self.freq = freq
    }
    
}
let sc = SpaceConcat(freq: 2)
print(sc.concat("a", "b", "c", "d"))

protocol LargeOnly {
    var minLen: Int { get set }
    
    mutating func halfLen()
    func isAccepted(_ str: String) -> Bool
}

struct LargeString: LargeOnly {
    var minLen: Int
    
    mutating func halfLen() {
        minLen /= 2
    }
    
    func isAccepted(_ str: String) -> Bool {
        str.count >= minLen
    }
}

let ls = LargeString(minLen: 3)
print("ab accepted:", ls.isAccepted("ab"))
print("abc accepted:", ls.isAccepted("abc"))

class CommaConcat: SpaceConcat, LargeOnly {
    var minLen: Int = 6
    
    func halfLen() {
        minLen /= 2
    }
    
    func isAccepted(_ str: String) -> Bool {
        str.count >= minLen
    }
    
    override func concat(_ e: String...) -> String {
        if !isAccepted(e.joined()) { return "xD" }
        let comma = String(repeating: ",", count: freq)
        return e.reduce("", { $0 + comma + $1})
    }
    
    required init(freq: Int) { //'override' is implied when overriding a required initializer
        super.init(freq: freq)
    }
    
    convenience init() {
        self.init(minLen: 3)
    }
    
    convenience init(minLen: Int) {
        self.init(freq: minLen)
        self.minLen = minLen
    }
}

let cc = CommaConcat(freq: 4)
print(cc.concat("a", "b", "c", "d"))
cc.halfLen()
print(cc.concat("a", "b", "c", "d"))

// Protocol as type

let concator = { (concat: Concat, e: String...) in
//    concat.concat(e) error: Cannot pass array of type 'String...' as variadic arguments of type 'String'
    concat.concat("1", "2", "3", "4")
}

print(concator(CommaConcat(), "1", "2", "3", "4"))


/**
 Extension
 */

protocol Calculate {
    func calculate(a: Int, b: Int, cal: (Int, Int) -> Int) -> Int
}

class Calculator : Calculate {
    
    func calculate(a: Int, b: Int, cal: (Int, Int) -> Int) -> Int {
        cal(a, b)
    }
    
    func add(a: Int, b: Int) -> Int {
        a + b
    }
    
    enum Symbol: Character {
        case add = "+"
    }
}

protocol CompleteCalculate {
    func add(a: Int, b: Int) -> Int
    func sub(a: Int, b: Int) -> Int
}

extension Calculator: CompleteCalculate {
    func sub(a: Int, b: Int) -> Int {
        a - b
    }
    
//    override func add(a: Int, b: Int) { Error: Invalid redeclaration of 'add(a:b:)'
//        a % b
//    }
    
    enum AllSymbol: String {
        case add = "+"
        case sub = "-"
        case mul = "*"
        case div = "\\"
    }
}

extension CompleteCalculate {
    func mul(a: Int, b: Int) -> Int {
        a * b
    }
    
    func div(a: Int, b: Int) -> Int {
        a / b
    }
}

let cal = Calculator()
print("a % b:", cal.calculate(a: 15, b: 2, cal: {a, b in a % b}))
print("a + b:", cal.add(a: 5, b: 5))
print("a / b:", cal.div(a: 10, b: 5))


/**
 Optional chaining with nil-coalescing
 */

class Chaining {
    var str: Str? = Str()
    
    init?(_ flag: Bool) {
        if !flag { return nil }
    }
    
    struct Str {
        var arr: [Int]? = [1, 2, 3]
    }
    
}
print(Chaining(false)?.str?.arr?.last ?? 1)
let chain = Chaining(false)
print((Chaining(false) ?? chain)?.str?.arr?.last ?? "hi")
//let v = ((Chaining(false) ?? chain)?.str?.arr?.last ?? "hi")


/**
 Strong, weak & unowned  refrence
 */

// Strong refrence

func refrenceCount(_ obj: AnyObject?) {
    guard let obj else {
        print("it's nil")
        return
    }

    let objName = String(describing: obj)
    let name = objName[(objName.index(after: objName.lastIndex(of: ".") ?? objName.startIndex))...]
    print("[\(name)] -> current count:", CFGetRetainCount(obj))
}

class A {
    let aStr = "A class"
    
    init() {
        print("A init")
    }
    
    deinit {
        print("A deinit")
    }
}


var a1: A? = A()
var b1 = a1
a1 = nil
print("a set to nil")
//refrenceCount(b1)
b1 = nil
print("b set to nil")


// Weak refrence
class WeakA {
    weak var a: A?
    
    init(a: A?) {
        self.a = a
    }
}

var a3: A? = A()
var weakA = WeakA(a: a3)
print("[WeakA]: weakA", String(describing: weakA.a))
a3 = nil
print("a3 set to nil")
print("[WeakA]: weakA", String(describing: weakA.a))


// Unowned refrence
class UnownedA {
    unowned var a: A
    
    init(a: A) {
        self.a = a
    }
}


var a4: A? = A()
var ua = UnownedA(a: a4!)
print("[WeakA]: weakA", String(describing: ua.a))
a4 = nil
print("a4 set to nil")
// Fatal error: Attempted to read an unowned reference but object 0x600000384600 was already deallocated
//print("[WeakA]: weakA", String(describing: ua.a))


/**
 Reference cycle
 */

class CycleA {
    var b: CycleB?
    
    init() {
        print("CycleA init")
    }
    
    func set(b: CycleB?) {
        self.b = b
    }
    
    deinit {
        print("CycleA deinit")
    }
}

class CycleB {
    var a: CycleA?
    
    init() {
        print("CycleB init")
    }
    
    func set(a: CycleA?) {
        self.a = a
    }
    
    deinit {
        print("CycleB deinit")
    }
}

var ca1: CycleA? = CycleA()
var cb1: CycleB? = CycleB()

ca1?.set(b: cb1)
cb1?.set(a: ca1)
cb1 = nil
ca1 = nil


// Breaking strong reference cycle with weak/unowned
class CycleA2 {
    weak var b: CycleB2?
    // unowned can be used instead of weak when we are sure it wont be nil.
//    unowned var b: CycleB2?
    
    init() {
        print("CycleA2 init")
    }
    
    func set(b: CycleB2?) {
        self.b = b
    }
    
    deinit {
        print("CycleA2 deinit")
    }
}

class CycleB2 {
    var a: CycleA2?
    
    init() {
        print("CycleB2 init")
    }
    
    func set(a: CycleA2?) {
        self.a = a
    }
    
    deinit {
        print("CycleB2 deinit")
    }
}

var ca2: CycleA2? = CycleA2()
// ca1 = nil
var cb2: CycleB2? = CycleB2()

ca2?.set(b: cb2)
cb2?.set(a: ca2)
cb2 = nil
ca2 = nil


/**
 Protocol & Delegate
 */

// Optional Protocol Requirements
@objc
protocol OptionalProtocol {
    func compReq1 () -> Void
    @objc optional func optReq () -> ()
}

class OPClass: OptionalProtocol {
    func compReq1() {
        print("Comp 1")
    }
}

let opClass: OptionalProtocol = OPClass()
opClass.compReq1()
(opClass.optReq ?? { print("Not available") })()
opClass.optReq?()

protocol OptionalProtocol2 {
    func compReq1 () -> Void
    func optReq () -> ()
    
    init(str: String)
}

class OPClass2: OptionalProtocol2 {
    func compReq1() {
        print("Comp 1")
    }
}

extension OptionalProtocol2 {
    func optReq() {
        print("Opt 2")
    }
    
    init(str: String) {
        print(str)
        self.init(str: str)
    }
}

let opClass2: OptionalProtocol2 = OPClass2()
opClass2.compReq1()
opClass2.optReq()


// Protocol on enum

//@objc
protocol Iterable {
    mutating func next() -> NewSignal
//    @objc optional func prev() -> NewSignal
}

enum NewSignal: Int, Iterable {
    case green, yellow, red
    
    mutating func next() -> NewSignal {
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
var signal2 = Signal(rawValue: "green")
print(signal2?.rawValue ?? "unknown")
print(signal2?.next().rawValue ?? "unknown")
print(signal2?.next().rawValue ?? "unknown")
print(signal2?.next().rawValue ?? "unknown")

// Protocol Composition
protocol Fname {
    var fname: String { get set }
}

protocol Lname: AnyObject {
    var lname: String { get }
}

let printFull = { (str: Fname & Lname) in
    print(str.fname + " " + str.lname)
}

//Non-class type 'FullNameStruct' cannot conform to class protocol 'Lname'
//struct FullNameStruct: Fname, Lname {}

class FullNameClass: Fname, Lname {
    var fname: String = "Hello"
    
    var lname: String = "World"
    
    
}
printFull(FullNameClass())


// Protocol delegate
class MediaPlayer {
    var volume = 0
    var volumeStr: String {
        String(volume) + " \u{1F50A}"
    }
    
    var brightness = 0
    var brightnessStr: String {
        String(brightness) + " \u{1F506}"
    }
    
    let bound = Point(x: 1000, y: 1000)
    var delegate: TouchGestureDelegate?
    
    func swap(start: Point, end: Point) {
        if start.x > (bound.x / 2) {
            delegate?.didRightScreenSwap(player: self, distance: -(end.y - start.y))
        } else {
            delegate?.didLeftScreenSwap(player: self, distance: -(end.y - start.y))
        }
    }
    
    struct Point {
        var x = 0
        var y = 0
    }
}

protocol TouchGestureDelegate {
    func didLeftScreenSwap(player: MediaPlayer, distance: Int)
    func didRightScreenSwap(player: MediaPlayer, distance: Int)
}

class GestureController: TouchGestureDelegate {
    func didLeftScreenSwap(player: MediaPlayer, distance: Int) {
        if distance > 0 {
            print("Increasing brightness...")
        } else {
            print("Decreasing brightness...")
        }
        player.brightness += distance
        print(player.brightnessStr)
    }
    
    func didRightScreenSwap(player: MediaPlayer, distance: Int) {
        if distance > 0 {
            print("Increasing volume...")
        } else {
            print("Decreasing volume...")
        }
        player.volume += distance
        print(player.volumeStr)
    }
}

let player = MediaPlayer()
player.delegate = GestureController()
player.swap(start: MediaPlayer.Point(x: 40, y: 400), end: MediaPlayer.Point(x: 40, y: 100))
player.swap(start: MediaPlayer.Point(x: 800, y: 900), end: MediaPlayer.Point(x: 800, y: 100))
player.swap(start: MediaPlayer.Point(x: 400, y: 800), end: MediaPlayer.Point(x: 400, y: 1000))
player.swap(start: MediaPlayer.Point(x: 800, y: 900), end: MediaPlayer.Point(x: 800, y: 100))
