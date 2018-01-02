//
//  UIViewChainable.swift
//
//  Created by Jacky Lian on 21/11/17.
//

import UIKit

public protocol UIViewChainable {}

public struct Chain<Base: UIViewChainable> {
    var base: Base
    init(_ base: Base) {
        self.base = base
    }
}

public extension UIViewChainable {
    var ui: Chain<Self> {
        return Chain(self)
    }
}

public extension Chain where Base: UIView {
    @discardableResult
    public func config(_ config: (Base) -> Void) -> Chain {
        config(base)
        return base.ui
    }
    
    @discardableResult
    public func layout(_ layout: (Base) -> Void) -> Chain {
        layout(base)
        return base.ui
    }
    
    
    //Automatically turn off the auto sizing flag
    @discardableResult
    public func constraintLayout(_ layout: (Base) -> Void) -> Chain {
        guard base.superview != nil else {
            fatalError("A UIView should be attached to its super view before doing constraint layout")
        }
        
        base.translatesAutoresizingMaskIntoConstraints = false
        return self.layout(layout)
    }
    
//    //Activate all the constraints
//    //You should only call this method when all the constraints are programatically added and should be all activated
//    //Do not use this method if you have conditional constraints
//    @discardableResult
//    public func activateAllConstraints() -> Chain {
//        return activate(base.constraints)
//    }
//
//    @discardableResult
//    public func activate(_ constraints:[NSLayoutConstraint]) -> Chain {
//        constraints.forEach {
//            $0.activate()
//        }
//
//        return base.ui
//    }
//
//    @discardableResult
//    public func deactivateAllConstraints() -> Chain {
//        return deactivate(base.constraints)
//    }
//
//    @discardableResult
//    public func deactivate(_ constraints:[NSLayoutConstraint]) -> Chain {
//        constraints.forEach {
//            $0.deactivate()
//        }
//
//        return base.ui
//    }
    
    @discardableResult
    public func attach(to superView: UIView) -> Chain {
        superView.addSubview(base)
        return base.ui
    }
}

extension UIView: UIViewChainable {
}

extension NSLayoutConstraint {
    @discardableResult
    public func activate() -> Self{
        isActive = true
        
        return self
    }
    
    @discardableResult
    public func deactivate() -> Self{
        isActive = false
        
        return self
    }
}
