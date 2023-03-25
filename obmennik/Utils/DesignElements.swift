import UIKit


protocol HIG {
    var mediumPadding: CGFloat {get}
    var largePadding: CGFloat {get}
}

extension HIG {
    var mediumPadding: CGFloat { 16 }
    var largePadding: CGFloat { 24 }
}
