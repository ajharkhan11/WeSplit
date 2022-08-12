//
//  ContentView.swift
//  WeSplit
//
//  Created by Ajharudeen Khan on 01/08/22.
//

import SwiftUI

struct ContentView: View {
    //bill amount need to disributed
    @State private var billAmount = 0.0
    
    //number of distribution
    @State private var numberOfPeople = 0
    
    //tip percentage
    @State private var tipPercentage = 20;
    
        @FocusState private var amountIsFocused : Bool
    
    private var totalPerPerson : Double{
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = billAmount/100 * tipSelection
        let grandTotal = billAmount + tipValue
        
        let perPerson = grandTotal/peopleCount
        return perPerson
    }
    
    private var totalBillAmout : Double{
        let tipSelection = Double(tipPercentage)
        
        let tipValue = billAmount/100 * tipSelection
        let grandTotal = billAmount + tipValue
        return grandTotal;
    }

    
    private var tipPercentages = [10,15,20,25,30]
    
    
    var body: some View {
        NavigationView {
            Form{
                Section{
                    TextField("Amount", value: $billAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100){
                            Text("\($0) People")
                        }
                    }
                }
                
                Section{
                    Picker("Tip", selection: $tipPercentage) {
                        ForEach(0..<100){
                            Text($0,format: .percent)
                        }
                    }
                } header: {
                    Text("How much Tip do you want to leave?")
                }
                
                Section{
                    Text(totalBillAmout,format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Total Amount To be Paid")
                }
                
                Section{
                    Text(totalPerPerson,format:.currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
