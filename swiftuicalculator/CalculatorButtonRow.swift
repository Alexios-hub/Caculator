//
//  CalculatorButtonRow.swift
//  swiftuicalculator
//
//  Created by 刘洪博 on 2021/10/30.
//

import SwiftUI

struct CalculatorButtonRow: View {
    let screenHeight:CGFloat
    let screenWidth:CGFloat
    let spacing:CGFloat
    let buttons:[CalculatorButton]
    private func getButtonGridWidth()->CGFloat{
        return (self.screenWidth-self.spacing*5)/4
    }
    private func getButtonGridHeight()->CGFloat{
        return(self.screenHeight-self.spacing*6)/5
    }
    private func getButtonWidth(title:String)->CGFloat{
        return title != "0" ?  getButtonGridWidth():getButtonGridWidth()*2 + spacing
    }
    
    
    var didTapButton:(CalculatorButton)->()
    
    
    
    var body: some View {
        HStack{
            ForEach(self.buttons){
                button in Button(action: {
                    self.didTapButton(button)
                }){
                    Text(button.title)
                .font(.system(size: 28))
                .foregroundColor(.white)
                .frame(width: getButtonWidth(title: button.title), height: getButtonGridHeight())
                .background(button.color)
                .cornerRadius(100)
                }
               
    }
}
    }
}

struct CalculatorButtonRow_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader{
            geomotry in
            CalculatorButtonRow(screenHeight:geomotry.size.height,screenWidth: geomotry.size.width, spacing: 12, buttons: buttonsRows[0],didTapButton: {
                button in print("Button\(button.title)")
            })
        }
       
    }
}
