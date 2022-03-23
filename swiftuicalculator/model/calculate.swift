//
//  calculate.swift
//  swiftuicalculator
//
//  Created by 刘洪博 on 2021/10/31.
//

import Foundation
class calculate {
    var Input : stack
    var Output: stack
    var ds : stack
    var op : stack
    init() {
        Input = stack()
        ds = stack()
        op = stack()
        Output = stack()
    }
    func isp(ch:String) -> Int{//栈内优先级
        switch ch {
        case "(":
            return 1
        case "X":
            return 5
        case "÷":
            return 5
        case "+":
            return 3
        case "-":
            return 3
        case ")":
            return 8
        case "=":
            return 0
        default:
            return -1
        }
    }
    func icp(ch:String) -> Int {//栈外优先级
        switch ch {
        case "(":
            return 8
        case"X":
            return 4
        case"÷":
            return 4
        case "+":
            return 2
        case "-":
            return 2
        case ")":
            return 1
        case"=":
            return 0
        default:
            return -1
        }
    }
    func  transition() ->Bool{
        if  Input.stack[0].op == ")"{
            return false
        }
        var ch = "="
        var memory = "="
        var ele = element()
        ele.op = "="
        op.stack.append(ele)
       var ifm = true
        while Input.stack.count > 0{
            if ifm{
                memory = ch
            }
            ifm = true
            ch = Input .stack[0].op
            if Input.stack.count == 2 && ((Input.stack[0].op < "0" || Input.stack[0].op > "9") && Input.stack[0].op != ")"){
                return false
            }
            else if ((memory < "0" || memory > "9") && memory !=  ")") && memory.count == 1 && (ch == "X" || ch == "÷"){
                return false
            }
            else  if (memory < "0" || memory > "9") && memory.count == 1 && memory != ")" && (ch == "+" || ch == "-"){
                if Input.stack.count >= 2{
                    let st = Input .stack[1].op
                    if st >= "0" && st <= "9"{
                        if ch == "+"{
                            Input.stack.remove(at: 0)
                            var e = element()
                            e.d = turndigit(ch: st)
                            ds.push(parament: e)
                            memory = "+" + ch
                            ifm = false
                        }
                        else if ch == "-"{
                            Input.stack.remove(at: 0)
                            var e = element()
                            e.d = 0 - turndigit(ch: st)
                            ds.push(parament: e)
                            memory = "-" + ch
                            ifm = false
                        }

                    }
                    else {return false}
                }
                else{
                    return false
                }
            }
           else if ch >= "0" && ch <= "9"{
                var e = element()
                e.d = turndigit(ch: ch)
                ds.push(parament: e)
            }
            else{
                if icp(ch : ch)>isp(ch: op.stack[op.stack.count-1].op){
                    if isp(ch: op.stack[op.stack.count-1].op) == -1{
                        return false
                    }
                    var e = element()
                    e.op = ch
                    op.push(parament: e)
                    Input.stack.remove(at: 0)
                }
                else if icp(ch: ch)<isp(ch: op.stack[op.stack.count-1].op){
                    while icp(ch: ch)<isp(ch: op.stack[op.stack.count-1].op){
                        if icp(ch:ch) == -1{
                            return false
                        }
                        if op.stack.count == 0{
                            return false
                        }
                        if ds.stack.count == 1{
                            return false
                        }
                        let opp = op.pop().op
                       
                        var e = element()
                        switch opp {
                        case "+":
                            let y:Float = ds.pop().d
                            let x:Float = ds.pop().d
                            e.d = x + y
                            ds.push(parament: e)
                            break
                        case "-":
                            let y:Float = ds.pop().d
                            let x:Float = ds.pop().d
                           e.d = x - y
                           ds.push(parament: e)
                            break
                        case "X":
                            let y:Float = ds.pop().d
                            let x:Float = ds.pop().d
                            e.d = x * y
                            ds.push(parament: e)
                            break
                        case "÷":
                            let y:Float = ds.pop().d
                            let x:Float = ds.pop().d
                            e.d = x / y
                            ds.push(parament: e)
                            break
                        default:
                            return false
                        }
                    }
                    if ch == ")" && op.stack[op.stack.count-1].op == "("{
                        op.pop()
                    }
                    
                    else{
                    var e = element()
                        e.op = ch
                    op.push(parament: e)
                    }
                    Input.stack.remove(at: 0)
                }
                else{
                    if ch == ")"{
                        Input.stack.remove(at: 0)
                        memory = ch
                        ch = Input.stack[0].op
                        op.pop()
                    }
                    else {Input.stack.remove(at: 0)
                       
                    }
                }
            }
            
        }
     print("\(op)")
        return true
    }
    func turndigit(ch:String) -> Float {
        var ans :Float = 0
        var ansstr : String = ""
        var c = ch
        while c >= "0" && c <= "9" {
            ansstr = ansstr + c
            Input.stack.remove(at: 0)
            c = Input.stack[0].op
        }
        if c == "."{
            ansstr = ansstr + "."
            Input.stack.remove(at: 0)
            c = Input.stack[0].op
           
            while c >= "0" && c <= "9" {
                ansstr = ansstr + c
               
                Input.stack.remove(at: 0)
                c = Input.stack[0].op
            }
           
        }
        ans = (ansstr as NSString).floatValue
        print("ans\(ans)")
        return ans
    }
    func caculate() -> (Float,Bool) {
        if ds.stack.count == 0
        {
            return (0,true)
        }
        while ds.stack.count > 1 {
            if(op.stack.count == 1){
                return(-1,false)
            }
            let opp = op.pop().op
            if opp == "(" || opp == ")" {
                return(-1,false)
            }
            let y:Float = ds.pop().d
            let x:Float = ds.pop().d
            var e = element()
            switch opp {
            case "+":
                e.d = x + y
                ds.push(parament: e)
                break
            case "-":
               e.d = x - y
               ds.push(parament: e)
                break
            case "X":
                e.d = x * y
                ds.push(parament: e)
                break
            case "÷":
                e.d = x / y
                ds.push(parament: e)
                break
            default:
                return(-1,false)
            }
        }
        return (ds.stack[0].d,true)
}
}
