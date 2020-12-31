import Foundation
import UIKit

extension UIView {
    func cornerRadius(_ radius: Int = 20) {
        self.layer.cornerRadius = CGFloat(radius)
    }
    
    func dropShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 10
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, paddingTop: CGFloat, bottom: NSLayoutYAxisAnchor?, paddingBottom: CGFloat, left: NSLayoutXAxisAnchor?, paddingLeft: CGFloat, right: NSLayoutXAxisAnchor?, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

public extension CharacterSet {
    static let urlQueryParameterAllowed = CharacterSet.urlQueryAllowed.subtracting(CharacterSet(charactersIn: "&?"))
    static let urlQueryDenied           = CharacterSet.urlQueryAllowed.inverted()
    static let urlQueryKeyValueDenied   = CharacterSet.urlQueryParameterAllowed.inverted()
    static let urlPathDenied            = CharacterSet.urlPathAllowed.inverted()
    static let urlFragmentDenied        = CharacterSet.urlFragmentAllowed.inverted()
    static let urlHostDenied            = CharacterSet.urlHostAllowed.inverted()
    static let urlDenied                = CharacterSet.urlQueryDenied
        .union(.urlQueryKeyValueDenied)
        .union(.urlPathDenied)
        .union(.urlFragmentDenied)
        .union(.urlHostDenied)
    
    func inverted() -> CharacterSet {
        var copy = self
        copy.invert()
        return copy
    }
}

public extension String {
    func urlEncoded(denying deniedCharacters: CharacterSet = .urlDenied) -> String? {
        return addingPercentEncoding(withAllowedCharacters: deniedCharacters.inverted())
    }
}
