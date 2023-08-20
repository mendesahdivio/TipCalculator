//
//  SplitInputView.swift
//  TipCalculator
//
//  Created by ahdivio mendes on 16/08/23.
//

import UIKit

class SplitInputView: UIView {
  init() {
    super.init(frame: .zero)
    layout()
  }
  
  private func layout() {
    backgroundColor = .green
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
