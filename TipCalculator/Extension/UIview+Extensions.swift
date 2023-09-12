//
//  UIview+Extensions.swift
//  TipCalculator
//
//  Created by ahdivio mendes on 17/08/23.
//

import UIKit

extension UIView {
  
  func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
    layer.cornerRadius = radius
    layer.masksToBounds = false
    layer.shadowOffset = offset
    layer.shadowColor = color.cgColor
    layer.shadowRadius = radius
    layer.shadowOpacity = opacity
    let backgroundCGColor = backgroundColor?.cgColor
    backgroundColor = nil
    layer.backgroundColor = backgroundCGColor
  }
  
  func addCornerRadius(radius: CGFloat) {
    layer.masksToBounds = false
    layer.cornerRadius = radius
  }
  
  func addRoundedCorners(corners: CACornerMask, radius: CGFloat) {
    layer.cornerRadius = radius
    layer.maskedCorners = [corners]
  }
  
}



//MARK: - prepares spacer view
protocol SpacerViewProtocol {
  static func sapcerView(height: CGFloat) -> UIView
}

extension UIView: SpacerViewProtocol {
  static func sapcerView(height: CGFloat = 0) -> UIView {
    let spacerView = UIView()
    spacerView.heightAnchor.constraint(equalToConstant: height).isActive = true
    return spacerView
  }
}


//MARK: For getting views to input custom values for testing
//stack overflow ref::  https://stackoverflow.com/a/45297466/6181721
extension UIView {
  
  func allSubViewsOf<T : UIView>(type : T.Type) -> [T] {
    var all = [T]()
    func getSubview(view: UIView) {
      if let aView = view as? T{
        all.append(aView)
      }
      guard view.subviews.count>0 else { return }
      view.subviews.forEach{ getSubview(view: $0) }
    }
    getSubview(view: self)
    return all
  }
}
