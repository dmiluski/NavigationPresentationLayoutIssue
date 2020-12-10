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

    @State
    var text: String = ""

    @State
    var navigateTo: IdentifiableRoute?

    var isPresentingNavigation: Bool = false

    var fetcher = MapboxDirections.Directions()

    var body: some View {

        VStack {

            TextField("Enter", text: $text)
                .padding()
                .border(Color.black)

            HStack {

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
                                self.navigateTo = IdentifiableRoute(route: route)
                            }

                        default:
                            break
                        }
                    }
                }
            }


        }
        .sheet(item: $navigateTo) { item in
            NavigationView(route: item.route)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
