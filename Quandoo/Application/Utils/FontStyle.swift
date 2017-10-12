//
//  FontStyle.swift
//  Quandoo
//
//  Created by Ilya Puchka on 13/10/2017.
//  Copyright © 2017 Ilya Puchka. All rights reserved.
//

import UIKit

extension NSAttributedStringKey {
    static let fontStyle = NSAttributedStringKey("FontStyleAttribute")
}

public typealias FontStyle = (UITraitCollection) -> UIFont?

extension UIFont {
    
    static func body(_ traitCollection: UITraitCollection) -> UIFont? {
        return UIFont.preferredFont(forTextStyle: .body, compatibleWith: traitCollection)
    }

    static func title1(_ traitCollection: UITraitCollection) -> UIFont? {
        return UIFont.preferredFont(forTextStyle: .title1, compatibleWith: traitCollection)
    }

    static func title3(_ traitCollection: UITraitCollection) -> UIFont? {
        return UIFont.preferredFont(forTextStyle: .title3, compatibleWith: traitCollection)
    }

    static func subheadline(_ traitCollection: UITraitCollection) -> UIFont? {
        return UIFont.preferredFont(forTextStyle: .subheadline, compatibleWith: traitCollection)
    }
}

