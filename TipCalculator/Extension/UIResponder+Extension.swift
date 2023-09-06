//
//  UIResponder+Extension.swift
//  TipCalculator
//
//  Created by ahdivio mendes on 06/09/23.
//

import UIKit

extension UIResponder {
  var parentViewController: UIViewController? {
    return next as? UIViewController ?? next?.parentViewController
  }
}
