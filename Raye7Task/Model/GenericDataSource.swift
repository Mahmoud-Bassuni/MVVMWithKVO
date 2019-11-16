//
//  GenericDataSource.swift
//  Raye7Task
//
//  Created by Bassuni on 11/16/19.
//  Copyright © 2019 Bassuni. All rights reserved.
//
import Foundation
import UIKit
class GenericDataSource<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
}
