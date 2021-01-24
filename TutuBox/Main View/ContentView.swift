//
//  ContentView.swift
//  TutuBox
//
//  Created by Brandon Plank on 7/12/20.
//  Copyright © 2020 Brandon Plank. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    @State private var selection = 0
    @State public var showingSettings = false
    @State var ServerToUse: String = ""


    var body: some View {
        TabView(selection: $selection){

            NavigationView {
            ScrollView {
                VStack{
                    EmptyView()
                    TinyHeader(name: "Our Picks")
                }
                OurPicks()
                VStack{
                    EmptyView()
                    TinyHeader(name: "Top Apps")
                }
                HStack{
                    Spacer()
                    TopApps()
                    Spacer()
                }
                VStack{
                    VStack{
                        EmptyView()
                        TinyHeader(name: "Top Jailbreaks")
                    }
                    HStack{
                        Spacer()
                        TopJailbreaks()
                        Spacer()
                    }
                    };
                VStack{
                    EmptyView()
                    TinyHeader(name: "Credits")
                }
                HStack{
                    Spacer()
                    CreditsView()
                    Spacer()
                }
                Text("iOS: \(UIDevice.current.systemVersion)")
                Spacer()

                .navigationBarTitle("TutuBox Home")

                }
            }
                .tabItem {
                    VStack {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                }
                .tag(0)
            NavigationView {
            ScrollView {

                sectionsView()

                .navigationBarTitle("Sections")

                }
            }
            .tabItem {
                VStack {
                    Image(systemName: "rectangle.stack.fill")
                    Text("Sections")
                }
            }
            .tag(1)
            NavigationView {
            searchView()
                .navigationBarTitle("Search Apps")
        }
            .tabItem {
                VStack {
                    Image(systemName: "magnifyingglass")
                    Text("Search Apps")
                }
            }
            .tag(2)
        }.accentColor(.blue).navigationViewStyle(StackNavigationViewStyle())
    }
}

class ContentViewGlobal{
    static var shared = ContentView()
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
