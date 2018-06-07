//
//  CalendarStoreSinglePageViewController.swift
//  iOS-SDK
//
//  Created by Balazs Vincze on 2018. 06. 01..
//  Copyright © 2018. SchedJoules. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit
import SchedJoulesApiClient

final class CalendarStoreSinglePageViewController: UINavigationController {
    /// Colors used by the SDK.
    public struct ColorPalette {
        public static let red = UIColor(red: 241/255.0, green: 102/255.0, blue: 103/255.0, alpha: 1)
    }
    
    // - MARK: Initialization
    
    /* This method is only called when initializing a `UIViewController` from a `Storyboard` or `XIB`.
     The `CalendarStoreSinglePageViewController` must only be used programatically, but every subclass of `UIViewController` must implement
     `init?(coder aDecoder: NSCoder)`. */
    public required init?(coder aDecoder: NSCoder) {
        fatalError("CalendarStoreSinglePageViewController must only be initialized programatically.")
    }
    
    /**
     - parameter apiClient: An instance of `SchedJoulesApi`, initialized with a valid access token.
     - parameter pageIdentifier: The page identifier for the the home page.
     - parameter title: The title for the `navigtaion bar` in the home page.
     - parameter largeTitle: Set to `false` if you don't want to use large navigation bar titles.
     - parameter tintColor: The tint color used through out the SDK, default is SchedJoules red.
     */
    public init(apiClient: Api, pageIdentifier: String, title: String) {
        super.init(nibName: nil, bundle: nil)
        
        // Customize the naivgation controller
        navigationBar.tintColor = ColorPalette.red
        if #available(iOS 11.0, *) {
            navigationBar.prefersLargeTitles = true
        }
        
        // Create home page with a specific page identifier and push it on to the navigation stack
        let homeVC = PageViewController(apiClient: apiClient, pageQuery:
            SinglePageQuery(pageID: pageIdentifier, locale: readSettings().last!), searchEnabled: true)
        homeVC.title = title
        pushViewController(homeVC, animated: false)
    }
    
    /**
     - parameter apiKey: The API Key (access token) for the **SchedJoules API**.
     - parameter pageIdentifier: The page identifier for the the home page.
     - parameter title: The title for the `navigtaion bar` in the home page.
     - parameter largeTitle: Set to `false` if you don't want to use large navigation bar titles.
     - parameter tintColor: The tint color used through out the SDK, default is SchedJoules red.
     */
    public convenience init(apiKey: String, pageIdentifier: String, title: String) {
        self.init(apiClient: SchedJoulesApi(accessToken: apiKey), pageIdentifier: pageIdentifier, title: title)
    }
    
    /// Read localization settings, use device defaults otherwise
    func readSettings() -> [String] {
        let languageSetting = UserDefaults.standard.value(forKey: "language_settings") as? Dictionary<String, String>
        let locale = languageSetting != nil ? languageSetting!["countryCode"] : Locale.preferredLanguages[0].components(separatedBy: "-")[0]
        let countrySetting = UserDefaults.standard.value(forKey: "country_settings") as? Dictionary<String, String>
        let location = countrySetting != nil ? countrySetting!["countryCode"] : Locale.current.regionCode
        return [locale!,location!]
    }
}
