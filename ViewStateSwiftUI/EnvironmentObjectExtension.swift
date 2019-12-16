//
//  EnvironmentObjectExtension.swift
//  ViewStateSwiftUI
//
//  Created by nhatle on 12/16/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import SwiftUI

extension EnvironmentObject {
    var safeToUse: Bool {
        return (Mirror(reflecting: self).children.first(where: { $0.label == "_store" })?.value as? ObjectType) != nil
    }
}
