//
//  TipInputView.swift
//  TipCalculator
//
//  Created by ahdivio mendes on 16/08/23.
//

import UIKit

class TipInputView: UIView {
  private let headerView: HeaderView = {
    let headerView = HeaderView(frame: .zero)
    headerView.configure(topLabel: "Choose", bottonlabel: "your tip")
    return headerView
  }()
  
  init() {
    super.init(frame: .zero)
    layout()
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
    return btn
  }()
  
  private lazy var twentyPercentBtn: UIButton = {
    let btn = buildTipInputBttn(tip: Tip.twentyPercent)
    return btn
  }()
  
  private lazy var fiftyPercentBtn: UIButton = {
    let btn = buildTipInputBttn(tip: Tip.fiftyPercent)
    return btn
  }()
  
  
  private let customBtnView: UIButton = {
    let btn = UIButton()
    btn.setTitle("Custom tip", for: .normal)
    btn.titleLabel?.font = ThemeFont.bold(size: 20)
    btn.backgroundColor = ThemeColour.primary
    btn.tintColor = UIColor.white
    btn.addCornerRadius(radius: 8.0)
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


enum Tip {
  case none
  case tenPercent
  case fiftyPercent
  case twentyPercent
  case custome(value: Int)
  
  var stringValue:String {
    switch self {
    case .none:
      return ""
    case .tenPercent:
      return "10%"
    case .fiftyPercent:
      return "50%"
    case .twentyPercent:
      return "20%"
    case .custome(let value):
      return String(value)
    }
  }
}
