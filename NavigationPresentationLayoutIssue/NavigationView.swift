
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

        let initial = Date()
        let viewController = NavigationViewController(
            for: route,
            routeIndex: 0,
            routeOptions: options
        )
        let final = Date()


        print("Dane - NavigationView init Time: \(final.timeIntervalSince(initial))")

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // NoOp
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
