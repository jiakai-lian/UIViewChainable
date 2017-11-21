//
//  UIViewChainable.swift
//
//  Created by Jacky Lian on 21/11/17.
//

import UIKit

public protocol UIViewChainable {}
public extension UIViewChainable where Self: UIView {
    @discardableResult
    func config(_ config: (Self) -> Void) -> Self {
        config(self)
        return self
    }
    
    @discardableResult
    func layout(_ layout: (Self) -> Void) -> Self {
        layout(self)
        return self
    }
}

extension UIView: UIViewChainable {
    func attachTo(_ superView: UIView) -> Self {
        superView.addSubview(self)
        return self
    }
}
