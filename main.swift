import Foundation


enum ArithmeticExpressions {
    case addition (Float, Float)
    case subtraction (Float, Float)
    case multiplication (Float, Float)
    case division (Float, Float)
    
    func computation (arithmetic: ArithmeticExpressions) -> Float {
        switch arithmetic {
        case let.addition(numberOne, numberTwo):
            return numberOne + numberTwo
        case let.subtraction(numberOne, numberTwo):
            return numberOne - numberTwo
        case let.multiplication(numberOne, numberTwo):
            return numberOne * numberTwo
        case let.division(numberOne, numberTwo):
            return numberOne / numberTwo
        }
    }
}

let addition = ArithmeticExpressions.addition(3, 4)
print(addition.computation(arithmetic: addition))
let subtraction = ArithmeticExpressions.subtraction(3, 4)
print(addition.computation (arithmetic: subtraction))
let multiplication = ArithmeticExpressions.multiplication(3, 4)
print(addition.computation (arithmetic: multiplication))
let division = ArithmeticExpressions.division(3, 4)
print(addition.computation(arithmetic: division))
