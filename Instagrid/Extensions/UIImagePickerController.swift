//
//  UIImagePickerController.swift
//  Instagrid
//
//  Created by Elodie-Anne Parquer on 01/08/2019.
//  Copyright © 2019 Elodie-Anne Parquer. All rights reserved.
//

import UIKit

extension UIImagePickerController {
    open override var shouldAutorotate: Bool { return true }
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask { return .all }
}
