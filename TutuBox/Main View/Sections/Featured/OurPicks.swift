//
//  OurPicks.swift
//  TutuBox
//
//  Created by Brandon Plank on 7/15/20.
//  Copyright © 2020 Brandon Plank. All rights reserved.
//

import SwiftUI

struct OurPicks: View {
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
    @ObservedObject var getPicks = OurP()
    var body: some View {
        HStack{
            ForEach (getPicks.jsonData) {i in
                Spacer()
                ListH(icon: i.icon, plist: i.plist)
                Spacer()
            }
        }
    }
}

class OurP: ObservableObject {
    @Published var jsonData = [ourpicktype]()
    init() {
        let session = URLSession(configuration: .default)
        session.dataTask(with: ourPicksUrl) { (data, response, error) in
            if error != nil && data == nil {
                return
            }
            do{
                let fetch = try JSONDecoder().decode([ourpicktype].self, from: data!)
                DispatchQueue.main.async {
                    self.jsonData = fetch
                }
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
}

struct ourpicktype: Decodable, Identifiable {
    let id: Int
    let icon: String
    let plist: String
}
