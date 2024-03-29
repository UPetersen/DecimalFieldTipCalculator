//
//  DecimalField.swift
//
//  Created by Edwin Watkeys on 9/20/19.
//  Copyright © 2019 Edwin Watkeys.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
// restriction, including without limitation the rights to use,
// copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software
// is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.
//



import SwiftUI

struct ContentView : View {
    
    var body: some View {
        TipCalculator()
    }
}




//static var previews: some View {
//    TipCalculator()
//}

struct TipCalculator: View {
    @State var dollarValue: Decimal? = Decimal(1)
    @State var tipRate: Decimal? = Decimal(2)
    
    var tipValue: Decimal? {
        guard let dollarValue = self.dollarValue, let tipRate = self.tipRate else { return nil }
        return dollarValue * tipRate
    }
    
    var totalValue: Decimal? {
        guard let dollarValue = self.dollarValue, let tipValue = self.tipValue else { return nil }
        return dollarValue + tipValue
    }
    
    static var currencyFormatter: NumberFormatter {
        let nf = NumberFormatter()
        nf.numberStyle = .currency
        nf.isLenient = true
        return nf
    }
    
    static var percentFormatter: NumberFormatter {
        let nf = NumberFormatter()
        nf.numberStyle = .percent
        nf.isLenient = true
        return nf
    }
    
    var body: some View {
        ScrollView {
            VStack() {
                VStack {
                    HStack {
                        Text("Check Amount")
                        Divider()
                        DecimalField(label: "Amount", value: $dollarValue, formatter: Self.currencyFormatter)
                    }
                    
                    HStack {
                        Text("Tip Rate")
                        Divider()
                        DecimalField(label: "Rate", value: $tipRate, formatter: Self.percentFormatter)
                    }
                }
                .padding()
                
                VStack {
                    HStack {
                        Text("Tip Amount")
                        Divider()
                        Text(Self.currencyFormatter.string(for: tipValue) ?? "-")
                        Spacer()
                    }
                    HStack {
                        Text("Total")
                        Divider()
                        Text(Self.currencyFormatter.string(for: totalValue) ?? "-")
                        Spacer()
                    }
                }
                .padding()
                Spacer()
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding()
        }
        .resignKeyboardOnDragGesture()

    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TipCalculator()
    }
}
