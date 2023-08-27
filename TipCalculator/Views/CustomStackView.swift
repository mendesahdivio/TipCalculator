//
//  CustomStackView.swift
//  TipCalculator
//
//  Created by ahdivio mendes on 16/08/23.
//

import UIKit

protocol StackViewProtocol {
  var stackView: UIStackView {get}
  func addSubviewInStack(_ view: UIView)
  func removeSubviewFromStack(_ view: UIView)
  func inserNewSubviewInStack(_ view: UIView, at stackIndex: Int)
  func removeAllArrangedSubviews()
  func addArrangedSubviews(_ view: [UIView])
}



class CustomStackView:UIStackView, StackViewProtocol {
  
  var stackView: UIStackView {return self}
  
  init(frame: CGRect, orientation: NSLayoutConstraint.Axis = .vertical, spacing: CGFloat = 0, distribution: UIStackView.Distribution = .equalSpacing) {
    super.init(frame: frame)
    stackView.axis = orientation
    stackView.spacing = spacing
    stackView.alignment = alignment
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
   func addSubviewInStack(_ view: UIView) {
    stackView.addArrangedSubview(view)
  }
  
   func removeSubviewFromStack(_ view: UIView) {
    stackView.removeArrangedSubview(view)
  }
  
   func inserNewSubviewInStack(_ view: UIView, at stackIndex: Int) {
    stackView.insertArrangedSubview(view, at: stackIndex)
  }
  
  func removeAllArrangedSubviews() {
    for view in stackView.arrangedSubviews {
      removeArrangedSubview(view)
      view.removeFromSuperview()
    }
  }
  
  func addArrangedSubviews(_ view: [UIView]) {
    for item in view {
      stackView.addArrangedSubview(item)
    }
  }
}

