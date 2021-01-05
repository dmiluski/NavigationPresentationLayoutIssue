
import Foundation
import SwiftUI
import MapboxCoreNavigation
import MapboxDirections
import MapboxNavigation

/// SwiftUI Wrapper of MapboxNavigationViewController
struct NavigationView: UIViewControllerRepresentable {

    // MARK: - Types

    /// Coordinates transition interactions
    class Coordinator: NSObject {

        /// NavigationView Instance
        var view: NavigationView

        init(_ view: NavigationView) {
            self.view = view
        }
    }

    var route: MapboxDirections.Route

    // Requests to dismiss
    var onDismiss: () -> Void

    // MARK: - UIViewControllerRepresentable

    func makeUIViewController(context: Context) -> some UIViewController {


        // MARK: - See Here - Repro

        // Code Reproducing Strange behavior
        let sanFrancisco = Waypoint(coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194))
        let sanJose = Waypoint(coordinate: CLLocationCoordinate2D(latitude: 37.3382, longitude: -121.8863))
        let options = NavigationRouteOptions(
            waypoints: [
                sanFrancisco,
                sanJose
            ]
        )

        let viewController = NavigationViewController(
            for: route,
            routeIndex: 0,
            routeOptions: options
        )
        viewController.delegate = context.coordinator
        return viewController

        // Code that seems to play friendly with Keyboard avoidance
        // return UIViewController()


    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // NoOp
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

extension NavigationView.Coordinator: NavigationViewControllerDelegate {

    func navigationViewControllerDidDismiss(_ navigationViewController: NavigationViewController, byCanceling canceled: Bool) {
        self.view.onDismiss()
    }
}
