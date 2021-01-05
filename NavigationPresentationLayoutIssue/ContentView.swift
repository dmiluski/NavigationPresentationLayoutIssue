//
//  ContentView.swift
//  NavigationPresentationLayoutIssue
//
//  Created by Dane Miluski on 12/9/20.
//

import SwiftUI
import MapboxCoreNavigation
import MapboxNavigation
import MapboxDirections

struct IdentifiableRoute: Identifiable {
    let route: MapboxDirections.Route
    let id = UUID()
}


struct ContentView: View {

    static var navigationWindow: UIWindow?

    // MARK: - Types

    enum Presentation: Identifiable {

        /// Navigation is being displayed
        case navigateTo(MapboxDirections.Route)

        /// Image Picker is being displayed
        case imagePicker

        var id: String {
            switch self {
            case .navigateTo: return "navigation"
            case .imagePicker: return "imagePicker"
            }
        }
    }

    @State
    var text: String = ""

    @State
    var activePresentation: Presentation?

    var fetcher = MapboxDirections.Directions()

    func showNavigation() {
        let sanFrancisco = Waypoint(coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194))
        let sanJose = Waypoint(coordinate: CLLocationCoordinate2D(latitude: 37.3382, longitude: -121.8863))
        let options = NavigationRouteOptions(
            waypoints: [
                sanFrancisco,
                sanJose
            ]
        )

        fetcher.calculate(options) { (session, result) in

            switch result {
            case let .success(response):

                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                      let route = response.routes?.first else { return }

                // Configure with reference to Scene
                let window = UIWindow(windowScene: windowScene)

                // Placeholder Containing RootViewController
                let viewController = UIViewController()
                viewController.view.backgroundColor = .clear
                window.rootViewController = viewController
                window.windowLevel = UIWindow.Level.statusBar - 1

                // Store Strong Reference
                window.makeKeyAndVisible()

                // Configure Navigation
                let navigationView = NavigationView(route: route) {

                    Self.navigationWindow?.resignKey()

                    // Cleanup
                    Self.navigationWindow = nil

                }
                .ignoresSafeArea()

                let host = UIHostingController(rootView: navigationView)
                host.modalPresentationStyle = .fullScreen

                // Present Navigation
                window.rootViewController = host

                Self.navigationWindow = window



            default:
                break
            }
        }
    }
    var body: some View {

//        ScrollView {
            VStack {

                TextField("Enter", text: $text)
                    .disableAutocorrection(true)
                    .padding()
                    .border(Color.black)

                Button("Show Navigation") {
                    showNavigation()
                }
            }
            .padding()
//        }



//        .fullScreenCover(item: $activePresentation) { item in
//            switch item {
//            case let .navigateTo(route):
//
//                NavigationView(route: route)
//                    .ignoresSafeArea()
//            case .imagePicker:
//
//                ImagePickerView()
//                    .ignoresSafeArea()
//            }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
