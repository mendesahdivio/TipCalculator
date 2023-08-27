//
//  BillInputView.swift
//  TipCalculator
//
//  Created by ahdivio mendes on 16/08/23.
//

import UIKit

class BillInputView: UIView {
  
  private let headerView: HeaderView = {
    let view = HeaderView()
    view.configure(
      topLabel: "Enter",
      bottonlabel: "your bill")
    return view
  }()
  
  private let textFieldContainerView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.addCornerRadius(radius: 8.0)
    return view
  }()
  
  
  private let currencyDenominationLabel: UILabel = {
    let label = LabelView.buildLabel(text: "$", font: ThemeFont.bold(size: 24))
    label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    return label
  }()
  
  
  
  private lazy var textField: UITextField = {
    let textField = CustomTextFieldView(borderStyle: .none, keyBoardType: .decimalPad, tintColour: ThemeColour.textColour, textColour: ThemeColour.textColour, font: ThemeFont.bold(size: 28))
    
    let customToolBar = CustomKeyBoard(frame:  CGRect(x: 0, y: 0, width: frame.size.width, height: 36), sizeToFit: true, enableUserInteraction: true)
    customToolBar.setBarstyle(barStyle: .default)
    
    let doneButton = UIBarButtonItem(
      title: "Done",
      style: .plain,
      target: self,
      action: #selector(doneButtonTapped))
    
    customToolBar.additems(items: [
      UIBarButtonItem(
        barButtonSystemItem: .flexibleSpace,
        target: nil,
        action: nil),
      doneButton
    ])
    
    textField.setAccessorView(view: customToolBar)
    
    return textField;
  }()
  
  
  
  init() {
    super.init(frame: .zero)
    layout()
  }
  
  private func layout() {
    [headerView, textFieldContainerView].forEach(addSubview(_:))
    
    headerView.snp.makeConstraints { make in
      make.leading.equalToSuperview()
      make.centerY.equalTo(textFieldContainerView.snp.centerY)
      make.width.equalTo(68)
      make.trailing.equalTo(textFieldContainerView.snp.leading).offset(-24)
    }
    
    textFieldContainerView.snp.makeConstraints { make in
      make.top.trailing.bottom.equalToSuperview()
    }
    
    [currencyDenominationLabel, textField].forEach(textFieldContainerView.addSubview(_:))
    
    currencyDenominationLabel.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview()
      make.leading.equalTo(textFieldContainerView.snp.leading).offset(16)
    }
    
    textField.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview()
      make.leading.equalTo(currencyDenominationLabel.snp.trailing).offset(16)
      make.trailing.equalTo(textFieldContainerView.snp.trailing).offset(-16)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}


extension BillInputView {
  @objc func doneButtonTapped() {
    textField.endEditing(true)
  }
}
