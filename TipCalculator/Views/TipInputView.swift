//
//  TipInputView.swift
//  TipCalculator
//
//  Created by ahdivio mendes on 16/08/23.
//

import UIKit
import Combine
import CombineCocoa


class TipInputView: UIView {
  private let headerView: HeaderView = {
    let headerView = HeaderView(frame: .zero)
    headerView.configure(topLabel: "Choose", bottonlabel: "your tip")
    return headerView
  }()
  
  init() {
    super.init(frame: .zero)
    layout()
    observe()
  }
  
  final private func buildTipInputBttn(tip: Tip)-> UIButton {
    let bttn = UIButton()
    bttn.backgroundColor = ThemeColour.primary
    bttn.addCornerRadius(radius: 8.0)
    let text = NSMutableAttributedString(
    string: tip.stringValue,
    attributes: [.font: ThemeFont.bold(size: 20),
                 .foregroundColor: UIColor.white
    ])
    
    text.addAttributes([
      .font: ThemeFont.demiBold(size: 14)
    ], range: NSMakeRange(2, 1))
    
    bttn.setAttributedTitle(text, for: .normal)
    
    return bttn
  }
  
  private lazy var tenPercentBtn: UIButton = {
    let btn = buildTipInputBttn(tip: Tip.tenPercent)
    btn.tapPublisher.flatMap({
      Just(Tip.tenPercent)
    }).assign(to: \.value, on: tipSubject)
      .store(in: &cancellables)
    return btn
  }()
  
  private lazy var twentyPercentBtn: UIButton = {
    let btn = buildTipInputBttn(tip: Tip.twentyPercent)
    btn.tapPublisher.flatMap({
      Just(Tip.twentyPercent)
    }).assign(to: \.value, on: tipSubject)
      .store(in: &cancellables)
    return btn
  }()
  
  private lazy var fiftyPercentBtn: UIButton = {
    let btn = buildTipInputBttn(tip: Tip.fiftyPercent)
    btn.tapPublisher.flatMap({
      Just(Tip.fiftyPercent)
    }).assign(to: \.value, on: tipSubject)
      .store(in: &cancellables)
    return btn
  }()
  
  
  private lazy var customBtnView: UIButton = {
    let btn = UIButton()
    btn.setTitle("Custom tip", for: .normal)
    btn.titleLabel?.font = ThemeFont.bold(size: 20)
    btn.backgroundColor = ThemeColour.primary
    btn.tintColor = UIColor.white
    btn.addCornerRadius(radius: 8.0)
    btn.tapPublisher.sink { [weak self] _ in
      self?.handleCustomTipBttn()
    }.store(in: &cancellables)
    return btn
  }()
  
  
  private lazy var hBtnStackView: UIStackView = {
    let hStack = UIStackView(arrangedSubviews: [
      tenPercentBtn,
      twentyPercentBtn,
      fiftyPercentBtn
    ])
    hStack.distribution = .fillEqually
    hStack.spacing = 8
    hStack.axis = .horizontal
    return hStack
  }()
  
  
  private lazy var vBtnStackView: UIStackView = {
    let vStack = UIStackView(arrangedSubviews: [
      hBtnStackView,
      customBtnView
    ])
    vStack.axis = .vertical
    vStack.spacing = 8
    vStack.distribution = .fillEqually
    return vStack
  }()
  
  
  //MARK: tipSubject for input
  private let tipSubject =  CurrentValueSubject<Tip, Never>(.none)
  
  
  //MARK: init cancellables
  private var cancellables = Set<AnyCancellable>()
  

  private func layout() {
    [headerView, vBtnStackView].forEach(addSubview(_:))
    vBtnStackView.snp.makeConstraints { make in
      make.top.bottom.trailing.equalToSuperview()
    }
    headerView.snp.makeConstraints { make in
      make.leading.equalToSuperview()
      make.trailing.equalTo(vBtnStackView.snp.leading).offset(-24)
      make.width.equalTo(68)
      make.centerY.equalTo(vBtnStackView.snp.centerY)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}


//MARK: - func to preapre Alert view for custom button
extension TipInputView {
  final private func handleCustomTipBttn() {
    let alertController: UIAlertController =  {
      let controller = UIAlertController(
      title: "Enter your custom Tip",
      message: nil,
      preferredStyle: .alert)
      controller.addTextField { textField in
        textField.placeholder = "Please make it generous!😋"
        textField.keyboardType = .numberPad
        textField.autocorrectionType = .no
      }
      let cancelAction = UIAlertAction(
        title: "Cancel",
        style: .cancel)
      let okAction = UIAlertAction(
        title: "Ok",
        style: .default) { [weak self] _ in
          guard let text = controller.textFields?.first?.text,
                let value = Int(text) else { return }
          self?.tipSubject.send(.custom(value: value))
        }
      [okAction, cancelAction].forEach(controller.addAction(_:))
      return controller
    }()
    parentViewController?.present(alertController, animated: true)
  }
  
  //reset view on select of other btn
  final private func resetView() {
    [tenPercentBtn,
     twentyPercentBtn,
     fiftyPercentBtn,
     customBtnView].forEach {
      $0.backgroundColor = ThemeColour.primary
    }
    
    let text = NSMutableAttributedString(
      string: "Custom tip",
      attributes: [.font: ThemeFont.bold(size: 20)])
    customBtnView.setAttributedTitle(text, for: .normal)
    
  }
  
  
}


//MARK: -  publisher declared here ------------------------------------------------------------------------
extension TipInputView {
  
  
  //MARK: valuePublisher
  var valuePublisher: AnyPublisher<Tip, Never> {
    return tipSubject.eraseToAnyPublisher()
  }
  
  
  //observe changes in the subject
  final private func observe() {
    tipSubject.sink {[unowned self] tip in
      resetView()
      switch tip {
      case .none:
        break
      case .tenPercent:
        tenPercentBtn.backgroundColor = ThemeColour.secondary
      case .fiftyPercent:
        fiftyPercentBtn.backgroundColor = ThemeColour.secondary
      case .twentyPercent:
        twentyPercentBtn.backgroundColor = ThemeColour.secondary
      case .custom(let value):
        customBtnView.backgroundColor = ThemeColour.secondary
        let text = NSMutableAttributedString(
          string: "$\(value)",
          attributes: [
            .font: ThemeFont.bold(size: 20)
          ])
        text.addAttributes([
          .font: ThemeFont.bold(size: 14)
        ], range: NSMakeRange(0, 1))
        customBtnView.setAttributedTitle(text, for: .normal)
      }
    }.store(in: &cancellables)
  }
}
