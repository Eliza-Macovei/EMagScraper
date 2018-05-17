//
//  Element+EmagReader.swift
//  EmagScraperFromZero
//
//  Created by Elizabeta Macovei on 08/05/2018.
//  Copyright © 2018 Elizabeta Macovei. All rights reserved.
//

import Foundation
import SwiftSoup

extension Element {
    
    func tryGetElement(_ selector: String) -> Element? {
        do {
            return try self.select(selector).first()
        }
        catch Exception.Error(let type, let message) {
            Element.onError(type, message)
        } catch {
            print("Unknown error while obtaining node '\(selector)' ")
        }
        return nil
    }
    
    // should String?.
    func tryGetText() -> String {
        do {
            return try self.text()
        }
        catch Exception.Error(let type, let message) {
            Element.onError(type, message)
        } catch {
            print("Unknown error while reading text representation of a node.")
        }
        return ""
    }
    
    static func tryReadValue(_ selector: String, reader: (_ sele: String) throws -> String ) -> String? {
        do {
            return try reader(selector)
        }
        catch Exception.Error(let type, let message) {
            Element.onError(type, message)
        } catch {
            print("Unknown error while reading value from '\(selector)'")
        }
        return nil
    }
    
    
    // MARK - error handling
    private static func onError(_ type: ExceptionType, _ msg: String) {
        print("Element with type: '\(type)' and message: \(msg)")
    }
}
