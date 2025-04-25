//
//  UIApplication.swift
//  CryptoSwiftUI
//
//  Created by Do Huu Phuc on 25/4/25.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
