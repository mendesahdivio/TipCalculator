//
//  AmountView.swift
//  TipCalculator
//
//  Created by ahdivio mendes on 17/08/23.
//

import UIKit
class AmountView: UIView {
  private let textAlignment: NSTextAlignment
  private let title: String
  
  private lazy var titleLabel: UILabel = {
    LabelView.buildLabel(
      text: title,
      font: ThemeFont.regular(size: 18),
      textColour: ThemeColour.textColour,
      textAlignment: textAlignment)
  }()
  
  private lazy var amountLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = textAlignment
    label.textColor = ThemeColour.primary
    let text = NSMutableAttributedString(
      string: "$000",
      attributes: [
        .font: ThemeFont.bold(size: 24)
      ])
    text.addAttributes([
      .font: ThemeFont.bold(size: 16)
    ], range: NSMakeRange(0, 1))
    label.attributedText = text
    return label
  }()
  
  
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [
      titleLabel,
      amountLabel
    ])
    stackView.axis = .vertical
    return stackView
  }()
  
  
  init(textAlignment: NSTextAlignment, title: String) {
    self.textAlignment = textAlignment
    self.title = title
    super.init(frame: .zero)
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


extension AmountView {
  final private func layout() {
    addSubview(stackView)
    stackView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}
