//https://projecteuler.net/problem=8

// Find the thirteen adjacent digits in the 1000-digit number that have the greatest product. What is the value of this product?

import Foundation

let numbersLength = 13

class Probleb8: Task {
    static func runTask() -> TimeInterval {
        let startDate = Date()
        let inputString = "7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450"
        
        // if we have zeroes in the string we can divide string into substrings (zeroes are separator elements)
        // substring with unsufficient length can be deleted
        let stringsArray = inputString.split(separator: "0").filter{ $0.count > numbersLength }.map{ String($0) }
        
        let maxProduct = stringsArray.map { $0.maxProduct }.max()!
        
        print("answer: \(maxProduct.asString(radix: 10))")
        
        return Date().timeIntervalSince(startDate)
    }
}

extension String {
    var maxProduct: BInt {
        let numbersArray = self.convertNumbersStringToArray
        
        return numbersArray.allSubArraysMaxProduct
    }
    
    var convertNumbersStringToArray: [UInt8] {
        return Array(self).map{ UInt8("\($0)")! }
    }
}

protocol _UInt8 { }
extension UInt8: _UInt8 { }

extension Array where Element: _UInt8 {
    var allSubArraysMaxProduct: BInt {
        return subArrays.map{ $0.elementsProduct }.max()!
    }
    
    var subArrays: Array<Array<Element>> {
        var subArrays = Array<Array<Element>>()
        
        for index in 0...(count - numbersLength) {
            subArrays.append(Array(self[index...(index + numbersLength - 1)]))
        }
        
        return subArrays
    }
    
    var elementsProduct: BInt {
        var product = BInt(1)
        
        forEach { product *= BInt($0 as! UInt8) }
        
        return product
    }
}
