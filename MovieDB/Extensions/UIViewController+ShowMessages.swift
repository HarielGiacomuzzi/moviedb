//
//  UIViewController+ShowMessages.swift
//  MovieDB
//
//  Created by Hariel Giacomuzzi on 17/12/19.
//  Copyright © 2019 Hariel Giacomuzzi. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showErrorMessage(message: String, title: String = "Oops, something has gone wrong") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { _ in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
