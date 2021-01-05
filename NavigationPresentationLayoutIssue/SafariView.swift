//
//  SafariView.swift
//  NavigationPresentationLayoutIssue
//
//  Created by Dane Miluski on 1/5/21.
//

import SwiftUI
import UIKit
import SafariServices

struct SafariView: UIViewControllerRepresentable {

    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {

        let initial = Date()
        let viewController = SFSafariViewController(url: url)
        let final = Date()


        print("Dane - SafariViewController init Time: \(final.timeIntervalSince(initial))")

        return viewController
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {

    }

}
