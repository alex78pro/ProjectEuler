//https://projecteuler.net/problem=43

/*
The number, 1406357289, is a 0 to 9 pandigital number because it is made up of each of the digits 0 to 9 in some order, but it also has a rather interesting sub-string divisibility property.

Let d1 be the 1st digit, d2 be the 2nd digit, and so on. In this way, we note the following:

d2d3d4=406 is divisible by 2
d3d4d5=063 is divisible by 3
d4d5d6=635 is divisible by 5
d5d6d7=357 is divisible by 7
d6d7d8=572 is divisible by 11
d7d8d9=728 is divisible by 13
d8d9d10=289 is divisible by 17

Find the sum of all 0 to 9 pandigital numbers with this property.
*/

import Foundation

let digits = (0..<10).map { $0 }

class Probleb43: Task {
    static func runTask() -> TimeInterval {
        let startDate = Date()
        
        var pandigitalNumbers = [[Int]]()
        
        var lastThreeDigits = [Int]()
        var lastFourDigits = [Int]()
        var lastFiveDigits = [Int]()
        var lastSixDigits = [Int]()
        var d5Digits = [Int]()
        var lastSevenDigits = [Int]()
        var d4Digits = [Int]()
        var lastEightDigits = [Int]()
        var d3Digits = [Int]()
        var d2Digits = [Int]()
        
        var d7 = 0
        var d6 = 0
        var d5 = 0
        var d3 = 0
        
        //d_8d_9d_10
        var endNumber = 17
        
        while endNumber < 1000 {
            //last three digits
            lastThreeDigits = endNumber.digits
            
            if lastThreeDigits.isEqualNumbers {
                endNumber += 17
                
                continue
            }
            
            //at most one possibility for d_7
            //d_7 = -(4 * d_8 + 3 * d_9) mod 13
            d7 = (-4 * lastThreeDigits[0] - 3 * lastThreeDigits[1]).mod(13)
            if d7 > 9 || lastThreeDigits.hasDigit(d7) {
                endNumber += 17
                
                continue
            }
            
            lastFourDigits = [d7] + lastThreeDigits
            
            //at most one possibility for d_6
            //also it's equal 0 or 5
            //d_6 = d_7 - d_8 mod 11
            d6 = (d7 - lastThreeDigits[0]).mod(11)
            if d6 > 9 || d6 % 5 != 0 || lastFourDigits.hasDigit(d6) {
                endNumber += 17
                
                continue
            }
            
            lastFiveDigits = [d6] + lastFourDigits
            
            //d_5 = 2 * d_6 + 3 * d_7 mod 7
            d5 = (2 * d6 + 3 * d7).mod(7)
            
            d5Digits = lastFiveDigits.d5Digits(d5)
            for item5 in d5Digits {
                lastSixDigits = [item5] + lastFiveDigits
                
                //d_4 must be even digit from remaining ones
                d4Digits = Array(Set(digits).subtracting(lastSixDigits)).filter{ $0 % 2 == 0 }
                
                for item4 in d4Digits {
                    lastSevenDigits = [item4] + lastSixDigits
                    
                    //d_3 has condition:
                    //d_3 = -(d_4 + d_5) mod 3
                    d3 = (-item4 - lastSixDigits[0]).mod(3)
                    d3Digits = lastSevenDigits.d3Digits(d3)
                    
                    for item3 in d3Digits {
                        lastEightDigits = [item3] + lastSevenDigits
                        
                        d2Digits = Array(Set(digits).subtracting(lastEightDigits))
                        
                        if d2Digits[0] == 0 {
                            pandigitalNumbers.append(d2Digits.reversed() + lastEightDigits)
                        } else {
                            pandigitalNumbers.append(d2Digits + lastEightDigits)
                            
                        if d2Digits[1] != 0 {
                                pandigitalNumbers.append(d2Digits.reversed() + lastEightDigits)
                            }
                        }
                    }
                }
            }
            
            endNumber += 17
        }
        
        let sum = pandigitalNumbers.map{ $0.numberFromDigits }.reduce(0, +)
        
        print("\(sum)")
        
        return Date().timeIntervalSince(startDate)
    }
}

extension Int {
    var digits: [Int] {
        return [self / 100, (self / 10) % 10, self % 10]
    }
    
    func mod(_ quotient: Int) -> Int {
        let reminder = self % quotient
        
        return reminder >= 0 ? reminder : reminder + quotient
    }
}

extension Array where Element == Int {
    var isEqualNumbers: Bool {
        let sortedArray = sorted { $0 <= $1 }
        
        for index in 0..<(count - 1) {
            if sortedArray[index] == sortedArray[index + 1] {
                return true
            }
        }
        
        return false
    }
    
    func hasDigit(_ digit: Int) -> Bool {
        for item in self {
            if digit == item {
                return true
            }
        }
        
        return false
    }
    
    func d5Digits(_ minimal: Int) -> [Int] {
        var array = [Int]()
        
        if !hasDigit(minimal) {
            array.append(minimal)
        }
        
        if minimal + 7 < 10 && !hasDigit(minimal + 7) {
            array.append(minimal + 7)
        }
        
        return array
    }
    
    func d3Digits(_ minimal: Int) -> [Int] {
        var array = [Int]()
        var possibleNumber = minimal
        
        while possibleNumber < 10 {
            if !hasDigit(possibleNumber) {
                array.append(possibleNumber)
            }
            
            possibleNumber += 3
        }
        
        return array
    }
    
    var numberFromDigits: Int {
        var number = 0
        var multiplier = 1_000_000_000
        
        forEach{ number += $0 * multiplier; multiplier /= 10 }
        
        return number
    }
    
}
