import UIKit

var greeting = "Hello, playground"

struct User {
    // Don’t let me read or write this property from anywhere outside the User struct.
    private var learnedSection = Set<String>()
    
    func learningMore(){}
    func howManyMore(){}
}

/*
 This means no one can read or write to it directly. Instead, I provide public methods for reading or writing values that should be used instead. That’s intentional, because learning a section needs to do more than just insert a string into that set – it needs to update the user interface to reflect the change, and needs to save the new information so the app remembers it was learned.*/

/*
 Swift provides us with several options, but when you’re learning you’ll only need a handful:

Use private for “don’t let anything outside the struct use this.”
Use fileprivate for “don’t let anything outside the current file use this.”
Use public for “let anyone, anywhere use this.”
There’s one extra option that is sometimes useful for learners, which is this: private(set). This means “let anyone read this property, but only let my methods write it.” */
// Important: If you use private access control for one or more properties, chances are you’ll need to create your own initializer
