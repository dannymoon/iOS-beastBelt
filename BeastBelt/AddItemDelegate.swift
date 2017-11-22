//
//  AddItemDelegate.swift
//  BeastBelt
//
//  Created by Danny Moon on 11/19/17.
//  Copyright © 2017 Danny Moon. All rights reserved.
//

import UIKit

protocol AddItemDelegate: class {
    func just(controller: JustBeastitViewController, added title: String, date: Date, complete: Bool)
    func edit(controller: JustBeastitViewController, edited title: String, date: Date, complete: Bool)
}
