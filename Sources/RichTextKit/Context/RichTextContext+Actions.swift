//
//  RichTextContext+Actions.swift
//  RichTextKit
//
//  Created by Daniel Saidi on 2022-12-08.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension RichTextContext {

    /**
     Whether or not the context can trigger a certain action.

     - Parameters:
       - action: The action to trigger.
     */
    func canTriggerRichTextAction(_ action: RichTextAction) -> Bool {
        switch action {
        case .copy: return canCopy
        case .dismissKeyboard: return true
        case .incrementFontSize: return true
        case .decrementFontSize: return true
        case .increaseIndent: return canIncreaseIndent
        case .decreaseIndent: return canDecreaseIndent
        case .print: return false
        case .redoLatestChange: return canRedoLatestChange
        case .undoLatestChange: return canUndoLatestChange
        }
    }

    /**
     Trigger a certain rich text action.

     - Parameters:
       - action: The action to trigger.
     */
    func triggerRichTextAction(_ action: RichTextAction) {
        let stepSize = RichTextIndentDefaults.stepSizeInPoints
        
        switch action {
        case .copy: copyCurrentSelection()
        case .dismissKeyboard: stopEditingText()
        case .incrementFontSize: incrementFontSize()
        case .decrementFontSize: decrementFontSize()
        case .increaseIndent: increaseIndent(points: stepSize)
        case .decreaseIndent: decreaseIndent(points: stepSize)
        case .print: return
        case .redoLatestChange: redoLatestChange()
        case .undoLatestChange: undoLatestChange()
        }
    }
}
