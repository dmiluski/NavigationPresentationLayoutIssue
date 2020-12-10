//
//  ImagePickerView.swift
//  NavigationPresentationLayoutIssue
//
//  Created by Dane Miluski on 12/9/20.
//

import Foundation
import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {


    // MARK: - Types

    /// Coordinates transition interactions
    class Coordinator: NSObject {

        /// NavigationView Instance
        var view: ImagePickerView

        init(_ view: ImagePickerView) {
            self.view = view
        }
    }

    // MARK: - UIViewControllerRepresentable

    func makeUIViewController(context: Context) -> some UIViewController {
        UIImagePickerController()
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // No Op
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
