//
//  MapView.swift
//  NavigationPresentationLayoutIssue
//
//  Created by Dane Miluski on 1/5/21.
//

import Foundation
import MapKit
import UIKit
import SwiftUI


struct MapView: UIViewRepresentable {

    func makeUIView(context: Context) -> MKMapView {
        let initial = Date()
        let view = MKMapView()

        // Disable Scrolling (for swipe to dismiss easy experimenting)
        view.isScrollEnabled = false
        let final = Date()

        print("Dane - MapView init Time: \(final.timeIntervalSince(initial))")

        return view
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {

    }
}

