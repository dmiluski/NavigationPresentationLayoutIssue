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

    var body: some View {

        VStack {

            TextField("Enter", text: $text)
                .padding()
                .border(Color.black)

            HStack(spacing: 16) {

                Button("Show Image Picker") {
                    self.activePresentation = .imagePicker
                }
                
                Button("Show Navigation") {

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
                            if let route = response.routes?.first {
                                self.activePresentation = .navigateTo(route)
                            }

                        default:
                            break
                        }
                    }
                }


            }


        }
        .fullScreenCover(item: $activePresentation) { item in
            switch item {
            case let .navigateTo(route):

                NavigationView(route: route)
                    .ignoresSafeArea()
            case .imagePicker:

                ImagePickerView()
                    .ignoresSafeArea()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
