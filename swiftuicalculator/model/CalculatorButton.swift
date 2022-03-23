//
//  CalculatorButton.swift
//  swiftuicalculator
//
//  Created by 刘洪博 on 2021/10/30.
//

import SwiftUI

extension Color{
    static let lightGray = Color(red: 0.6, green: 0.6, blue: 0.6)
    static let darkGray = Color(red: 0.2, green: 0.2, blue: 0.2)
}

struct CalculatorButton:Identifiable,Hashable{
    let id = UUID()
    let title:String
    var color = Color.darkGray
}
let buttonsRows:[[CalculatorButton]] = [
    [.init(title: "AC", color:Color.lightGray),
    .init(title: "(", color:Color.lightGray),
    .init(title: ")", color:Color.lightGray),
    .init(title: "+", color: Color.orange)],
    [.init(title: "7"),
    .init(title: "8"),
    .init(title: "9"),
    .init(title: "X",color: Color.orange)],
    [.init(title: "4"),
    .init(title: "5"),
    .init(title: "6"),
    .init(title: "-",color: Color.orange)],
    [.init(title: "1"),
    .init(title: "2"),
    .init(title: "3"),
    .init(title: "+",color: Color.orange)],
    [.init(title: "0"),
    .init(title: "."),
    .init(title: "=",color: Color.orange)],
                               
                               
]
