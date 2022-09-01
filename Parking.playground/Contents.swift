import UIKit
import Foundation
import Security

protocol Parkable {
    var plate: String {get} 
    var type: TypeOfVehicle {get}
    var checkInTime: Date {get}
    var discountCard: String? {get}
    var minsParked: Int { get }
}

struct Vehicle: Parkable, Hashable {
    
    var plate: String
    var type: TypeOfVehicle
    var checkInTime: Date
    var discountCard: String?
    
    var minsParked: Int {
        return Calendar.current.dateComponents([.minute], from: checkInTime, to: Date()).minute ?? 0
    }
}

struct Parking {
    
    var vehicles: Set<Vehicle> = []
    let parkingSlots = 20
    var earningsHistory :(amountChecksOut: Int,earnings: Int) = (0,0)
     
    mutating func checkInVehicle(_ vehicle: Vehicle, onFinish:(Bool) -> Void) {
        
        guard vehicles.count < parkingSlots, !vehicles.contains(vehicle) else {
                        
            onFinish(false)
            return
        }
        vehicles.insert(vehicle)
        onFinish(true)
    }
    
    mutating func checkOutVehicle(_ vehicle: Vehicle, onSuccess:(Int) -> Void, onError:() -> Void){
        
        guard vehicles.contains(vehicle) else {
                        
            onError()
            return
        }
        
        let fee = calculateFee(vehicle)
        
        earningsHistory.earnings += fee
        earningsHistory.amountChecksOut += 1
        
        vehicles.remove(vehicle)
        onSuccess(fee)
    }
    
    func calculateFee(_ vehicle: Vehicle) -> Int{
        
        let typeOfFee = vehicle.type.fee
        let timeOnParking = vehicle.minsParked
        
        if timeOnParking <= 120 {
            return typeOfFee
        }
        
        let overTime = ceil((Double(timeOnParking) - 120.0)/15.0)
        let fee = Int(overTime)*5
        
        if vehicle.discountCard != nil {
            
            return Int(Double(fee) * 0.85)
        }
        
        return Int(fee)
    }
    
    func listVehicles(){
        
        print("List of vehicles: total of \(vehicles.count) \n")
        for vehicle in vehicles {
            
            print("\(vehicle.type) with plate number \(vehicle.plate)")
        }
    }
    func showProfit(){
        
        print("\(earningsHistory.amountChecksOut) vehicles have checked out and have earnings of \(earningsHistory.earnings)")
    }
}
enum TypeOfVehicle {
    
    case car
    case bike
    case miniBus
    case bus
    
    var fee: Int {
        
        switch self {
            
        case .car:
            return 20
            
        case .bike:
            return 15
            
        case .miniBus:
            return 25
            
        case .bus:
            return 30
        }
    }
}

var parking  = Parking()

let car = Vehicle(plate: "8096 VIX", type: TypeOfVehicle.car,checkInTime: Date(), discountCard: "DISCOUNT_CARD_001")
let moto = Vehicle(plate: "1843 WID", type: TypeOfVehicle.bike, checkInTime: Date(), discountCard: nil)
let miniBus = Vehicle(plate: "6278 FUF", type: TypeOfVehicle.miniBus, checkInTime: Date(), discountCard:nil)
let bus = Vehicle(plate: "7569 LFW", type: TypeOfVehicle.bus,checkInTime: Date(), discountCard: "DISCOUNT_CARD_002")

let car2 = Vehicle(plate: "0625 MDI", type: TypeOfVehicle.car,checkInTime: Date(), discountCard: "DISCOUNT_CARD_003")
let moto2 = Vehicle(plate: "8880 LOC", type: TypeOfVehicle.bike, checkInTime: Date(), discountCard: nil)
let miniBus2 = Vehicle(plate: "2494 LDH", type: TypeOfVehicle.miniBus, checkInTime: Date(), discountCard:nil)
let bus2 = Vehicle(plate: "4096 FVW", type: TypeOfVehicle.bus,checkInTime: Date(), discountCard: "DISCOUNT_CARD_004")

let car3 = Vehicle(plate: "5731 CMF", type: TypeOfVehicle.car,checkInTime: Date(), discountCard: "DISCOUNT_CARD_005")
let moto3 = Vehicle(plate: "9485 ABT", type: TypeOfVehicle.bike, checkInTime: Date(), discountCard: nil)
let miniBus3 = Vehicle(plate: "1777 DGZ", type: TypeOfVehicle.miniBus, checkInTime: Date(), discountCard:nil)
let bus3 = Vehicle(plate: "2467 DXB", type: TypeOfVehicle.bus,checkInTime: Date(), discountCard: "DISCOUNT_CARD_006")

