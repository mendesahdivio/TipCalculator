//
//  SplitInputView.swift
//  TipCalculator
//
//  Created by ahdivio mendes on 16/08/23.
//

import UIKit
import Combine
import CombineCocoa

class SplitInputView: UIView {
  //MARK: subject
  private let splitSubject = CurrentValueSubject<Int, Never>(1);
  
  
  
  //MARK: valuePublisher
  var sliptPublisher: AnyPublisher<Int, Never> {
    return splitSubject.removeDuplicates().eraseToAnyPublisher()
  }
  
  
  //MARK: cancellables
  private var cancelables = Set<AnyCancellable>()
  
  
  private let headerLabelView: HeaderView = {
    let headerView = HeaderView()
    headerView.configure(topLabel: "Split", bottonlabel: "the total")
    return headerView
  }()
  
  private lazy var decrementBttnView: UIButton = {
    let bttn = buildButton(
      text: "-",
      corners: [.layerMinXMaxYCorner,
      .layerMinXMinYCorner])
    bttn.tapPublisher.flatMap { [unowned self] _ in
      Just(splitSubject.value == 1 ? 1 : splitSubject.value - 1)
    }.assign(to: \.value, on: splitSubject).store(in: &cancelables)
    return bttn
  }()
  
  private lazy var incrementBttnView: UIButton = {
    let bttn = buildButton(
      text: "+",
      corners: [.layerMaxXMinYCorner,
                .layerMaxXMaxYCorner])
    bttn.tapPublisher.flatMap { [unowned self] _ in
      Just(splitSubject.value + 1)
    }.assign(to: \.value, on: splitSubject).store(in: &cancelables)
    return bttn
  }()
  
  
  private let quantityLabelView: UILabel = {
    let labelView = LabelView.buildLabel(text: "1", font: ThemeFont.bold(size: 20), backgroundColour: .white)
    return labelView
  }()
  
  
  private lazy var hStackView: UIStackView = {
    let hStackView  = UIStackView(arrangedSubviews: [
      decrementBttnView,
      quantityLabelView,
      incrementBttnView
    ])
    hStackView.axis = .horizontal
    hStackView.spacing = 0
    return hStackView
  }()
  
  
  init() {
    super.init(frame: .zero)
    layout()
    observe()
  }
  
  private func layout() {
    [headerLabelView, hStackView].forEach(addSubview(_:))
    hStackView.snp.makeConstraints { make in
      make.top.bottom.trailing.equalToSuperview()
    }
    
    [incrementBttnView, decrementBttnView].forEach { button in
      button.snp.makeConstraints { make in
        make.width.equalTo(button.snp.height)
      }
    }
    
    headerLabelView.snp.makeConstraints { make in
      make.leading.equalToSuperview()
      make.centerY.equalTo(hStackView.snp.centerY)
      make.trailing.equalTo(hStackView.snp.leading).offset(-24)
      make.width.equalTo(68)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  final private func buildButton(text: String, corners: CACornerMask) -> UIButton {
    let button = UIButton()
    button.setTitle(text, for: .normal)
    button.titleLabel?.font = ThemeFont.bold(size: 20)
    button.backgroundColor = ThemeColour.primary
    button.addRoundedCorners(corners: corners, radius: 8.0)
    return button
  }
}


extension SplitInputView {
  
  final private func observe() {
    splitSubject.sink { [unowned self] quantity in
      quantityLabelView.text = quantity.stringValue
    }.store(in: &cancelables)
  }
  
}
