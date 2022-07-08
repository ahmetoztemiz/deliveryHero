//
//  UIColor + Extension.swift
//  deliveryHero
//
//  Created by Ahmet Öztemiz on 8.07.2022.
//

import UIKit

extension UIColor {
    
    //MARK: Application Colors
    private static var applicationWhiteColor: UIColor {
        return UIColor(named: "ColorWhite") ?? .white
    }
    
    private static var applicationBlackColor: UIColor {
        return UIColor(named: "ColorBlack") ?? .white
    }
    
    private static var applicationGrayColor: UIColor {
        return UIColor(named: "ColorGray") ?? .gray
    }

    private static var applicationDarkGrayColor: UIColor {
        return UIColor(named: "ColorDarkGray") ?? .gray
    }
    
    //MARK: View Colors
    static var textColor: UIColor {
        return applicationBlackColor
    }
    
    static var backgroundColor: UIColor {
        return applicationWhiteColor
    }
    
    static var iconColor: UIColor {
        return applicationGrayColor
    }
    
    static var indicatorColor: UIColor {
        return applicationGrayColor
    }
    
    static var cellTextColor: UIColor {
        return applicationWhiteColor
    }

    static var cellBackgroundColor: UIColor {
        return applicationDarkGrayColor
    }
}
