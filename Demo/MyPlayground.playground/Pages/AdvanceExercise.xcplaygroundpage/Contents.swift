import Foundation

/**
 The Basics
 */

// 1. Breakfast
class FoodChecker {
    static let egg = 21
    static let bacon = 7
    
    static func check(baconAge: Int, eggsAge: Int) {
        if baconAge <= bacon {
            if eggsAge <= egg {
                print("you can cook bacon and eggs")
            } else {
                print("you can cook bacon and throw out eggs")
            }
        } else {
            print("you can cook eggs and throw out bacon")
        }
    }
}

FoodChecker.check(baconAge: 4, eggsAge: 2)
FoodChecker.check(baconAge: 8, eggsAge: 21)


// 2. Leap Year
func isLeapYear(_ year: Int) -> Bool {
    (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
}

print(isLeapYear(2000) ? "Leap year!" : "Not a leap year!")
print(isLeapYear(1700) ? "Leap year!" : "Not a leap year!")
print(isLeapYear(2023) ? "Leap year!" : "Not a leap year!")


// 3. Hitpoints
class Game {
    func check(hp: Int) {
        switch hp {
        case 0:
            print("dead")
        case 1...20:
            print("hp:", 20)
        case 21..<100:
            print("hp:", hp + (10 - hp % 10))
        case 100:
            print("full health")
        default:
            break
        }
    }
}

let game = Game()
game.check(hp: 0)
game.check(hp: 15)
game.check(hp: 33)
game.check(hp: 100)
game.check(hp: -10)


// 4. Above average
var grade1 = 7.0
var grade2 = 9.0
var grade3 = 5.0
var yourGrade = 8.0
let avg = (grade1 + grade2 + grade3 + yourGrade) / 4
print(yourGrade > avg ? "above average" : "below average")


// 5. Tipping
var mealCost: Double = 3.5
let tip: Int = 20
let tipCost = mealCost * (Double(tip) / 100)
print(mealCost + tipCost)


/**
 Class
 */

// 1) Create a swift program to demonstrate swift class. Which has two variables inside class body. Access (Set its values and get its value.) these variables by creating one instance of class.
class Employee {
    var id = 0
    var name = ""
}

let emp1 = Employee()
emp1.id = 123
emp1.name = "Krunal"
print("id: \(emp1.id), name: \(emp1.name)")


// 2) Create a swift program to demonstrate usage of swift class for usage of multiple initializers. Create one initializer with two parameters your name and college and another initializer with your name and department. You can be able to access these properties using instance of class.
class Student {
    var name: String
    var college: String
    var department: String
    
    init(name: String, college: String) {
        self.name = name
        self.college = college
        self.department = "computer"
    }
    
    init(name: String, department: String) {
        self.name = name
        self.department = department
        self.college = "gtu"
    }
}

let std1 = Student(name: "Krunal", college: "vgec")
let std2 = Student(name: "Harsh", department: "it")
print("name: \(std1.name), college: \(std1.college), department: \(std1.department)")
print("name: \(std2.name), college: \(std2.college), department: \(std2.department)")


// 3) Create a swift class without initializers and access (write, read) its properties using instance of class.
class Company {
    var name: String?
}
let company = Company()
print("name: \(company.name ?? "unknown")")
company.name = "Simform Solutions"
print("name: \(company.name ?? "unknown")")


// 4) Create a swift class which is having code to return square of given number and access this code using class instance.
class SqCal {
    static let square = { (num: Int) in
        num * num
    }
}
print("square of 5 is", SqCal.square(5))


// 5) Create a swift class example to show use of swift inheritance. Your base class has some property access this property. In two different child classes and show its usage using the instances of both child classes.
class Vehicle {
    var speed: Int {
        100
    }
}

class Bike: Vehicle {
    override var speed: Int {
        gear ? 150 : 100
    }
    var gear = true
}

class Car: Vehicle {
    override var speed: Int {
        isSports ? 400 : 250
    }
    var isSports = false
}

var vehicle: Vehicle = Bike()
print("bike speed:", vehicle.speed)

vehicle = Car()
print("car speed:", vehicle.speed)


// 6) Create a swift class example to show use of swift base class which have some implementation inside any method. Now demonstrate usage of overriding that method implementation.
class Animal {
    func speek() -> String {
        "hello"
    }
}
class Dog: Animal {
    override func speek() -> String {
        "bark"
    }
}

let animal = Animal()
print("animal:", animal.speek())

let dog = Dog()
print("dog:", dog.speek())


// 7) Create a swift class with an initializer in a manner that you can create this class using initializing value. And one function which takes int input and returns the power of class instance.
class PowCal {
    let val: Int
    
    func doPower(power: Int) -> Int {
        var res = 1
        for _ in 0..<power {
            res *= val
        }
        return res
    }
    
    init(value val: Int) {
        self.val = val
    }
}
let instance = PowCal(value: 5)
let res = instance.doPower(power: 3)
print("5 pow 3 is", res)


// 8) Create a swift class example which has a parent class for vehicles, and child classes for two different vehicles e.g. (bike & car). You need to use common properties and method in the parent class and inside child class, there will be some different property which is not common.
class Vehicle2 {
    var name: String = ""
    var color: String
    
    init(color: String) {
        self.color = color
    }
    
    convenience init() {
        self.init(color: "white")
    }
    
    func horn() {
        print("low")
    }
}

class Bike2: Vehicle2 {
    var isSports = false
    var speed: Int {
        isSports ? 200 : 150
    }
    var geared = true
    
    override func horn() {
        print("medium")
    }
    
    func stand() {
        print("on stand")
    }
}

class Car2: Vehicle2 {
    var isRacing = true
    var speed: Int {
        isRacing ? 400 : 250
    }
    var geared = true
    
    override func horn() {
        print("loud")
    }
}

var vh = Vehicle2(color: "White")
vh.horn()
vh = Bike2()
vh.horn()
(vh as? Bike2)?.stand()
vh = Car2()
vh.horn()


// 9) Create a person swift class with person name initializer and create one function to greet that person.
class Person {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func greet() {
        print("Hello", name)
    }
}

let person = Person(name: "Krunal")
person.greet()


// 10) Create a swift class with some property. And then set its value using initializer of class, then perform below actions.
class Example {
    var a = ""
}

let example1 = Example()
example1.a = "Hello"
let example2 = example1
example2.a = "Hi"
print(example1.a)
print(example2.a)


/**
 Structure
 */

// 1) Create one structure of type Work, which have some properties like work location, work hours and one string array of project names. And create a function inside structure which returns all project names for the person.

struct Work {
    var location: String
    var hours: Int
    var projectNames = [String]()
    
    func getProjectNames() -> [String] {
        projectNames
    }
}

var work = Work(location: "Ahmedabad", hours: 8)
work.projectNames.append("iHealth application")
work.projectNames.append("Parking management system")
work.projectNames.append("Agriculture project")
print(work.getProjectNames())


// 2) Create a structure example which demonstrates use of initializer in structures.
struct StudentS {
    var name: String
    var college: String
    var department: String
    
    init(name: String, college: String) {
        self.name = name
        self.college = college
        self.department = "computer"
    }
    
    init(name: String, department: String) {
        self.name = name
        self.department = department
        self.college = "gtu"
    }
}

let stds1 = StudentS(name: "Ankur", college: "git")
let stds2 = StudentS(name: "Harshit", department: "ec")
print("name: \(stds1.name), college: \(stds1.college), department: \(stds1.department)")
print("name: \(stds2.name), college: \(stds2.college), department: \(stds2.department)")


// 3) Create a structure program which can be initialized with parameters and it also should be able to initialized without parameters.
struct Name {
    var fname: String
    var mname: String?
    var lname: String?
    
    init() {
        self.fname = "unknown"
    }
    
    init(fname: String) {
        self.fname = fname
    }
}

var name = Name()
print(name.fname, name.mname ?? "", name.lname ?? "")
name = Name(fname: "Harry")
name.lname = "Potter"
print(name.fname, name.mname ?? "", name.lname ?? "")


// 4)    Create one structure which have initializer which takes array of int as input returns  two arrays one of all even numbers and another is all odd numbers.
struct OddEven {
    var odds = [Int]()
    var evens = [Int]()
    
    init(_ nums: [Int]) {
        nums.forEach { n in
            n % 2 == 0 ? evens.append(n) : odds.append(n)
        }
    }
}
let oddEven = OddEven([1, 3, 5, 6, 8, 10, 9, 7, 8, 12])
print("odd numbers:", oddEven.odds)
print("even numbers:", oddEven.evens)


// 5)    Create one swift structure program for person that contains basic details like name, age, gender. Then create one array of person with all details. Print all details of that array.
struct PersonS {
    let name: String
    let gender: String
    let age: Int
}

var persons = [
    PersonS(name: "Harry", gender: "Male", age: 17),
    PersonS(name: "Hermione", gender: "Female", age: 17),
    PersonS(name: "Voldemort", gender: "Male", age: 65)
]

persons.forEach { p in
    print("name: \(p.name), gender: \(p.gender), age: \(p.age)")
}


// 6)    Perform same example given in class question no 10 and check output using structure. Try to find difference between these two outputs and try to figure out the reason for that output.
struct ExampleS {
    var a = ""
}

var examples1 = ExampleS()
examples1.a = "Hello"
var examples2 = examples1
examples2.a = "Hi"
print(examples1.a)
print(examples2.a)


// 7) Try to figure out basic difference between class and structures and give a demo for same.
class BaseA {
    var name: String
    
    init(name: String) {
        print("BaseA init")
        self.name = name
    }
    
    deinit {
        print("BaseA deinit")
    }
}

class ChildB: BaseA {
    
}

struct StA {
    var name: String
}

let childB = ChildB(name: "A")
childB.name = "B"

let stA = StA(name: "A")
//stA.name = "B" Error: Cannot assign to property: 'stA' is a 'let' constant

/**
 Enumerations
 */
// 1)    Write swift program using enumerations to check week day from given number. Consider Monday as 1 and Sunday as 7. We can be able to get day name as string in short form (sun, mon,...) and same full name (Sunday, Monday...) by given number of the day.
enum Weekday: Int {
    case monday = 1
    case tuesday = 2
    case wednesday = 3
    case thursday = 4
    case friday = 5
    case saturday = 6
    case sunday = 7
    
    static func getDayName(_ num: Int) -> String {
        switch Weekday(rawValue: num) {
        case .monday :
            return "Monday or mon"
        case .tuesday :
            return "Tuesday or tue"
        case .wednesday :
            return "Wednesday or wed"
        case .thursday :
            return "Thursday or thu"
        case .friday :
            return "Friday or fri"
        case .saturday :
            return "Saturday or sat"
        case .sunday, .none:
            return "Sunday or sun"
        }
    }
}
print(Weekday.getDayName(5))


// 2)    Create one enumeration program to return number of days in a month.
enum MonthDay: String, CaseIterable {
    case January, February, March, April, May, June, July, August, September, October, November, December
    
    var days: Int {
        switch self {
        case .January, .March, .May, .July, .August, .October, .December:
            return 31
        case .April, .June, .September, .November:
            return 30
        case .February:
            return 28
        }
    }
}

MonthDay.allCases.forEach { month in
    print(month.rawValue, month.days)
}


// 3) Write a swift program using enumerations to demonstrate Int enums.
enum HttpError: Int {
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
}

print("unauthorized:", HttpError.badRequest.rawValue)
print("forbidden", HttpError.forbidden.rawValue)


// 4) Write a swift program to demonstrate string type enum.
enum House: String {
    case Gryffinder = "Bravery"
    case Ravenclaw = "Intelligence"
    case Hufflepuff = "Empathy"
    case Slytherin = "Ambition"
}

print("Gryffinder:", House.Gryffinder.rawValue)
print("Ravenclaw:", House.Ravenclaw.rawValue)
print("Hufflepuff:", House.Hufflepuff.rawValue)
print("Slytherin:", House.Slytherin.rawValue)


// 5) Write a swift program for enum with raw values.
enum Direction: Int {
    case north = 1
    case east
    case south
    case west
}

switch Direction(rawValue: 2) {
case .north:
    print("north")
case .east:
    print("east")
case .south:
    print("south")
case .west:
    print("west")
case .none:
    print("unknown")
}


// 6) Write a swift program using enumerations to get all cases as an array with use of CaseIterable(Optional) and without use of CaseIterable(Mandatory).
enum Weekday2: String, CaseIterable {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
}

Weekday2.allCases.forEach { print($0.rawValue, terminator: ", ")}
print()


// 7) Write a swift program using enumerations for learn and demonsrate enum cases with parameters (Enum with associated values).
enum Status {
    case loading
    case downloading(read: Int, total: Int)
    case success(data: Any?)
    case failed(msg: String?)
}

let status = Status.success(data: "Hello world!")

switch status {
case .loading:
    print("please wailt...")
case .downloading(let read, let total):
    print("downloading:", (read / total) * 100)
case .success(let data):
    print(data ?? "empty")
case .failed(var msg):
    print(msg ?? "unexpected error")
}


// 8) Create an enum with its rawValues of type String and show usage of case to print value of case.
enum Weekday3: String, CaseIterable {
    case monday = "mon"
    case tuesday = "tue"
    case wednesday = "wed"
    case thursday = "thu"
    case friday = "fri"
    case saturday = "sat"
    case sunday = "sun"
}

let monday = Weekday3(rawValue: "mon")
print(monday == .monday ? "monday" : "unknown")


/**
 Properties Subscripts Methods & Inheritance
 */

// 1) Create an example using swift to demonstrate use of get only properties. Create a class with a property which value cannot be set outside of class.
class PersonP {
    private(set) var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func changeName(name: String) {
        if name.count <= 3 {
            print("invalid name")
        } else {
            self.name = name
            print("name changed")
        }
    }
}

let personp = PersonP(name: "Harry")
print("name:", personp.name)
personp.changeName(name: "HP")
print("name:", personp.name)


// 2) Create a swift program to demonstrate usage of computed properties using getter and setter.
struct NameCal {
    var fname: String
    var lname: String
    var fullName: String {
        get {
            fname + " " + lname
        }
        set {
            fname = newValue.components(separatedBy: " ")[0]
            lname = newValue.components(separatedBy: " ")[1]
        }
    }
}

var nameCal = NameCal(fname: "Hermione", lname: "Granger")
print(nameCal.fullName)
nameCal.fullName = "Harry Potter"
print(String(describing: nameCal))


// 3) Create a swift program to show usage of stored properties.
class Dog2 {
    let name: String?
    
    init(_ name: String) {
        self.name = name
    }
}
let dog2 = Dog2("Tommy")
print(dog2.name ?? "dog")


// 4) Create a swift program which has private properties which cannot directly be accessed. Means we cannot directly read or write it.
class UserDetails {
    let username: String
    private var password: String
    
    init(_ username: String, pass: String) {
        self.username = username
        self.password = pass
    }
    
    func changePass(newPass: String, oldPass: String) {
        guard oldPass == password else {
            print("invalid password")
            return
        }
        if newPass.count <= 5 {
            print("too sort")
            return
        }
        self.password = newPass
        print("password changed")
    }
}

let userKp = UserDetails("Kruna1Pate1", pass: "Krunal#123")
userKp.changePass(newPass: "Krunal@5802", oldPass: "Krunal#123")
userKp.changePass(newPass: "Krunal@123", oldPass: "Krunal#123")


// 5) Create one swift class which have two properties name and id, the class must have one initializer to set that properties. And create one array of that class types.
class Person2 {
    let id: Int
    var name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

var persons2 = [
    Person2(id: 1, name: "Harry"),
    Person2(id: 2, name: "Hermione"),
    Person2(id: 3, name: "Voldemort")
]
persons2.forEach { p in
    print("id: \(p.id), name: \(p.name)")
}


// 6) Create one example of usage of willSet and didSet.
struct Square {
    var height: Int {
        willSet {
            print("willSet:", newValue)
        }
        didSet {
            print("didSet:", oldValue)
        }
    }
    var width: Int {
        get {
            height
        }
        set {
            height = newValue
        }
    }
}

var sq = Square(height: 5)
sq.height = 10
sq.width = 15


// 7) Create one lazy stored property in a class and show usage of it.
class Counter {
    var count = 0
    
    init() {
        print("count initialized")
        count += 1
    }
}

class LazyCounter {
    lazy var counter = Counter()
}

let lc = LazyCounter()
print("lc instance created")
print("current count:", lc.counter.count)
print("current count:", lc.counter.count)


// 8) Create one class as Base type Person which has common properties like name, occupation, etc. Create two child classes from the person which are Student, Employee and this two-child classes must have base properties and some other properties also. Example, student have college, but Employee have company. And demonstrate the usage of inheritance.
class PersonBase {
    var name: String
    var occupation: String
    var gender: Gender
    
    enum Gender {
        case male, female, other
    }
    
    init(name: String, occupation: String, gender: Gender) {
        self.name = name
        self.occupation = occupation
        self.gender = gender
    }
}

class StudentNew: PersonBase {
    var college: String
    var avgScore: Int = 0
    
    init(name: String, gender: Gender, college: String) {
        self.college = college
        super.init(name: name, occupation: "Student", gender: gender)
    }
}

class EmployeeNew: PersonBase {
    var empId: Int
    var company: String
    var experience: Int = 1
    
    init(id: Int, name: String, gender: Gender, company: String) {
        self.empId = id
        self.company = company
        super.init(name: name, occupation: "Employee", gender: gender)
    }
}

var basePerson = PersonBase(name: "Krunal", occupation: "Trainee", gender: PersonBase.Gender.male)
var studentNew = StudentNew(name: "Hima", gender: PersonBase.Gender.female, college: "gmers")
var empNew = EmployeeNew(id: 5, name: "Harsh", gender: .male, company: "Amnex")

print("[basePerson] -> name: \(basePerson.name), gender: \(basePerson.gender), occupation: \(basePerson.occupation)")
print("[studetNew] -> name: \(studentNew.name), gender: \(studentNew.gender), occupation: \(studentNew.occupation), college: \(studentNew.college), avg score: \(studentNew.avgScore)")
print("[empNew] -> id: \(empNew.empId), name: \(empNew.name), gender: \(empNew.gender), occupation: \(empNew.occupation), company: \(empNew.company), experience: \(empNew.experience)")


// 9) Create one structure to show usage of mutating function in swift.
struct Formatter {
    var str: String
    
    mutating func cap() {
        str = str.uppercased()
    }
    
    mutating func low() {
        str = str.lowercased()
    }
}

var formatter = Formatter(str: "Hello World!")
print(formatter.str)
formatter.cap()
print(formatter.str)
formatter.low()
print(formatter.str)


// 10) Create one class inheritance demo to show usage of method overriding.
class Rectangle2 {
    var height: Int
    var width: Int
    
    init(height: Int, width: Int) {
        self.height = height
        self.width = width
    }
    
    func area() -> Int {
        height * width
    }
}

class Square2: Rectangle2 {
    
    private override init(height: Int, width: Int) {
        super.init(height: height, width: width)
    }
    
    convenience init(length: Int) {
        self.init(height: length, width: length)
    }
    
    override func area() -> Int {
        super.height * super.height
    }
}

var rec2: Rectangle2 = Rectangle2(height: 5, width: 10)
var sq2 = Square2(length: 10)
print(sq2.area())


// 11) Create one swift class to show usage of type methods.
class CounterNew {
    static var count = 0
    
    static func inc(by: Int = 1) {
        count += by
    }
    
    static func dec(by: Int = 1) {
        count -= by
    }
    
    init() {
        print("CounterNew initialized")
    }
}

print("count:", CounterNew.count)
CounterNew.inc(by: 5)
print("count:", CounterNew.count)
CounterNew.dec(by: 3)
print("count:", CounterNew.count)
CounterNew()


// 12) Create one swift class which is having class method and static method. Then in one child class try to override that methods and check the output/ error. (you will learn difference between class and static)
class A {
    func classMethod() {
        print("class method from A")
    }
    
    static func staticMethod() {
        print("static method from A")
    }
}

class B: A {
    override func classMethod() {
        print("class method from B")
    }
    
    //    error: Cannot override static method
    //    override static func staticMethod() {
    //        print("static method from B")
    //    }
}

var a = A()
A.staticMethod()
a.classMethod()

var b = B()
B.staticMethod()
b.classMethod()


// 13) Create one example of subscript using array. Create one array of weekdays and one subscript func which takes int as argument and returns day of week.
struct WeekDays {
    let weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    subscript(day: Int) -> String {
        if !(1...7).contains(day) {
            return "invalid day"
        }
        return weekdays[day - 1]
    }
}

let weekDays = WeekDays()
print(weekDays[1])
print(weekDays[-1])
print(weekDays[8])


// 14) Create a swift program to show usage of subscript in string. I pass int argument and it returns the character at given position.
struct Position {
    var str: String
    
    subscript(pos: Int) -> Character {
        if pos >= 0 {
            return str[str.index(str.startIndex, offsetBy: pos)]
        } else {
            return str[str.index(str.endIndex, offsetBy: pos)]
        }
    }
}

let pos = Position(str: "Hello World!")
print(pos[0])
print(pos[2])
print(pos[-1])


// 15) Create one swift subscript program which takes range as input and returns the string between the ranges.
struct SubStr {
    var str: String
    
    subscript(range: ClosedRange<Int>) -> String {
        let sIndex = str.index(str.startIndex, offsetBy: range.lowerBound)
        let eIndex = str.index(str.startIndex, offsetBy: range.upperBound)
        return String(str[sIndex...eIndex])
    }
}

let subStr = SubStr(str: "Hello World!")
print(subStr[0...3])


// 16) I have one integer array and create one function which takes range as input and returns all elements between the range.
class SubArr {
    var arr = Array(1...10)
    
    subscript(range: ClosedRange<Int>) -> [Int] {
        Array(arr[range])
    }
}

let subArry = SubArr()
print(subArry[2...5])


// 17) I have one key value pair array. Create one function using subscript which takes key as input and returns it’s value.
class KeyValue {
    let arr = [[1: "one"], [2: "two"], [3: "three"], [4: "four"], [5: "five"]]
    
    subscript(at: Int) -> String {
        arr.first(where: { $0.keys.first == at })?.values.first ?? "not found"
    }
}

let keyValue = KeyValue()
print(keyValue[3])
print(keyValue[-2])


// 18) Create one array of type Person and create one subscript function which takes person name as input and returns person info like name, age, birthdate etc.
class PersonInfo {
    let arr = [
        PersonS(name: "Harry", gender: "Male", age: 17),
        PersonS(name: "Hermione", gender: "Female", age: 17),
        PersonS(name: "Voldemort", gender: "Male", age: 65)
    ]
    
    subscript(name: String) -> Void {
        let p = arr.first(where: { $0.name == name })
        if let p {
            print("name: \(p.name), gender: \(p.gender), age: \(p.age)")
        } else {
            print("not found")
        }
    }
}

let pi = PersonInfo()
pi["Harry"]
pi["Unknown"]


// 19) Create one base class of type Song and create subclasses of music types (Hip-Hop,classical) and show usage of inheritance.  Here Music class have property singer, composer
class Music {
    var singer: String
    var composer: String
    
    var category: String {
        "Common"
    }
    
    init(singer: String, composer: String) {
        self.singer = singer
        self.composer = composer
    }
}

class HipHop: Music {
    override var category: String {
        "Hip-Hop"
    }
    
    override init(singer: String, composer: String) {
        super.init(singer: singer, composer: composer)
    }
}

class Classical: Music {
    override var category: String {
        "Classical"
    }
    
    init() {
        super.init(singer: "unknown", composer: "unknown")
    }
}

var music: Music = Music(singer: "KK", composer: "Pritam")
print(music.singer, music.composer, music.category)
music = HipHop(singer: "Javed", composer: "Vishal")
print(music.singer, music.composer, music.category)
music = Classical()
print(music.singer, music.composer, music.category)


// 20) Create a swift class with properties which can be read-write outside of class.
class Calculator {
    var a: Int?
    var b: Int?
    
    func add() -> Int {
        (a ?? 0) + (b ?? 0)
    }
}

let cal = Calculator()
cal.a = 10
print(cal.add())


/**
 Error Handling
 */

// 1. Create a password validation program. If length of password is less than 8 characters, it throws “Password too short” exception and if password is empty, throw “Empty password” exception.
enum PasswodError: Error {
    case passwordTooShort(min: Int)
    case emptyPassword
}

class Validator {
    let minLength = 4
    
    func validate(password: String) throws {
        if password.isEmpty {
            throw PasswodError.emptyPassword
        } else if password.count < minLength {
            throw PasswodError.passwordTooShort(min: minLength)
        }
        print("Valid password")
    }
}

let validator = Validator()
do {
    try validator.validate(password: "")
} catch PasswodError.emptyPassword {
    print("Password is empty")
} catch PasswodError.passwordTooShort(let min) {
    print("Password is too short, require \(min) charecters")
}

do {
    try validator.validate(password: "Abc")
} catch PasswodError.emptyPassword {
    print("Password is empty")
} catch PasswodError.passwordTooShort(let min) {
    print("Password is too short, require \(min) charecters")
}

do {
    try validator.validate(password: "Krunal@123")
} catch PasswodError.emptyPassword {
    print("Password is empty")
} catch PasswodError.passwordTooShort(let min) {
    print("Password is too short, require \(min) charecters")
}


// 2) Create a program for shopping cart. If desired quantity for an item is not available, throw exception.
enum CartError: Error {
    case NotAvailable
}

struct ShopingCart {
    private let items = ["bag", "shooes", "belt", "geyser"]
    
    func buy(item: String) throws {
        if items.contains(item) {
            print("purchase done")
        } else {
            throw CartError.NotAvailable
        }
    }
}

let cart = ShopingCart()
try? cart.buy(item: "bag")
try? cart.buy(item: "jacket")


/**
 Extensions
 */

// Add a character in a string at 5th position
extension String {
    mutating func addAt5(ch: Character) {
        self.insert(ch, at: index(startIndex, offsetBy: 5))
    }
}

var str = "Hello World ! ! "
print(str)
str.addAt5(ch: "P")
print(str)

// Replace one character with other in a string
extension String {
    mutating func replace(old: Character, new: Character) {
        self.replacingOccurrences(of: String(old), with: String(new))
    }
}

str.replace(old: "P", new: "K")
print(str)


// Remove white spaces from string
extension String {
    mutating func trim() {
        self.removeAll(where: { $0 == " " })
    }
}

str.trim()
print(str)

// Get number of words in a string
extension String {
    func length() -> Int {
        self.count
    }
}

print(str.length())
