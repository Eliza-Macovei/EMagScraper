//
//  Constants.swift
//  EmagScraperFromZeroTests
//
//  Created by Pinzariu Marian on 17/05/2018.
//  Copyright © 2018 Elizabeta Macovei. All rights reserved.
//

import Foundation

struct Constants {
    struct URLConst {
        static let ProtocolName = "https"
        static let EmagName = "emag"
        static let Domain = "ro"
        static let MobileSubDomaine = "m"
        static let EmagURL = "\(ProtocolName)://\(MobileSubDomaine).\(EmagName).\(Domain)/"
    }
    
    struct Expectation {
        static let Succeed = "Parsing Succeed"
        static let Fail = "Fail"
        static let WaitForExpectations = "waitForExpectations with timeout error'd: "
        static let DefaultTimeOut:Double = 10.0
        
        static func getDescription(_ description: String,_ isSucceed: Bool = true) -> String {
            return "\(description) - \(isSucceed ? Succeed : Fail)"
        }
    }    
}
