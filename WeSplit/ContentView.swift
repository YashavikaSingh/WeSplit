//
//  ContentView.swift
//  WeSplit
//
//  Created by Yashavika Singh on 01.06.24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var perperson : Double
    {
        let a = Double(checkAmount)*(1 + Double(tipPercentage)/100)
        let totalpeople  = Double(numberOfPeople) + 2
        let perperson = a/totalpeople
        return perperson
    }
    
    var body: some View {
        NavigationStack {
            Form{
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency? .identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople)
                    {
                        ForEach(2..<100)
                        {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section("How much do you want to tip? "){
                Picker("Tip Percentage ", selection: $tipPercentage)
                    {
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Amount each person has to pay"){
                    Text(perperson, format: .currency(code: Locale.current.currency? .identifier ?? "USD"))
                }
            }.navigationTitle("We Split")
                .toolbar{
                    if amountIsFocused{
                         Button("Done")
                        {
                            amountIsFocused = false
                        }
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
