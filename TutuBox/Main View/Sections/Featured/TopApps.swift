//
//  TopApps.swift
//  TutuBox
//
//  Created by Brandon Plank on 7/15/20.
//  Copyright © 2020 Brandon Plank. All rights reserved.
//

import SwiftUI

struct TopApps: View {
    init() {
        if #available(iOS 14.0, *) {
            // iOS 14 doesn't have extra separators below the list by default.
        } else {
            // To remove only extra separators below the list:
            UITableView.appearance().tableFooterView = UIView()
        }

        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
    }
    @ObservedObject var getApps = TopA()
    var body: some View {
        VStack{
            ForEach (getApps.jsonData) {i in
                ListRow(icon: i.icon, name: i.name, dev: i.dev, plist: i.plist)
            }
        }
    }
}

class TopA: ObservableObject {
    @Published var jsonData = [topappstype]()
    init() {
        let session = URLSession(configuration: .default)
        session.dataTask(with: topappsUrl) { (data, response, error) in
            if error != nil && data == nil {
                return
            }
            do{
                let fetch = try JSONDecoder().decode([topappstype].self, from: data!)
                DispatchQueue.main.async {
                    self.jsonData = fetch
                }
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
}

struct topappstype: Decodable, Identifiable {
    let id: Int
    let name: String
    let icon: String
    let plist: String
    let dev: String
}


