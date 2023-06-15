//
//  Component.swift
//  Demo
//
//  Created by Krunal Patel on 13/06/23.
//

import UIKit

struct Component {
    
    let name: String
    let stroyboardName: String
    let vcName: String
    var viewController: UIViewController {
        UIStoryboard(name: stroyboardName, bundle: nil).instantiateViewController(withIdentifier: vcName)
    }
    
    static func getComponents() -> [Component] {
        return [
            // UIComponents Storyboard 1
            Component(name: "UILabel, UIButton, UITextField, UITextView, UISwitch, UISlider, UIProgressView, UIPageControl", stroyboardName: "UIControls", vcName: "UIControlsViewController"),
            Component(name: "UISegmentedControl", stroyboardName: "UIControls", vcName: "SegmantedControlViewController"),
            Component(name: "Stepper", stroyboardName: "UIControls", vcName: "StepperViewController"),
            Component(name: "UIScrollView", stroyboardName: "UIControls", vcName: "ScrollViewController"),
            Component(name: "Table View", stroyboardName: "UIControls", vcName: "SettingsViewController"),
            Component(name: "Collection View, Pull refresh & UISearchBar", stroyboardName: "UIControls", vcName: "CollectionViewController"),
            Component(name: "UIImageView & Picker", stroyboardName: "UIControls", vcName: "ImageDemoViewController"),
            Component(name: "UIActivityIndicator", stroyboardName: "UIControls", vcName: "ActivityIndicatorViewController"),
            Component(name: "WKWebView & UIToolBar", stroyboardName: "UIControls", vcName: "WebViewController"),
            
            // UIComponents Storyboard 2
            Component(name: "Stack view", stroyboardName: "UIControls2", vcName: "StackViewController"),
            Component(name: "UITabBar", stroyboardName: "UIControls2", vcName: "TabBarViewController"),
            Component(name: "UIPickerView", stroyboardName: "UIControls2", vcName: "PickerViewController"),
            Component(name: "UIDatePicker", stroyboardName: "UIControls2", vcName: "DatePickerViewController"),
            Component(name: "UIMapView & CLLocation", stroyboardName: "UIControls2", vcName: "MapViewController"),
            Component(name: "Dynamic TextView", stroyboardName: "UIControls2", vcName: "DynamicTextView"),
            
            // KT Schedule Meeting
            Component(name: "Schedule Meeting", stroyboardName: "ScheduleMeeting", vcName: "ScheduleMeetingViewController"),
            
            // Flipkar Screen
            Component(name: "Flipkart Screen", stroyboardName: "Product", vcName: "Product"),
            
            // URLSession
            Component(name: "Users", stroyboardName: "WebServices", vcName: "UserListViewController"),
            Component(name: "User Registration", stroyboardName: "WebServices", vcName: "UserRegistrationViewController"),
            Component(name: "Image Upload", stroyboardName: "WebServices", vcName: "ImageUploadViewController"),
            Component(name: "Download File", stroyboardName: "WebServices", vcName: "DownloadViewController"),
                      
            // Alamofire
            Component(name: "Alamofire Demo", stroyboardName: "AlamofireDemo", vcName: "AFLoginVC")
        ]
    }
}
