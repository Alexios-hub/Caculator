//
//  stack.swift
//  swiftuicalculator
//
//  Created by 刘洪博 on 2021/10/31.
//

import Foundation
struct stack {
    var stack:[element]
    init(){
        stack = [element]()
    }
    mutating func push(parament:element){
        stack.append(parament)
    }
    mutating func pop() -> element{
        let ans = stack[stack.count-1]
        print("stack:\(stack.count)")
        stack.remove(at: stack.count-1)
        print("stack:\(stack.count)")
        return ans
    }
    func isEmpty()->Bool{
        if stack.count == 0
        {return true}
        else {return false}
    }
    
    
}
