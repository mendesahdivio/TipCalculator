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
    let logoViewTapPublisher: AnyPublisher<Void, Never>
  }
  
  struct Output {
    let updateViewPublisher: AnyPublisher<Result, Never>
    let resetCalculatorPublisher: AnyPublisher<Void, Never>
  }
  
  private var cancellables = Set<AnyCancellable>()
  private let audioPlayerService: AudioPlayerService
  
  init(audioPlayerService: AudioPlayerService = DefaultAudioPlayer()) {
    self.audioPlayerService = audioPlayerService
  }
}


//MARK: - transform func
extension CalculatorVm {
  final  func transformInput(input: Input) -> Output{
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
    
    let resultCalculatorPublisher = input.logoViewTapPublisher.handleEvents(receiveOutput: { [unowned self] in
      audioPlayerService.playAudio()
    }).flatMap {
      return Just($0)
    }.eraseToAnyPublisher()
    
    return Output(updateViewPublisher: updatePublishers, resetCalculatorPublisher: resultCalculatorPublisher)
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
