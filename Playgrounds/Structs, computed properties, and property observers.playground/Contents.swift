import UIKit
import Foundation

/*
 Structs are one of the ways Swift lets us create our own data types out of several small types. For example, you might put
 three strings and a Boolean together and say that represents a user in your app.
 
 In fact, most of Swift’s own types are implemented as structs, including String, Int, Bool, Array, and more.
 
 struct User {
    let age: Int
    let hasToes: Bool
    let address: String
    let favoriteColor: String
 ]

 These custom types – users, games, documents, and more – form the real core of the software we build. If you get those right then often your code will follow.
 */

/*
 Swift’s structs let us create our own custom, complex data types, complete with their own variables and their own functions.
 */

struct Album {
    let title: String
    let artist: String
    let year: Int
    
    func printSummary(){
        print("\(title) (\(year)) by \(artist)")
    }
}

/*
 Album is just like String or Int – we can make them, assign values, copy them, and so on. For example, we
 could make a couple of albums, then print some of their values and call their functions:
 */

let red = Album(title: "Red", artist: "Taylor Swift", year: 2012)
let wings = Album(title: "Wings", artist: "BTS", year: 2016)

print(red.title)
print(wings.artist)

red.printSummary()
wings.printSummary()


struct Employee {
    //properties
    let name: String
    var vacationRemaining: Int
    
    init(name: String, vacationRemaining: Int){
        self.name = name
        self.vacationRemaining = vacationRemaining
    }

    // Methods
    // Any time a struct’s method tries to change any properties, you must mark it as mutating.
    // The code won't build without the mutating keyword
    
    /*
    You see, if we create an employee as a constant using let, Swift makes the employee and all its data constant – we can call functions just fine, but those functions shouldn’t be allowed to change the struct’s data because we made it constant.
     
     As a result, Swift makes us take an extra step: any functions that change data belonging to the, Employee struct must be marked with a special mutating keyword, like this:
    */
    mutating func takeVacation(days: Int) {
        if vacationRemaining > days {
            vacationRemaining -= days
            print("I'm going on vacation!")
            print("Days remaining: \(vacationRemaining)")
        } else {
            print("Oops! There aren't enough days remaining.")
        }
    }
}

/* But if you change var archer to let archer you’ll find Swift refuses to build your code again
// We’re trying to call a mutating function on a constant struct, which isn’t allowed. */
var archer = Employee(name: "", vacationRemaining: 0)
archer.takeVacation(days: 10)
print(archer.vacationRemaining)

//Creating an instance of a struct: using an initializer like this:
Album(title: "Wings", artist: "BTS", year: 2016)


// Tuple vs Structs
// They are great for one-off use, particularly when you want to return several pieces of data from a single function
// Do not use for repeated functionality
typealias Tuple = (String, Int)

func returnMutipleValues() -> Tuple {
    let animal = "dog"
    let age = 2
    
    return (animal, age)
}

print(returnMutipleValues())

//Think about it: if you have several functions that work with User information, would you rather write this using a struct

struct User {
    var name: String
    var age: Int
    var city: String
}

func authenticate(_ user: User){}
func showProfile(for user: User){}
func signOut(_ user: User){}

//Or using a Tuple

func authenticate(_ user: (name: String, age: Int, city: String)){}
func showProfile(for user: (name: String, age: Int, city: String)){}
func signOut(_ user: (name: String, age: Int, city: String)){}

/* Using a struct is better.
Use a tuple when you want to return two arbitrary pieces of values from a function */


/* COMPUTED PROPERTIES */

/*
 Structs can have two kinds of property: 
 - Stored property is a variable or constant that holds a piece of data inside an instance of the struct
 - Computed property calculates the value of the property dynamically every time it’s accessed. This means computed properties are a blend of both stored properties + functions: they are accessed like stored properties, but work like functions.
 */

struct Employee2 {
    let name: String
    var vacationRemaining: Int
}

var archer2 = Employee2(name: "Sterling Archer", vacationRemaining: 14)
archer2.vacationRemaining -= 5
print(archer2.vacationRemaining)

archer2.vacationRemaining -= 3
print(archer2.vacationRemaining)

/*
 We’re assigning this employee 14 days of vacation then subtracting them as days are taken, but in doing so we’ve lost how
 many days they were originally granted.

 We could adjust this to use computed property, like so:
 */
struct Employee3 {
    let name: String
    var vacationAllocated = 14
    var vacationTaken = 0
    
    var vacationRemaining: Int {
        return vacationAllocated - vacationTaken
    }
}
var archer3  = Employee3(name: "Sterling Archer", vacationAllocated: 14, vacationTaken: 10)
archer3.vacationTaken += 4
print(archer3.vacationRemaining)

archer3.vacationTaken += 4
print(archer3.vacationRemaining)


struct Employee4 {
    let name: String
    var vacationAllocated = 14
    var vacationTaken = 0
    
    /*
     In this case the getter is simple enough, because it’s just our existing code. But the setter is more interesting – if you
     set vacationRemaining for an employee, do you mean that you want their vacationAllocated value to be increased or
     decreased, or should vacationAllocated stay the same and instead we change vacationTaken?

    I’m going to assume the first of those two is correct, in which case here’s how the property would look:
    */

    var vacationRemaining: Int {
        get {
            vacationAllocated - vacationTaken
        }
        set {
            vacationAllocated = vacationTaken + newValue
        }
    }
}

/*
 Notice how get and set mark individual pieces of code to run when reading or writing a value. More importantly, notice newValue – that’s automatically provided to us by Swift, and stores whatever value the user was trying to assign to the property.

With both a getter and setter in place, we can now modify vacationRemaining: */

var archer4 = Employee4(name: "Sterling Archer", vacationAllocated: 14)
archer4.vacationTaken += 4
archer4.vacationRemaining = 5
print(archer4.vacationAllocated)

/* PROPERTY OBSERVERS */

/*
 The question is: do you want to know before the property changes, or after?

 The simple answer is this: most of the time you will be using didSet, because we want to take action after the change has happened so we can update our user interface, save changes, or whatever. That doesn’t mean willSet isn’t useful, it’s just that in practice it is significantly less popular than its counterpart.

 The most common time willSet is used is when you need to know the state of your program before a change is made. For example, SwiftUI uses willSet in some places to handle animations so that it can take a snapshot of the user interface before a change. When it has both the “before” and “after” snapshot, it can compare the two to see all the parts of the user interface that need to be updated.
 */

struct ZadieBooBoo {
    let name = "Zadie"
    var age: Int
    
    var sassinessLevel: Int = 0 {
        didSet {
            if age >= 1 && age <= 10 {
                print("At age \(age), \(name) is sassy always")
            }
        }
    }
}

var Z = ZadieBooBoo(age: 3)
Z.sassinessLevel = 3

