//
//  ViewController.swift
//  TipCalculator
//
//  Created by ahdivio mendes on 15/08/23.
//

import UIKit
import SnapKit
import Combine


class ViewController: UIViewController {
  //View Tap publisher
  private lazy var viewTapPublisher: AnyPublisher<Void, Never> = {
    let tapGesture = UITapGestureRecognizer(target: self, action: nil)
    view.addGestureRecognizer(tapGesture)
    return tapGesture.tapPublisher.flatMap {[unowned self] _ in
      Just(())
    }.eraseToAnyPublisher()
  }()
  
  //logoView Tap publisher
  private lazy var logoViewTapPublisher: AnyPublisher<Void, Never> = {
    let tapGesture = UITapGestureRecognizer(target: self, action: nil)
    tapGesture.numberOfTapsRequired = 2
    logoView.addGestureRecognizer(tapGesture)
    return tapGesture.tapPublisher.flatMap {[unowned self] _ in
      Just(())
    }.eraseToAnyPublisher()
  }()
  
  
  
  //create views here
  private let logoView = LogoView()
  private let resultView = ResultView()
  private let billInputView = BillInputView()
  private let tipInputView = TipInputView()
  private let sliptInputView = SplitInputView()
  private let calculatorVm = CalculatorVm()
  private var cancellables = Set<AnyCancellable>()
  
  private lazy var stackView: CustomStackView = {
    let stackView = CustomStackView(frame: .infinite, orientation: .vertical, spacing: 36, distribution: .fillProportionally)
    stackView.addArrangedSubviews([logoView, resultView, billInputView, tipInputView, sliptInputView, UIView()])
    return stackView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    layout()
    bind()
    observeTap()
  }

}


extension ViewController {
  final func layout() {
    view.backgroundColor = ThemeColour.bg
    view.addSubview(stackView)
    stackView.snp.makeConstraints { make in
      make.leading.equalTo(view.snp.leadingMargin).offset(16)
      make.trailing.equalTo(view.snp.trailing).offset(-16)
      make.bottom.equalTo(view.snp.bottom).offset(-16)
      make.top.equalTo(view.snp.topMargin).offset(16)
    }
    
    logoView.snp.makeConstraints { make in
      make.height.equalTo(48)
    }
    
    resultView.snp.makeConstraints { make in
      make.height.equalTo(224)
    }
    
    billInputView.snp.makeConstraints { make in
      make.height.equalTo(56)
    }
    
    tipInputView.snp.makeConstraints { make in
      make.height.equalTo((56*2) + 16)
    }
    
    sliptInputView.snp.makeConstraints { make in
      make.height.equalTo(56)
    }
  }
}


//MARK: - view model binding
extension ViewController {
  final private func bind() {
    let input = CalculatorVm.Input(billPublisher: billInputView.valuePublisher, tipPublisher: tipInputView.valuePublisher, splitPublisher: sliptInputView.sliptPublisher, logoViewTapPublisher: logoViewTapPublisher)
    
    let output = calculatorVm.transformInput(input: input)
    output.updateViewPublisher.sink {[unowned self] result in
      resultView.configure(result: result)
    }.store(in: &cancellables)
    
    output.resetCalculatorPublisher.sink { [unowned self] _ in
      billInputView.reset()
      tipInputView.reset()
      sliptInputView.reset()
      UIView.animate(
        withDuration: 0.1,
        delay: 0,
        usingSpringWithDamping: 5.0,
        initialSpringVelocity: 0.5,
        options: .curveEaseInOut) {
          self.logoView.transform = .init(scaleX: 1.5, y: 1.5)
        } completion: { _ in
          UIView.animate(withDuration: 0.1) {
            self.logoView.transform = .identity
          }
        }
    }.store(in: &cancellables)
  }
}


//MARK: Listen to view tap publisher
extension ViewController {
  private func observeTap() {
    viewTapPublisher.sink { [unowned self] _ in
      view.endEditing(true)
    }.store(in: &cancellables)
  }
}
