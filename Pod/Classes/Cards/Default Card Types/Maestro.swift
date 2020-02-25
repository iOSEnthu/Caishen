//
//  Maestro.swift
//  Alamofire
//
//  Created by lubaba on 10/29/18.
//

/**
 *  The native supported card type of Maestro
 */
public struct Maestro: CardType {
    
    public let name = "maestro"
    
    public let CVCLength = 3
    
    public let identifyingDigits = Set(56...58).union(Set([50, 67, 6390]))
    
    public init() {
        
    }
}
