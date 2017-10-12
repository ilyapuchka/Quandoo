//
//  Styles.swift
//  Quandoo
//
//  Created by Ilya Puchka on 13/10/2017.
//  Copyright © 2017 Ilya Puchka. All rights reserved.
//

import UIKit

/// Protocol that should be implemented by views to support styles
public protocol Stylish: class {
    func updateStyle()
}

/// Proxy for setting style properties on instance of `S`
public class StyleProxy<S: Stylish>: NSObject {
    fileprivate override init() { }
}

/// Proxy view to track trait collection changes and trigger style updates
private class StyleProxyView<S: Stylish>: UIView {
    
    var instance: S? { return superview as? S }
    var styleProxy: StyleProxy<S> = StyleProxy()
    var contentSizeCategoryObserver: AnyObject?
    
    convenience init() {
        self.init(frame: .zero)
        
        contentSizeCategoryObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil, queue: .main) { [weak self] notification in
            self?.instance?.updateStyle()
        }
    }
    
    deinit {
        if let observer = contentSizeCategoryObserver {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        instance?.updateStyle()
    }
    
}

extension Stylish where Self: UIView {
    
    private var styleProxySubview: StyleProxyView<Self>? {
        // have to cast to AnyObject to avoid compiler warning
        return subviews.first { $0 as AnyObject is StyleProxyView<Self> } as AnyObject as? StyleProxyView<Self>
    }

    /// Instance of proxy for setting style properties
    private(set) var styleProxy: StyleProxy<Self> {
        get {
            if let styleView = styleProxySubview {
                return styleView.styleProxy
            }

            let styleView = StyleProxyView<Self>()
            addSubview(styleView)
            return styleView.styleProxy
        }
        set {
            guard let styleView = styleProxySubview else { return }
            styleView.styleProxy = newValue
            styleView.instance?.updateStyle()
        }
    }
    
}

