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
    var chain: Chain<Self> {
        return Chain(self)
    }
}

public extension Chain where Base: UIView {
    @discardableResult
    public func config(_ config: (Base) -> Void) -> Base {
        config(base)
        return base
    }
    
    @discardableResult
    public func layout(_ layout: (Base) -> Void) -> Base {
        layout(base)
        return base
    }
    
    
    //Automatically turn off the auto sizing flag
    @discardableResult
    public func constraintLayout(_ layout: (Base) -> Void) -> Base {
        base.translatesAutoresizingMaskIntoConstraints = false
        return self.layout(layout)
    }
    
    //Activate all the constraints
    //You should only call this method when all the constraints are programatically added and should be all activated
    //Do not use this method if you have conditional constraints
    @discardableResult
    public func activateAllConstraints() -> Base {
        return activate(base.constraints)
    }
    
    @discardableResult
    public func activate(_ constraints:[NSLayoutConstraint]) -> Base {
        constraints.forEach {
            $0.activate()
        }
        
        return base
    }
    
    @discardableResult
    public func deactivateAllConstraints() -> Base {
        return deactivate(base.constraints)
    }
    
    @discardableResult
    public func deactivate(_ constraints:[NSLayoutConstraint]) -> Base {
        constraints.forEach {
            $0.deactivate()
        }
        
        return base
    }
    
    @discardableResult
    public func attach(to superView: UIView) -> Base {
        superView.addSubview(base)
        return base
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
