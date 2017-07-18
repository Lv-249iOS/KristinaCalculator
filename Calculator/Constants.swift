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
