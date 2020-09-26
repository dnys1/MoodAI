//
//  KeyboardResponder.swift
//  MoodAI
//
//  Created by Dillon Nys on 9/7/20.
//

import SwiftUI

class KeyboardResponder: ObservableObject {
    static let shared = KeyboardResponder()
    @Published var isShowing: Bool = false
    
    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        isShowing = true
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        isShowing = false
    }
}
