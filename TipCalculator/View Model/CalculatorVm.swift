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
    input.tipPublisher.sink { tip in
      print("tip tapped value >>>>", tip)
    }.store(in: &cancellables)
    let result = Result(amountPerPerson: 250, totalBill: 500, totalTip: 50)
    return Output(updateViewPublisher: Just(result).eraseToAnyPublisher())
  }
}


struct Result {
  let amountPerPerson: Double
  let totalBill: Double
  let totalTip: Double
}
