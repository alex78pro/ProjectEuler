//https://projecteuler.net/problem=78


//Let p(n) represent the number of different ways in which n coins can be separated into piles. For example, five coins can be separated into piles in exactly seven different ways, so p(5)=7.
//OOOOO
//OOOO   O
//OOO   OO
//OOO   O   O
//OO   OO   O
//OO   O   O   O
//O   O   O   O   O
//
//Find the least value of n for which p(n) is divisible by one million.

import Foundation

let million = 1_000_000

class Probleb78: Task {
    //https://en.wikipedia.org/wiki/Partition_function_(number_theory)
    //As mentioned recurrence relation gives
    //p(n) = sum_{k !=0, n <= k(3k-1)/2} (-1)^{k+1}p(n-k(3k-1)/2) % million
    // if
    
    static func runTask() -> TimeInterval {
        let startDate = Date()
        
        var pArray = [1]
        
        var index = 0
        var iterator = 1
        var iteratorSign = 1
        var pn = 0
        
        while pArray.last! != 0 {
            index += 1
            iterator = 1
            pn = 0
            
            while iterator.pentaNumber <= index {
                iteratorSign = (iterator + 1) % 2 == 0 ? 1 : -1
                pn = (pn + iteratorSign * pArray[index - iterator.pentaNumber]) % million
                
                if (-iterator).pentaNumber <= index {
                    pn = (pn + iteratorSign * pArray[index - (-iterator).pentaNumber]) % million
                }
                
                iterator += 1
            }
            
            pArray.append(pn)
        }
        
        print("\(index)")
        
        return Date().timeIntervalSince(startDate)
    }
}

extension Int {
    var pentaNumber: Int {
        return self * (3 * self - 1) / 2
    }
}
