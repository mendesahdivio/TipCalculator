//
//  TipInputView.swift
//  TipCalculator
//
//  Created by ahdivio mendes on 16/08/23.
//

import UIKit

class TipInputView: UIView {
  init() {
    super.init(frame: .zero)
    layout()
  }
  
  private func layout() {
    backgroundColor = .cyan
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
