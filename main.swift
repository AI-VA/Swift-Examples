import Foundation


print("Введите ваше имя: ")

if let name = readLine() {
    print("Привет: \(name)")
} else {
    print("Вы не ввели имя")
}