let car4 = Vehicle(plate: "3332 QPZ", type: TypeOfVehicle.car,checkInTime: Date(), discountCard: "DISCOUNT_CARD_007")
let moto4 = Vehicle(plate: "2386 RHQ", type: TypeOfVehicle.bike, checkInTime: Date(), discountCard: nil)
let miniBus4 = Vehicle(plate: "5059 YFP", type: TypeOfVehicle.miniBus, checkInTime: Date(), discountCard:nil)
let bus4 = Vehicle(plate: "7631 ERP", type: TypeOfVehicle.bus,checkInTime: Date(), discountCard: "DISCOUNT_CARD_008")

let car5 = Vehicle(plate: "1397 KZD", type: TypeOfVehicle.car,checkInTime: Date(), discountCard: "DISCOUNT_CARD_009")
let moto5 = Vehicle(plate: "0563 GFF", type: TypeOfVehicle.bike, checkInTime: Date(), discountCard: nil)
let miniBus5 = Vehicle(plate: "2936 BWQ", type: TypeOfVehicle.miniBus, checkInTime: Date(), discountCard:nil)
let bus5 = Vehicle(plate: "9774 PUG", type: TypeOfVehicle.bus,checkInTime: Date(), discountCard: "DISCOUNT_CARD_010")

//No more space in the parking, this vehicle is going to fail the check in process

let car6 = Vehicle(plate: "3984 LEA", type: TypeOfVehicle.car,checkInTime: Date(), discountCard: "DISCOUNT_CARD_001")

// Parking
parking.checkInVehicle(car, onFinish: { result in result ? print("Welcome to AlkeParking!") : print("Sorry, the check-in failed")} )
parking.checkInVehicle(moto, onFinish: { result in result ? print("Welcome to AlkeParking!") : print("Sorry, the check-in failed")} )
parking.checkInVehicle(miniBus, onFinish: { result in result ? print("Welcome to AlkeParking!") : print("Sorry, the check-in failed")} )
parking.checkInVehicle(bus, onFinish: { result in result ? print("Welcome to AlkeParking!") : print("Sorry, the check-in failed")} )

parking.checkInVehicle(car2, onFinish: { result in result ? print("Welcome to AlkeParking!") : print("Sorry, the check-in failed")} )
parking.checkInVehicle(moto2, onFinish: { result in result ? print("Welcome to AlkeParking!") : print("Sorry, the check-in failed")} )
parking.checkInVehicle(miniBus2, onFinish: { result in result ? print("Welcome to AlkeParking!") : print("Sorry, the check-in failed")} )
parking.checkInVehicle(bus2, onFinish: { result in result ? print("Welcome to AlkeParking!") : print("Sorry, the check-in failed")} )

parking.checkInVehicle(car3, onFinish: { result in result ? print("Welcome to AlkeParking!") : print("Sorry, the check-in failed")} )
parking.checkInVehicle(moto3, onFinish: { result in result ? print("Welcome to AlkeParking!") : print("Sorry, the check-in failed")} )
parking.checkInVehicle(miniBus3, onFinish: { result in result ? print("Welcome to AlkeParking!") : print("Sorry, the check-in failed")} )
parking.checkInVehicle(bus3, onFinish: { result in result ? print("Welcome to AlkeParking!") : print("Sorry, the check-in failed")} )

parking.checkInVehicle(car4, onFinish: { result in result ? print("Welcome to AlkeParking!") : print("Sorry, the check-in failed")} )
parking.checkInVehicle(moto4, onFinish: { result in result ? print("Welcome to AlkeParking!") : print("Sorry, the check-in failed")} )
parking.checkInVehicle(miniBus4, onFinish: { result in result ? print("Welcome to AlkeParking!") : print("Sorry, the check-in failed")} )
parking.checkInVehicle(bus4, onFinish: { result in result ? print("Welcome to AlkeParking!") : print("Sorry, the check-in failed")} )

parking.checkInVehicle(car5, onFinish: { result in result ? print("Welcome to AlkeParking!") : print("Sorry, the check-in failed")} )
parking.checkInVehicle(moto5, onFinish: { result in result ? print("Welcome to AlkeParking!") : print("Sorry, the check-in failed")} )
parking.checkInVehicle(miniBus5, onFinish: { result in result ? print("Welcome to AlkeParking!") : print("Sorry, the check-in failed")} )
parking.checkInVehicle(bus5, onFinish: { result in result ? print("Welcome to AlkeParking!") : print("Sorry, the check-in failed")} )

parking.checkInVehicle(bus, onFinish: { result in result ? print("Welcome to AlkeParking!") : print("Sorry, the check-in failed")} )


parking.listVehicles()

parking.checkOutVehicle(car, onSuccess: {fee in print("The fee is \(fee)")}, onError:{ print("Sorry, the check-out failed")})
parking.checkOutVehicle(moto, onSuccess: {fee in print("The fee is \(fee)")}, onError:{ print("Sorry, the check-out failed")})
parking.checkOutVehicle(miniBus, onSuccess: {fee in print("The fee is \(fee)")}, onError:{ print("Sorry, the check-out failed")})



parking.listVehicles()
parking.showProfit()

