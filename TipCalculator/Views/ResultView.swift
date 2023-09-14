//
//  ResultView.swift
//  TipCalculator
//
//  Created by ahdivio mendes on 15/08/23.
//

import UIKit
import CombineCocoa
import Combine


class ResultView: UIView {
  private let topLabelView: UILabel = {
    let label = LabelView.buildLabel(text: "Total p/person", font: ThemeFont.regular(size: 16), textAlignment: .center)
    return label
  }()
  
  
  private let amountLabelView: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.textColor = ThemeColour.textColour
    let text = NSMutableAttributedString(string: "\u{20B9} 0", attributes: [.font: ThemeFont.bold(size: 40)])
    text.addAttributes([.font: ThemeFont.bold(size: 24)], range: NSMakeRange(0, 1))
    label.attributedText = text
    label.accessibilityIdentifier = ScreenIdentifiers.ResultView.totalAmountPerPersonValueLabel.rawValue
    return label
  }()
  
  
  private let horizontalLineView: UIView = {
    let view = UIView()
    view.backgroundColor = ThemeColour.seperator
    return view
  }()
  
  
  private lazy var vStackView: UIStackView = {
    let stackView = CustomStackView(frame: .zero, orientation: .vertical, spacing: 8, distribution: .fill)
    stackView.addArrangedSubviews([
      topLabelView,
      amountLabelView,
      horizontalLineView,
      UIView.sapcerView(),
      hStackView
    ])
    return stackView
  }()
  
  
  private let totalBillView: AmountView = {
    let view = AmountView(textAlignment: .left, title: "Total bill", identifier: ScreenIdentifiers.ResultView.totalBillValueLabel.rawValue)
    return view
  }()
  
  private let totalTipView: AmountView = {
    let view = AmountView(textAlignment: .right, title: "Total tip", identifier: ScreenIdentifiers.ResultView.totalTipValueLabel.rawValue)
    return view
  }()
  
  private lazy var hStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [
      totalBillView,
      UIView(),
      totalTipView
    ])
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    return stackView
  }()
  
  init() {
    super.init(frame: .zero)
    layout()
  }
  
  private func layout() {
    backgroundColor = .white
    addSubview(vStackView)
    vStackView.snp.makeConstraints { make in
      make.top.equalTo(snp.top).offset(24)
      make.leading.equalTo(snp.leading).offset(24)
      make.trailing.equalTo(snp.trailing).offset(-24)
      make.bottom.equalTo(snp.bottom).offset(-24)
    }
    
    horizontalLineView.snp.makeConstraints { make in
      make.height.equalTo(2)
    }
    
    addShadow(
      offset: CGSize(width: 0, height: 3),
      color: .black,
      radius: 12.0,
      opacity: 0.1)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

//MARK: Configure view from View model
extension ResultView {
  
  func configure(result: Result) {
    let text = NSMutableAttributedString(string: result.amountPerPerson.currencyString, attributes: [.font: ThemeFont.bold(size: 40)])
    text.addAttributes([.font: ThemeFont.bold(size: 24)], range: NSMakeRange(0, 1))
    amountLabelView.attributedText = text
    totalTipView.configure(amount: result.totalTip)
    totalBillView.configure(amount: result.totalBill)
  }
}
