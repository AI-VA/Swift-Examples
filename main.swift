import Foundation


// Задача
// Реализовать логику взаимодействия с банкоматом, работая в плейграунде:

// Запрос баланса на банковском депозите
// Снятие наличных с банковского депозита
// Пополнение банковского депозита наличными
// Пополнение баланса телефона наличными или с депозита

protocol UserData {
    var userName: String { get set }
    var userCardId: String { get set }
    var userCardPin: Int { get set }
    var userCash: Float { get set }
    var userBankDeposit: Float { get set }
    var userPhone: String { get set }
    var userPhoneBalance: Float { get set }
}

enum DescriptionTypesAvailableOperations: String {
    case balance = "Вы запросили операцию баланс депозита"
    case phone = "Вы запросили операцию пополнить телефон"
    case withdrawal = "Вы запросили операцию снять наличные"
    case topUp = "Вы запросили операцию пополнить депозит"
}

enum TextErrors: String {
    case notCashMoney = "У вас недостаточно наличных"
    case notDepositMoney = "У вас недостаточно средств на депозите"
}


struct User: UserData {
    var userName: String
    var userCardId: String
    var userCardPin: Int
    var userCash: Float
    var userBankDeposit: Float
    var userPhone: String
    var userPhoneBalance: Float
}

protocol BankApi {
    var user: UserData { get set }
    func execute(operation: ATM.Operation)
}

class BankServer: BankApi {
    var user: UserData
    init(user: UserData) {
        self.user = user
    }

    func execute(operation: ATM.Operation) {
        switch operation {
        case .checkBalance:
            printReport(greeting: "Здравствуйте, \(user.userName)",
                        description: DescriptionTypesAvailableOperations.balance.rawValue,
                        content: "Ваш баланс депозита составляет: \(user.userBankDeposit) рублей")
        case .topUpMobileFromCash(let amount):
            if checkMaxUserCash(cash: amount) {
                user.userPhoneBalance += amount
                user.userCash -= amount
                printReport(greeting: "Здравствуйте, \(user.userName)",
                            description: DescriptionTypesAvailableOperations.phone.rawValue,
                            content: "Вы пополнили баланс наличными на сумму: \(amount)\nУ вас осталось \(user.userCash) рублей наличными\nБаланс вашего телефона составляет: \(user.userPhoneBalance) рублей")
            } else {
                showError(error: .notCashMoney)
            }
        case .topUpMobileFromDeposit(let amount):
            if checkMaxAccountDeposit(withdraw: amount) {
                user.userPhoneBalance += amount
                user.userBankDeposit -= amount
                printReport(greeting: "Здравствуйте, \(user.userName)",
                            description: DescriptionTypesAvailableOperations.phone.rawValue,
                            content: "Вы пополнили баланс с депозитных средств на сумму: \(amount)\nУ вас осталось на депозите: \(user.userBankDeposit)\nБаланс вашего телефона составляет: \(user.userPhoneBalance) рублей")
            } else {
                showError(error: .notDepositMoney)
            }
        case .withdrawCash(let amount):
            if checkMaxAccountDeposit(withdraw: amount) {
                user.userCash += amount
                user.userBankDeposit -= amount
                printReport(greeting: "Здравствуйте, \(user.userName)",
                            description: DescriptionTypesAvailableOperations.withdrawal.rawValue,
                            content: "Вы сняли с депозита средства на сумму: \(amount)\nУ вас осталось на депозите: \(user.userBankDeposit) рублей\nУ вас осталось наличных: \(user.userCash) рублей")
            } else {
                showError(error: .notDepositMoney)
            }
        case .depositCash(let amount):
            if checkMaxUserCash(cash: amount) {
                user.userCash -= amount
                user.userBankDeposit += amount
                printReport(greeting: "Здравствуйте, \(user.userName)",
                            description: DescriptionTypesAvailableOperations.topUp.rawValue,
                            content: "Вы пополнили депозит на сумму: \(amount)\nСумма депозита составляет : \(user.userBankDeposit) рублей\nУ вас осталось наличных: \(user.userCash) рублей")
            } else {
                showError(error: .notCashMoney)
            }
        }
    }
    
    private func printReport(greeting: String, description: String, content: String) {
        let report = """
        \(greeting)
        \(description)
        \(content)
        Хорошего дня!
        """
        print(report)
    }
    
    private func showError(error: TextErrors) {
        let errorReport = """
        Здравствуйте, \(user.userName)
        Ошибка: \(error.rawValue)
        Хорошего дня!
        """
        print(errorReport)
    }
    
    private func checkMaxAccountDeposit(withdraw: Float) -> Bool {
        return withdraw <= user.userBankDeposit
    }
    
    private func checkMaxUserCash(cash: Float) -> Bool{
        return cash <= user.userCash
    }
}

class ATM {
    var userCardId: String
    var userCardPin: Int
    var someBank: BankApi

    enum Operation {
        case checkBalance
        case topUpMobileFromCash(cash: Float)
        case topUpMobileFromDeposit(deposit: Float)
        case withdrawCash(cash: Float)
        case depositCash(cash: Float)
    }

    enum PaymentMethod {
        case cash(cash: Float)
        case card(cardNumber: String, cardPin: Int)
    }

    init(userCardId: String, userCardPin: Int, someBank: BankApi) {
        self.userCardId = userCardId
        self.userCardPin = userCardPin
        self.someBank = someBank
    }

    public func execute(action: Operation) {
        if isCurrentUser() {
            someBank.execute(operation: action)
        }
    }

    private func isCurrentUser() -> Bool {
        return someBank.user.userCardId == userCardId && someBank.user.userCardPin == userCardPin
    }
}

// Пользовательские данные, которые хранятся на сервере банка (данные были внесены, когда пользователь зарегистрировался в банке)
let bank_user: UserData = User(userName: "User",
                               userCardId: "3339 0039 3312 2222",
                               userCardPin: 1234,
                               userCash: 2234.34,
                               userBankDeposit: 5994.4,
                               userPhone: "+7(889)-393-43-44",
                               userPhoneBalance: -34.44)

// Какой-то банк, в котором зарегистрирован пользователь (в этом банке хранятся данные пользователя)
let bankClient = BankServer(user: bank_user)

// Текущий банкомат, с которым мы работаем в данный момент
let atm443 = ATM(userCardId: "3339 0039 3312 2222",
                 userCardPin: 1234,
                 someBank: bankClient)

atm443.execute(action: .depositCash(cash: 2000))
