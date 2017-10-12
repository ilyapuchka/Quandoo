//
//  UILabel+FontStyle.swift
//  Quandoo
//
//  Created by Ilya Puchka on 13/10/2017.
//  Copyright © 2017 Ilya Puchka. All rights reserved.
//

import UIKit

private var _fontStyleKey: Void?

public extension StyleProxy where S: UILabel {
    
    /// Font style to apply to label
    var fontStyle: FontStyle? {
        get {
            return associatedValue(forKey: &_fontStyleKey)
        }
        set {
            retain(newValue, forKey: &_fontStyleKey)
        }
    }
    
}

extension UILabel: Stylish {
    
    /// Label's current font style
    public var fontStyle: FontStyle? {
        get { return styleProxy.fontStyle }
        set { styleProxy.fontStyle = newValue }
    }
    
    /// Updates label using its current style, if set
    public func updateStyle() {
        self.font = fontStyle?(traitCollection) ?? font
        
        if let attributedText = attributedText?.mutableCopy() as? NSMutableAttributedString {
            let fullRange = NSRange(location: 0, length: attributedText.length)
            attributedText.enumerateAttribute(.fontStyle, in: fullRange, options: [], using: { (style, range, _) in
                guard let style = style as? FontStyle, let font = style(traitCollection) else { return }
                attributedText.addAttribute(.font, value: font, range: range)
            })
            self.attributedText = attributedText
        }
    }
    
}
