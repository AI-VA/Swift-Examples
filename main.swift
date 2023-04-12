import Foundation


// MARK: 4. Functional types
func isEven(number: Int) -> Bool {
    number % 2 == 0
}

// Now let's write a function that will take the isEven function as a parameter and convert its result into the String type:

func generateNumberString(number: Int, checkFunction: (Int) -> Bool) -> String {
  let isEven = checkFunction(number)       // Passed the function as a parameter isEven(5)
  return isEven ? "Чётное" : "Нечётное"
}
 
let string = generateNumberString(number: 5, checkFunction: isEven)
print(string)
