//
//  TipCalculatorTests.swift
//  TipCalculatorTests
//
//  Created by ahdivio mendes on 15/08/23.
//

import XCTest
import Combine
@testable import TipCalculator

final class TipCalculatorTests: XCTestCase {
  
  private var sut: CalculatorVm!
  private var cancellables: Set<AnyCancellable>!
  private var logoViewTapSubject: PassthroughSubject<Void, Never>!
  private var audioPlayerService: MockAudioPlayerService!
  
  override func setUp() {
    audioPlayerService = .init()
    sut = .init(audioPlayerService: audioPlayerService)
    cancellables = .init()
    logoViewTapSubject = .init()
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
    sut = nil
    cancellables = nil
    logoViewTapSubject = nil
  }
  
  //MARK: test without tip and one person
  func testResultWithoutTipForOnePerson() {
    
    let bill = 100.0
    let tip: Tip = .none
    let split = 1
    let input = billdInput(bill: bill, tip: tip, split: split)
    
    let output = sut.transformInput(input: input)
    
    output.updateViewPublisher.sink { result in
      XCTAssertEqual(result.amountPerPerson, 100)
      XCTAssertEqual(result.totalBill, 100)
      XCTAssertEqual(result.totalTip, 0)
    }.store(in: &cancellables)
    
  }
  
  //MARK: test without tip and 2 person
  func testResultWithoutTipFor2Person() {
    
    let bill: Double = 100.0
    let tip: Tip = .none
    let split: Int = 2
    let input = billdInput(
      bill: bill,
      tip: tip,
      split: split)
    
    let output = sut.transformInput(input: input)
    
    output.updateViewPublisher.sink { result in
      XCTAssertEqual(result.amountPerPerson, 50)
      XCTAssertEqual(result.totalBill, 100)
      XCTAssertEqual(result.totalTip, 0)
    }.store(in: &cancellables)
  }
  
  
  //MARK: test with tip of 10 percent and two person
  func testResultTipForTwoPerson() {
    
    let bill = 100.0
    let tip: Tip = .tenPercent
    let split = 2
    let input = billdInput(bill: bill, tip: tip, split: split)
    
    let output = sut.transformInput(input: input)
    
    output.updateViewPublisher.sink { result in
      XCTAssertEqual(result.amountPerPerson, 55)
      XCTAssertEqual(result.totalBill, 110)
      XCTAssertEqual(result.totalTip, 10)
    }.store(in: &cancellables)
    
  }
  
  
  //MARK: test audio service
  func testAudioService() {
    let input = billdInput(bill: 100.0, tip: .tenPercent, split: 2)
    let outPut = sut.transformInput(input: input)
    let expectation1 = XCTestExpectation(description: "reset calculator called")
    let expectation2 = audioPlayerService.expectation
    outPut.resetCalculatorPublisher.sink { _ in
      expectation1.fulfill()
    }.store(in: &cancellables)
    logoViewTapSubject.send()
    wait(for: [expectation1, expectation2], timeout: 1.0)
  }
  

}

//MARK: Audio service implementation
class MockAudioPlayerService: AudioPlayerService {
  var expectation = XCTestExpectation(description: "playSound is called")
  func playAudio() {
    expectation.fulfill()
  }
}


//MARK: build Intput
extension TipCalculatorTests {
  final private func billdInput(bill: Double, tip: Tip, split: Int) -> CalculatorVm.Input {
    return .init(
      billPublisher: Just(bill).eraseToAnyPublisher(),
      tipPublisher: Just(tip).eraseToAnyPublisher(),
      splitPublisher: Just(split).eraseToAnyPublisher(),
      logoViewTapPublisher: logoViewTapSubject.eraseToAnyPublisher())
  }
}




