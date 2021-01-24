//
//  Backend.swift
//  TutuBox
//
//  Created by Brandon Plank on 7/12/20.
//  Copyright © 2020 Brandon Plank. All rights reserved.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

/*
 Start Vars
 */

let tutuboxAppUrl = "https://tutubox.io/"

let emptyString = ""
var serverString = ""

// MARK: SAUNDERS, MODIFY THIS
let jsonLocation = "json"


let searchUrl = String(tutuboxAppUrl + "\(jsonLocation)/all.json")

let hackedUrl = URL(string: tutuboxAppUrl + "\(jsonLocation)/hacked.json")!
let tutuboxUrl = URL(string: tutuboxAppUrl + "\(jsonLocation)/tutubox.json")!
let jailbreakUrl = URL(string: tutuboxAppUrl + "\(jsonLocation)/jailbreak.json")!
let tweakedAppUrl = URL(string: tutuboxAppUrl + "\(jsonLocation)/tweakedApps.json")!
let emulatorUrl = URL(string: tutuboxAppUrl + "\(jsonLocation)/emulator.json")!

// Featured
let ourPicksUrl = URL(string: tutuboxAppUrl + "\(jsonLocation)/featured/ourpicks.json")!
let topappsUrl = URL(string: tutuboxAppUrl + "\(jsonLocation)/featured/topapps.json")!
let topJailbreaksUrl = URL(string: tutuboxAppUrl + "\(jsonLocation)/featured/topjailbreaks.json")!

// Credits
let creditsUrl = URL(string: tutuboxAppUrl + "json/credits/credits.json")! //dont change this.

/*
 More stuff
 */

extension UIColor {
public convenience init(hex:String) {
var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    var r: CGFloat = 0.0
    var g: CGFloat = 0.0
    var b: CGFloat = 0.0
    var a: CGFloat = 1.0
    
    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    
    if ((cString.count) == 8) {
        r = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        g =  CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        b = CGFloat((rgbValue & 0x0000FF)) / 255.0
        a = CGFloat((rgbValue & 0xFF000000)  >> 24) / 255.0
        
    }else if ((cString.count) == 6){
        r = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        g =  CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        b = CGFloat((rgbValue & 0x0000FF)) / 255.0
        a =  CGFloat(1.0)
    }
    
    
    self.init(  red: r,
                green: g,
                blue: b,
                alpha: a
    )
}
}

struct ListRow: View {
    @Environment(\.colorScheme) var colorScheme
    var icon: String
    var name: String
    var dev: String
    var plist: String
    var body: some View {
        HStack{
            HStack{
                AnimatedImage(url: URL(string: "\(tutuboxAppUrl + icon)")).placeholder(UIImage(named: "blank"))
                    .resizable()
                    .frame(width: 60, height: 60)
                    .cornerRadius(15)
                VStack(alignment: .leading){
                    Text(name)
                    Text(dev)
                }
                Spacer()
                Button(action: {
                    print(self.plist)
                    if let url = URL(string: getPlistUrl(plistName: self.plist)) {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Get")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white).frame(width: 50, height: 30).background(Color.blue)
                }.buttonStyle(PlainButtonStyle()).cornerRadius(15).padding(.all, 5.0)
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60).padding(.all).background(colorScheme == .dark ? Color(UIColor.init(hex: "#303030")) : Color(UIColor.init(hex: "#ededed"))).cornerRadius(15).gesture(LongPressGesture(minimumDuration: 0).onEnded { _ in
                print("Pressed!")
                self.frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 100).padding(.all).background(colorScheme == .dark ? Color(UIColor.init(hex: "#303030")) : Color(UIColor.init(hex: "#ededed"))).cornerRadius(15)
    })
        }
    }
}

struct ListH: View {
    @Environment(\.colorScheme) var colorScheme
    var icon: String
    var plist: String
    var body: some View{
        Button(action: {
            if let url = URL(string: getPlistUrl(plistName: self.plist)) {
                UIApplication.shared.open(url)
            }
        }) {
        AnimatedImage(url: URL(string: "\(tutuboxAppUrl + icon)")).placeholder(UIImage(named: "blank")).resizable().frame(width: 60, height: 60).cornerRadius(15)
        }.buttonStyle(PlainButtonStyle())
    }
}

struct SectionsRow: View {
    @Environment(\.colorScheme) var colorScheme
    var icon: String
    var text: String
    var body: some View {
        HStack{
            Spacer()
            HStack {
                AnimatedImage(url: URL(string: "\(tutuboxAppUrl + icon)")).placeholder(UIImage(named: "blank")).resizable()
                .frame(width: 40, height: 40)
                    .cornerRadius(15)
                VStack(alignment: .leading){
                Text(text)
                }
                Spacer()
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, maxHeight: 40).padding(.all).background(colorScheme == .dark ? Color(UIColor.init(hex: "#303030")) : Color(UIColor.init(hex: "#ededed"))).cornerRadius(15)
            Spacer()
        }
    }
}

struct AvatarRow: View {
    @Environment(\.colorScheme) var colorScheme
    let username: String
    let role: String
    let name: String
    
    var body: some View {
        HStack {
            AnimatedImage(url: URL(string: "\(getPfpIcon(username: username))")).placeholder(UIImage(named: "blank")).resizable()
                .frame(width: 60, height: 60)
                .cornerRadius(20)
                .padding(.all)
            VStack(alignment: .leading){
                Text(name)
                Text(role)
            }
            Spacer()
            Button(action: {
                if let url = URL(string: handleUser(username: self.username)) {
                    UIApplication.shared.open(url)
                }
            }) {
                Text("Follow")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white).frame(width: 70, height: 30).background(Color.blue)
            }.buttonStyle(PlainButtonStyle()).cornerRadius(15).padding(.all)
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 80, maxHeight: 80).background(colorScheme == .dark ? Color(UIColor.init(hex: "#303030")) : Color(UIColor.init(hex: "#ededed"))).cornerRadius(15)
    }
}

struct TinyHeader: View {
    let name: String
    var body: some View{
        HStack{
            Text(name)
                .font(.headline)
                .fontWeight(.heavy)
                .padding(.leading, 20.0)
            Spacer()
        }
    }
}

func getPlistUrl(plistName: String) -> String {
    let url: String
    url = "itms-services://?action=download-manifest&url=\(tutuboxAppUrl)plists/\(plistName).plist"
    return url
}

func handleUser(username: String) -> String{
    let url = "https://twitter.com/\(username)"
    return url
}

func getPfpIcon(username: String) -> String{
    let url = "https://mobile.twitter.com/\(username)/profile_image?size=original"
    return url
}

/*
    Start plist vals
 */

func getUserType() -> String {
    return UserDefaults.standard.string(forKey: "userType") ?? "N/A"
}

func setUserType(type: String) {
    UserDefaults.standard.set(type, forKey: "userType")
    UserDefaults.standard.synchronize()
}
