import Foundation


// Этот код демонстрирует, как использовать делегаты в Swift для уведомления одного объекта о событиях, происходящих в другом объекте. Класс WebsiteForOrderingFeedShopHappyDog выполняет роль "событийного генератора", а класс FeedShopHappyDog - роль "обработчика событий".

// 1. В коде определяется протокол FeedDeliveryDelegate, который имеет три обязательных метода: feedDeliveryByAddres, feedDeliveryTime и ordered.
protocol FeedDeliveryDelegate: AnyObject {
    func feedDeliveryByAddres(addres: String, flat: String)
    func feedDeliveryTime(date: String, time: String)
    func ordered(feed: DogFeed?, toys: DogToys?) // Enums
}
// 2. Определены два перечисления: DogFeed и DogToys. DogFeed имеет три варианта: суп, сухой корм и кость. DogToys также имеет два варианта: курица и мяч.
enum DogFeed: String {
    case soup = "Soup:\"Long life\""
    case dryFood = "Dry food - healthy teeth and hair"
    case bone = "Sweet bone"
}

enum DogToys: String {
    case chicken = "Big yellow chicken"
    case ball = "Small ball for dog"
}
// 3. Класс FeedShopHappyDog реализует протокол FeedDeliveryDelegate. Это означает, что этот класс обязан реализовать все три метода из протокола FeedDeliveryDelegate. Этот класс является "обработчиком событий".
class FeedShopHappyDog: FeedDeliveryDelegate {
    func feedDeliveryByAddres(addres: String, flat: String) {
        print("products will be delivered to the address: \(addres) flat: \(flat)")
    }
    
    func feedDeliveryTime(date: String, time: String) {
        print("Delivery of food for your pet is scheduled for \(date) at \(time)")
    }
// 4. В методе ordered класса FeedShopHappyDog используется условный оператор if для проверки, был ли заказан корм для собаки и/или игрушки. Если был заказан корм для собаки, метод использует оператор switch для проверки, какой тип корма был заказан, и выводит соответствующее сообщение. Аналогично, если была заказана игрушка для собаки, метод выводит соответствующее сообщение.
    func ordered(feed: DogFeed?, toys: DogToys?) {
        if feed != nil {
            switch feed {
            case .dryFood : // Доступ к enum DogFeed.dryFood
                print("You ordered - \(DogFeed.dryFood.rawValue)")
            case .soup:
                print("You ordered - \(DogFeed.soup.rawValue)")
            case .bone:
                print("You ordered - \(DogFeed.bone.rawValue)")
            case .none:
                return
            }
        }
        if toys != nil {
            switch toys {
            case .chicken :
                print("You ordered - \(DogToys.chicken.rawValue)")
            case .ball:
                print("You ordered - \(DogToys.ball.rawValue)")
            case .none:
                return
            }
        }
    }
}
// 5. Класс WebsiteForOrderingFeedShopHappyDog имеет три метода: userSelectsPurchasesDogGoodsStore, userEnteredAddres и userEnteredDeliveryTime. В этих методах вызываются соответствующие методы делегата FeedDeliveryDelegate, чтобы уведомить о заказе корма для собаки, адресе доставки и времени доставки.
// 7. Наконец, вызываются методы userEnteredAddres, userEnteredDeliveryTime и userSelectsPurchasesDogGoodsStore объекта websiteForOrderingFeedShopHappyDog, чтобы сделать заказ корма для собаки, указать адрес доставки и время доставки.
class WebsiteForOrderingFeedShopHappyDog { // Этот класс является "событийным генератором"
    weak var delegate: FeedDeliveryDelegate?
    
    func userSelectsPurchasesDogGoodsStore(feedForDog: DogFeed?, toysForDog: DogToys?){
        delegate?.ordered(feed: feedForDog, toys: toysForDog)
    }
    
    func userEnteredAddres(yourAddres: String, flat: String){
        delegate?.feedDeliveryByAddres(addres: yourAddres, flat: flat)
    }
    
    func userEnteredDeliveryTime(deliveryDate: String, timeOfDelivery: String){
        delegate?.feedDeliveryTime(date: deliveryDate, time: timeOfDelivery)
    }
}
// 6. Создаются экземпляры классов FeedShopHappyDog и WebsiteForOrderingFeedShopHappyDog. Затем устанавливается связь между делегатом WebsiteForOrderingFeedShopHappyDog и классом FeedShopHappyDog.
let feedShopHappyDog = FeedShopHappyDog()
var websiteForOrderingFeedShopHappyDog = WebsiteForOrderingFeedShopHappyDog()
websiteForOrderingFeedShopHappyDog.delegate = feedShopHappyDog
websiteForOrderingFeedShopHappyDog.userEnteredAddres(yourAddres: "Prospect Mira 24/1", flat: "N 344")
websiteForOrderingFeedShopHappyDog.userEnteredDeliveryTime(deliveryDate: "22/01/5", timeOfDelivery: "14:44 PM")
websiteForOrderingFeedShopHappyDog.userSelectsPurchasesDogGoodsStore(feedForDog: .dryFood, toysForDog: .chicken)
