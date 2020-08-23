//
//  main.swift
//  mousePosition
//
//  Created by Nils Bergmann on 23/08/2020.
//  Copyright © 2020 Nils Bergmann. All rights reserved.
//

import Foundation
import AppKit

let mouseLocation = NSEvent.mouseLocation
let screens = NSScreen.screens
for screen in screens {
    let id = (screen.deviceDescription as NSDictionary).object(forKey: "NSScreenNumber") as! NSNumber;
    let xMin = screen.frame.origin.x;
    let xMax = xMin + screen.frame.width;
    let isOnDisplay: Bool = mouseLocation.x > xMin && mouseLocation.x < xMax;
    if isOnDisplay {
        print(id);
        exit(0)
    }
}
