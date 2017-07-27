//
//  Constants.swift
//  Calculator
//
//  Created by Kristina Del Rio Albrechet on 7/10/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import Foundation

// Constants for NotificationCenter
let kChangeStyleColor = NSNotification.Name("ChangeStyleColor")
let kChangeSoundState = NSNotification.Name("ChangeSoundState")
let kChangeAnimationState = NSNotification.Name("ChangeAnimation")
let kChangeFont = NSNotification.Name("ChangeFont")

// Alias for singleton of StyleManager
let style = StyleManager.shared
let input = IntputAdapter.shared
let output = OutputAdapter.shared
let brain = Brain.shared


enum MathOperation: String {
    case sin  = "sin"
    case sqrt = "√"
    case pow  = "^"
    case mul  = "×"
    case div  = "÷"
    case pls  = "+"
    case mns  = "-"
    case ln   = "ln"
    case cos  = "cos"
    case bracketL = "("
    case bracketR = ")"
}

enum ElementForEmitter: String {
    case emitterImage = "emitterImage"
    case birthRate = "birthRate"
    case lifetime = "lifetime"
    case velocity = "velocity"
    case scale = "scale"
    case scaleRange = "scaleRange"
}

enum KeyForUserDefaults: String {
    case soundSwitcher = "soundSwitcher"
    case themeSwitcher = "themeSwitcher"
    case animationSwitcher = "animationSwitcher"
    case appFont = "appFont"

}

enum ElementsOfTheme: String {
    case backgroundColor = "backgroundColor"
    case textColor = "textColor"
    case buttonColor = "buttonColor"
    case utilitybuttonColor = "utilitybuttonColor"
    case equal = "equal"
}
