//
//  HeaderView.swift
//  TipCalculator
//
//  Created by ahdivio mendes on 19/08/23.
//
import UIKit

class HeaderView: UIView {
  
  private let topLabelView: UILabel = {
    let label = LabelView.buildLabel(text: nil, font: ThemeFont.bold(size: 18))
    return label
  }()
  
  
  private let bottomLableView: UILabel = {
    let label  = LabelView.buildLabel(text: nil, font: ThemeFont.regular(size: 16))
    return label
  }()
  
  
  private let topSpacerView: UIView  = {
    UIView.sapcerView()
  }()
  
  
  private let bottomSpacerView: UIView = {
    UIView.sapcerView()
  }()
  
  private lazy var vstack: UIStackView = {
    let stack = CustomStackView(frame: .zero, orientation: .vertical, spacing: -4)
    stack.alignment = .leading
    stack.addArrangedSubviews([
      topSpacerView,
      topLabelView,
      bottomLableView,
      bottomSpacerView
    ])
    return stack
  }()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
  private final func layout() {
    addSubview(vstack)
    vstack.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    topSpacerView.snp.makeConstraints { make in
      make.height.equalTo(bottomSpacerView)
    }
  }
}


//MARK: - configuring the text of the view
extension HeaderView {
  final func configure(topLabel: String, bottonlabel: String) {
    topLabelView.text = topLabel
    bottomLableView.text = bottonlabel
  }
}
