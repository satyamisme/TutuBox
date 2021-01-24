//
//  sectionsView.swift
//  TutuBox
//
//  Created by Brandon Plank on 7/12/20.
//  Copyright © 2020 Brandon Plank. All rights reserved.
//

import SwiftUI

struct sectionsView: View {
    var body: some View {
        VStack{
            NavigationLink(destination: tutuBoxView()){
                SectionsRow(icon: "img/flappybird.png", text: "TutuBox Apps")
            }.buttonStyle(PlainButtonStyle())
            NavigationLink(destination: emulatorView()){
                SectionsRow(icon: "img/ppsspp.jpg", text: "Emulators")
            }.buttonStyle(PlainButtonStyle())
            NavigationLink(destination: jailbreakView()){
                SectionsRow(icon: "img/chimera.png", text: "Jailbreak Apps")
            }.buttonStyle(PlainButtonStyle())
            NavigationLink(destination: hackedView()){
                SectionsRow(icon: "img/geometrydash.png", text: "Hacked Games")
            }.buttonStyle(PlainButtonStyle())
            NavigationLink(destination: tweakedAppsView()){
                SectionsRow(icon: "img/spotify++.png", text: "Tweaked Apps")
            }.buttonStyle(PlainButtonStyle())
        }
    }
}

struct sectionsView_Previews: PreviewProvider {
    static var previews: some View {
        sectionsView()
    }
}
