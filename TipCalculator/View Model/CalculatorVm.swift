//
//  CalculatorVm.swift
//  TipCalculator
//
//  Created by ahdivio mendes on 27/08/23.
//

import Foundation
import Combine

//MARK: - publishers
class CalculatorVm {
  struct Input{
    let billPublisher: AnyPublisher<Double, Never>
    let tipPublisher: AnyPublisher<Tip, Never>
    let splitPublisher: AnyPublisher<Int, Never>
    //let logoViewTapPublisher: AnyPublisher<Void, Never>
  }
  struct Output {
    let updateViewPublisher: AnyPublisher<Result, Never>
  }
  
  private var cancellables = Set<AnyCancellable>()
}


//MARK: - transform func
extension CalculatorVm {
  final  func transformInput(input: Input) -> Output{
//    input.tipPublisher.sink { tip in
//      print("tip tapped value >>>>", tip)
//    }.store(in: &cancellables)
    
    let updatePublishers = Publishers.CombineLatest3(input.billPublisher, input.tipPublisher, input.splitPublisher).flatMap {[unowned self] (bill, tip, split) in
      let totalTip = getTipAmount(bill: bill, tip: tip)
      let totalBill = bill + totalTip
      let amountPerPerson = totalBill / Double(split)
      let result = Result(
        amountPerPerson: amountPerPerson,
        totalBill: totalBill,
        totalTip: totalTip)
      return Just(result)
    }.eraseToAnyPublisher()
    return Output(updateViewPublisher: updatePublishers)
  }
  
  
  final func getTipAmount(bill: Double, tip: Tip) -> Double {
    switch tip {
    case .none:
      return 0
    case .tenPercent:
      return bill * 0.1
    case .fiftyPercent:
      return bill * 0.15
    case .twentyPercent:
      return bill * 0.2
    case .custom(let value):
      return Double(value)
    }
  }
}


struct Result {
  let amountPerPerson: Double
  let totalBill: Double
  let totalTip: Double
}
