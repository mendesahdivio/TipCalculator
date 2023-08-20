//
//  LogoView.swift
//  TipCalculator
//
//  Created by ahdivio mendes on 15/08/23.
//

import UIKit

class LogoView: UIView {
  
  private let imageView: UIImageView = {
    let imageView = UIImageView(image: .init(named: "icCalculatorBW"))
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  
  private let topLabel: UILabel = {
    let label = UILabel()
    let text = NSMutableAttributedString(string: "Mr Tip", attributes: [.font: ThemeFont.demiBold(size: 16)])
    text.addAttributes([.font:ThemeFont.bold(size: 24)], range: NSMakeRange(3, 3))
    label.attributedText = text
    label.textColor = ThemeColour.textColour
    label.textAlignment = .center
    return label
  }()
  
  
  private let bottomLabel: UILabel = {
    LabelView.buildLabel(text: "Calculator", font: ThemeFont.demiBold(size: 20), textAlignment: .left)
  }()
  
  
  private lazy var vStackView: UIStackView = {
    let vStack = CustomStackView(frame: .zero, orientation: .vertical, spacing: -4, distribution: .fill)
    vStack.addArrangedSubviews([
      topLabel,
      bottomLabel,
    ])
    return vStack
  }()
  
  
  
  private lazy var hStack: CustomStackView = {
    let hStack = CustomStackView(frame: .zero, orientation: .horizontal, spacing: 5, distribution: .fill)
    hStack.addArrangedSubviews([
      imageView,
      vStackView
    ])
    hStack.alignment = .center
    return hStack
  }()
  
  
  
  init() {
    super.init(frame: .zero)
    layout()
  }
  
  private func layout() {
    addSubview(hStack)
    hStack.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview()
      make.centerX.equalToSuperview()
    }
    
    imageView.snp.makeConstraints { make in
      make.height.equalTo(imageView.snp.height)
      //TODO: make this more depedent on auto layout
      make.width.equalTo(40)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
