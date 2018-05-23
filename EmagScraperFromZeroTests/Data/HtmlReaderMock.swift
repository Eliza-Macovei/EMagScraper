//
//  HtmlReaderMock.swift
//  EmagScraperFromZeroTests
//
//  Created by Pinzariu Marian on 18/05/2018.
//  Copyright © 2018 Elizabeta Macovei. All rights reserved.
//

import Foundation
@testable import EmagScraperFromZero

class HtmlReaderMock: HtmlReaderProtocol {
    
    var getDetails:Bool = false
    var withEmtyValue:Bool = false
    
    private static var sharedCache: NSCache<AnyObject, AnyObject> = NSCache<AnyObject, AnyObject>()
    
    init(_ getDetails: Bool = false) {
        self.getDetails = getDetails
    }
    
    func getHtml(url: URL, completion: @escaping ((_ data: String?) -> Void)) {
        if !url.absoluteString.isEmpty {
            completion(getDetails ? getHtmlForDetailsItem() : getHtmlForPreviewItem())
        }
    }
    
    private func getHtmlForPreviewItem() -> String? {
        return getHtmlValueFromCache("search_apple")
    }
    
    private func getHtmlForDetailsItem() -> String? {
        return getHtmlValueFromCache("appleIPhone6")
    }
    
    private func getHtmlValueFromCache(_ keyName: String) -> String? {
        var value: String?
        
        if withEmtyValue {
            return value
        }
        
        if let htmlFromCache = HtmlReaderMock.sharedCache.object(forKey: keyName as AnyObject) {
            value = htmlFromCache as? String
        } else {
            value = getResourceFile(keyName)
            HtmlReaderMock.sharedCache.setObject(value! as AnyObject as AnyObject, forKey: keyName as AnyObject)
        }
        
        return value
    }
    
    private func getResourceFile(_ fileName: String) -> String? {
        
        let bundleDoingTest: Bundle = Bundle(for: type(of: self ))        
        guard let bundleFilePath = bundleDoingTest.path(forResource: fileName, ofType: "htm") else {
            return nil
        }
        
        return try? String(contentsOfFile: bundleFilePath, encoding: .utf8)
    }
}
