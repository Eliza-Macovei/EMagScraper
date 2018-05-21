//
//  EMagItemParser.swift
//  EmagScraperFromZero
//
//  Created by Elizabeta Macovei on 07/05/2018.
//  Copyright © 2018 Elizabeta Macovei. All rights reserved.
//

import Foundation
import SwiftSoup

class EmagItemParser {
    
    private var htmlReader: HtmlReaderProtocol!
    
    init() {
        self.htmlReader = HtmlReader()
    }
    
    convenience init(_ htmlReader: HtmlReaderProtocol) {
        self.init()
        
        self.htmlReader = htmlReader
    }
    
    func parse(url: URL, completion: @escaping ((_ data: [PreviewItem]) -> Void)) {
        var results = [PreviewItem]()
        
        htmlReader.getHtml(url: url, completion: { (fullHtml: String?) in
            
            if let html = fullHtml {
                do {
                    let doc = try SwiftSoup.parse(html)
                    // ?? what about count and extra items / next page of results ??
                    let cards = try doc.select(".card-item") // 36 results, aka the first page.
                    
                    for card in cards {
                        if let preview = self.getFieldsFromCard(card) {
                            results.append(preview)
                        } else { print(" could not parse a valid PreviewItem from card node.") }
                    }
                    
                    completion(results)
                } catch Exception.Error(let type, let message) {
                    print("Exception of type \(type) with message\n  [\(message)]")
                } catch {
                    print("Unknown error while parsing HTML input from URL '\(url)' (working with \(fullHtml!.count) characters) ")
                }
            }
        })
    }
    
    private func getFieldsFromCard(_ card: Element) -> PreviewItem? {
    
        var detailsUrl, thumbnailUrl: String?
        if let heading = card.tryGetElement("div.card-heading"),
            let linkNode = heading.tryGetElement("a")  {
            detailsUrl = Element.tryReadValue("href", reader: linkNode.attr)
            if let thumbNode = linkNode.tryGetElement("img") {
                thumbnailUrl = Element.tryReadValue("src", reader: thumbNode.attr)
            }
        }
        
        var title = ""
        if let middle = card.tryGetElement("div.card-section-mid") {
            if let titleLink = middle.tryGetElement("a") {
                title = titleLink.tryGetText()
            }
        }
        
        var coin = ""
        var price: Double = 0.0
        if let priceParagraph = card.tryGetElement("p.product-new-price") {
            let priceText = priceParagraph.tryGetText()
            var suffix: String
            if let coinNode = priceParagraph.tryGetElement("span") {
                coin = coinNode.tryGetText()
            }
            var cents: Int = 0
            if let centsNode = priceParagraph.tryGetElement("sup"){
                let centsText = centsNode.tryGetText()
                // priceText is formatted like <price><fraction> <coin>; example ['1.83004 Lei'] instead of 1.830,04 lei
                suffix = String("\(centsText) \(coin)")
                cents = Int(centsText) ?? 0
            } else {
                suffix = " " + coin
            }
            // log priceText.hasSuffix(suffix)
            var wholeNumber = priceText.replacingOccurrences(of: suffix, with: "") // removes the trailing "cents Coin".
            wholeNumber = wholeNumber.replacingOccurrences(of: ".", with: "") // removes any formatting, or conversion to double will give false results.
            wholeNumber = wholeNumber.replacingOccurrences(of: ",", with: "")
            //print(" > Debugging price convertor: raw text = '\(priceText)'; whole number = '\(wholeNumber)'") // parsed whole = \()")
            if let wholePrice = Double(wholeNumber) {
                price = wholePrice + Double(cents)/100
            }
        }
        
        // get raw strings from card, add to items.
        return PreviewItem("eMag", title, thumbnailUrl, price, coin, detailsUrl)
    }
}
