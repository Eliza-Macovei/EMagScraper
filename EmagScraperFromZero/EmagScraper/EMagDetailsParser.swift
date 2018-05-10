//
//  EMagDetailsParser.swift
//  EmagScraperFromZero
//
//  Created by Elizabeta Macovei on 08/05/2018.
//  Copyright © 2018 Elizabeta Macovei. All rights reserved.
//

import Foundation
import SwiftSoup

class EMagDetailsParser {

    func parse(url: URL) -> DetailsItem? {
        // get html from url.
        let fullHtml = HtmlReader().getHtml(url: url)
        do {
            // locate the 'root' node of what I'm intersted in.
            let doc = try SwiftSoup.parse(fullHtml)
            if let containerNode = try doc.select("div#main-container").first() {
                let rootNode = containerNode.tryGetElement("div.container")
                let specsNode = containerNode.tryGetElement("div#specifications-body")
                let descriptionNode = containerNode.tryGetElement("div#description-body")
                return detailsBuilder(rootNode, specsNode, descriptionNode)
            }
        } catch Exception.Error(let type, let message) {
            print("Exception of type \(type) with message\n  [\(message)]")
            //onError(type, message)
        } catch {
            print("Unknown error while parsing HTML input from URL '\(url)' (working with \(fullHtml.count) characters) ")
        }
        return nil
    }
    
    private func detailsBuilder(_ rootNode: Element?, _ specsNode: Element?, _ descrNode: Element?) -> DetailsItem? {
        var title = "", availability = "", shippingType  = "", seller = ""
        //: String
        var imgUrl: String? = nil
        if let rootNode = rootNode {
            if let titleNode = rootNode.tryGetElement("h1") {
                title = titleNode.tryGetText()
            }
            // image - there are usually multiple images, held in a carousel. taking the first, if any.
            if let imgNode = rootNode.tryGetElement("div.thumbnail-wrapper") {
                //there are 2 images: one is a smaller preview, sitting in an img; the big one is an a href.
                if let linkNode = imgNode.tryGetElement("a") {
                    imgUrl = Element.tryReadValue("href", reader: linkNode.attr)
                    // todo: kick an async request for getting image. Remove similar code from UI
                }
            }
            //availability
            if let inStockNode = rootNode.tryGetElement("span.label.label-in_stock") {
                availability = inStockNode.tryGetText()
            }
            
            // aCloserNode is a parent to both seller and shipping type.
            if let aCloserNode = rootNode.tryGetElement("div:nth-child(4) > div.col-sm-5.col-md-6.col-lg-7 > div > form > div") {
                if let soldByNode = aCloserNode.tryGetElement("div.col-sm-12.col-md-6.col-lg-5 > div:nth-child(4)") {
                    seller = soldByNode.tryGetText() // Question: should I remove span content?
                    //print("   >>> Retrieved seller = '\(seller)'")
                } else { //seller = "(could not retrieve seller)"
                    print(" :  selector failed to retrieve the parent node for seller")
                }
                
                //shipping type - the worst, because it's location dependent... and is a list.
                
                //#main-container > section:nth-child(1) > div > div:nth-child(4) > div.col-sm-5.col-md-6.col-lg-7 > div > form > div > div.col-sm-12.col-md-6.col-lg-5 > div:nth-child(5) > div > div.delivery-estimate-border-top.delivery-estimate-border-btm > div > div.delivery-estimate-col-lg.v-align-middle > div
                //#main-container > section:nth-child(1) > div > div:nth-child(4) > div.col-sm-5.col-md-6.col-lg-7 > div > form > div > div.col-sm-12.col-md-6.col-lg-5 > div:nth-child(5) > div > div:nth-child(3) > div > div.delivery-estimate-col-lg.v-align-middle > div
//                if let shippingTypeNode = aCloserNode.tryGetElement("div.delivery-estimate-panel") {
//                    // aCloserNode.tryGetElement("div.col-sm-12.col-md-6.col-lg-5 > div:nth-child(5) > ") {
//                    shippingType = shippingTypeNode.tryGetText()
//                    print("   >>> Retrieved shippingType = '\(shippingType)'")
//                } else {// shipping = "(could not retrieve seller)"
//                    print(" : selector failed to retrieve the parent node for shippingType")
//                }
            }
        }// end root node
        
        var descr = ""
        if let descrNode = descrNode {
                descr = descrNode.tryGetText() // btw: has <br> tags; afaik, these get removed by text()
        }
        
        var specs = ""
        if let specsNode = specsNode {
            specs = specsNode.tryGetText() // might not work at all well; the specs table is fairly complex.
        }
        return DetailsItem(imgUrl, title, availability, shippingType, seller, descr, specs)
    }
}
