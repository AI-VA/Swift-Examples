import Foundation


// MARK: 1. Создайте перечисление для ошибок. Добавьте в него 3 кейса:

// ошибка 400,
// ошибка 404,
// ошибка 500.

// Далее создайте переменную, которая будет хранить в себе какую-либо ошибку (400 или 404 или 500). И при помощи do-catch сделайте обработку ошибок перечисления. Для каждой ошибки должно быть выведено сообщение в консоль.

enum ErrorCode: Error {
    case error400
    case error404
    case error500
}

var error400: Bool = false
var error404: Bool = false
var error500: Bool = true

do {
   if error400 {
       throw ErrorCode.error400
   }

   if error404 {
       throw ErrorCode.error404
   }

   if error500 {
       throw ErrorCode.error500
   }

} catch ErrorCode.error400 {
   print("Ошибка 400: Неверный запрос")
} catch ErrorCode.error404 {
   print("Ошибка 404: Ресурс не найден")
} catch ErrorCode.error500 {
   print("Ошибка 500: Внутренняя ошибка сервера")
}

// MARK: 2. Теперь добавьте проверку переменных в генерирующую функцию и обрабатывайте её!

func generateError() throws {
    if error400 {
        throw ErrorCode.error400
    }

    if error404 {
        throw ErrorCode.error404
    }

    if error500 {
        throw ErrorCode.error500
    }
}

do {
    try generateError()
} catch ErrorCode.error400 {
    print("Ошибка 400: Неверный запрос")
} catch ErrorCode.error404 {
    print("Ошибка 404: Ресурс не найден")
} catch ErrorCode.error500 {
    print("Ошибка 500: Внутренняя ошибка сервера")
}

// MARK: 3. Напишите функцию, которая будет принимать на вход два разных типа и проверять: если типы входных значений одинаковые, то вывести сообщение “Yes”, в противном случае — “No”.

func checkTypes<T, U>(_ value1: T, _ value2: U) {
    if type(of: value1) == type(of: value2) {
        print("Yes")
    } else {
        print("No")
    }
}

checkTypes(5, 6)

// MARK: 4. Реализуйте то же самое, но если тип входных значений различается, выбросите исключение. Если тип одинаковый — тоже выбросите исключение, но оно уже будет говорить о том, что типы одинаковые. Не бойтесь этого. Ошибки — это не всегда про плохой результат.

enum TypeMismatchError: Error {
    case typesAreDifferent
    case typesAreSame
}

func checkTypes<T, U>(_ value1: T, _ value2: U) throws {
    if type(of: value1) != type(of: value2) {
        throw TypeMismatchError.typesAreDifferent
    } else {
        throw TypeMismatchError.typesAreSame
    }
}

do {
    try checkTypes(5, 6)
    print("The types are the same.")
} catch TypeMismatchError.typesAreDifferent {
    print("The types are different.")
} catch TypeMismatchError.typesAreSame {
    print("The types are the same.")
} catch {
    print("An error occurred: \(error)")
}

// MARK: 5. Напишите функцию, которая принимает на вход два любых значения и сравнивает их при помощи оператора равенства ==.

func compareValues<T: Equatable>(_ value1: T, _ value2: T) -> Bool {
    return value1 == value2
}

let result = compareValues(5, 6)
print(result)  // false
