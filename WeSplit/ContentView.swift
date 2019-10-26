//
//  ContentView.swift
//  WeSplit
//
//  Created by Marcelo Hammes on 25/10/19.
//  Copyright © 2019 Marcelo Hammes. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State private var checkAmount = ""
  @State private var numberOfPeople = 2
  @State private var tipPercentage = 2

  let tipPercentages = [10, 15, 20, 25, 0]

  var total: Double {
    let tipSelection = Double(tipPercentages[tipPercentage])
    let orderAmount = Double(checkAmount) ?? 0

    let tipValue = orderAmount / 100 * tipSelection
    let grandTotal = orderAmount + tipValue

    return grandTotal
  }

  var totalPerPerson: Double {
    let peopleCount = Double(numberOfPeople + 2)
    let amountPerson = total / peopleCount

    return amountPerson
  }

  var body: some View {
    NavigationView {
      Form {
        Section {
          TextField("Amount", text: $checkAmount)
            .keyboardType(.decimalPad)
        }

        Section(header: Text("How much tip do you want to leave?")) {
          Picker("Tip percentage", selection: $tipPercentage) {
            ForEach(0..<tipPercentages.count) {
              Text("\(self.tipPercentages[$0])%")
            }
          }
          .pickerStyle(SegmentedPickerStyle())
        }

        Section(header: Text("Amount per person")) {
          Picker("Number of people", selection: $numberOfPeople) {
            ForEach(2..<100) {
              Text("\($0) people")
            }
          }
        }

        Section {
          Text("$\(totalPerPerson, specifier: "%.2f")")
        }

        Section(header: Text("Total amount of the check")) {
          Text("$\(total, specifier: "%.2f")")
        }
      }
      .navigationBarTitle("WeSplit")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
