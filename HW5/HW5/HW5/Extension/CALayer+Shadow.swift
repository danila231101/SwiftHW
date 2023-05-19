import UIKit

extension CALayer {
    func applyShadow(
        color: UIColor = UIColor(named: "TextPrimary") ?? .black,
        alpha: Float = 0.06,
        x: CGFloat = 0,
        y: CGFloat = 12,
        blur: CGFloat = 24,
        spread: CGFloat = 0
    )
    {
        masksToBounds = false
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
