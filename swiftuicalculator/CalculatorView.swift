//
//  ContentView.swift
//  swiftuicalculator
//
//  Created by 刘洪博 on 2021/10/25.
//

import SwiftUI

//viewmodel
class CalculatorViewModel:ObservableObject{
    @Published var display : String
    @Published var display2 : String
    var lastans : Bool
    var calculator :calculate
    init(){
        display = "0"
        display2 = ""
        lastans = false
        calculator = swiftuicalculator.calculate()
    }
    
    func buttonTapped(button:CalculatorButton){
        if button.title == "AC"
        {
            clear(button: button)
        }
        else if button.title == "="{
            calculate(button: button)
        }
        else{
            putexpression(button: button)
        }
    }
    func putexpression(button:CalculatorButton) {
        if lastans{
            display2 = display
            display = ""
            lastans = false
        }
        var ele = element()
        ele.op = button.title
        
        if display == "0" && ((ele.op >= "0" && ele.op <= "9") || (ele.op == "(")){
            display = ""
        }
        else if display == "0"{
            var s = element()
            s.op = "0"
            calculator.Input.push(parament: s)
        }
        calculator.Input.push(parament: ele)
        display = display + ele.op
}
    func clear(button:CalculatorButton) {
        calculator = swiftuicalculator.calculate()
       display = "0"
      display2 = ""
       lastans = false
   }
    func calculate(button:CalculatorButton) {
        var ele = element()
        ele.op = button.title
        calculator.Input.push(parament: ele)
        print(calculator.Input.stack)
        if calculator.transition(){
            let (ans,ifok) = calculator.caculate()
            print(ans)
            if ifok{
                calculator = swiftuicalculator.calculate()
                display2 = display
                display = String(ans)
                lastans = true
            }
            else{
                calculator = swiftuicalculator.calculate()
                display2 = display
                display = "error"
                lastans = true
            }
        }
        else{
            calculator = swiftuicalculator.calculate()
            display2 = display
           display = "error"
            lastans = true
        }
        
    }
    
}



struct CalculatorView: View {
  @ObservedObject var vm = CalculatorViewModel()
  
    
    let spacing:CGFloat = 12
   
    
    var body: some View {
        
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            GeometryReader{geometry in
        VStack(alignment: .center,spacing: self.spacing){
            Spacer()
        
            HStack{
                Spacer()
                Text(self.vm.display2)
                    .font(.system(size: geometry.size.height*0.05))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.trailing)
                
            }.padding(.horizontal,self.spacing)
            Spacer()
                HStack{
                    Spacer()
                    Text(self.vm.display)
                        .font(.system(size: geometry.size.height*0.08))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.trailing)
                    
                }.padding(.horizontal,self.spacing)
            
            Spacer()
           
            VStack{
            ForEach(buttonsRows,id:\.self){
                buttonrow in
                CalculatorButtonRow(screenHeight:geometry.size.height*0.77, screenWidth: geometry.size.width, spacing: self.spacing, buttons: buttonrow,didTapButton: self.vm.buttonTapped)
            }
            
                }
            }
            }
        }
        }
    }



























struct Calculator_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView().preferredColorScheme(.light)
        CalculatorView().preferredColorScheme(.dark)
       
    }
}
