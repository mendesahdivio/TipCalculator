//
//  ViewController.swift
//  TipCalculator
//
//  Created by ahdivio mendes on 15/08/23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
  
  //create views here
  private let logoView = LogoView()
  private let resultView = ResultView()
  private let billInputView = BillInputView()
  private let tipInputView = TipInputView()
  private let sliptInputView = SplitInputView()
  
  private lazy var stackView: CustomStackView = {
    let stackView = CustomStackView(frame: .infinite, orientation: .vertical, spacing: 36, distribution: .fillProportionally)
    stackView.addArrangedSubviews([logoView, resultView, billInputView, tipInputView, sliptInputView, UIView()])
    return stackView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    layout()
    print("something")
  }

}


extension ViewController {
  final func layout() {
    view.backgroundColor = ThemeColour.bg
    view.addSubview(stackView)
    stackView.snp.makeConstraints { make in
      make.leading.equalTo(view.snp.leadingMargin).offset(16)
      make.trailing.equalTo(view.snp.trailing).offset(-16)
      make.bottom.equalTo(view.snp.bottom).offset(-16)
      make.top.equalTo(view.snp.topMargin).offset(16)
    }
    
    logoView.snp.makeConstraints { make in
      make.height.equalTo(48)
    }
    
    resultView.snp.makeConstraints { make in
      make.height.equalTo(224)
    }
    
    billInputView.snp.makeConstraints { make in
      make.height.equalTo(56)
    }
    
    tipInputView.snp.makeConstraints { make in
      make.height.equalTo((56*2) + 16)
    }
    
    sliptInputView.snp.makeConstraints { make in
      make.height.equalTo(56)
    }
  }
}

