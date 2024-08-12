//
//  BaseViewModel.swift
//  Appmini
//
//  Created by Woo on 8/12/24.
//

import Foundation

protocol BaseViewModel {
    associatedtype Input
    associatedtype Output
    
    func tranform(input : Input) -> Output
}
