//
//  tutuBoxView.swift
//  TutuBox
//
//  Created by Brandon Plank on 7/12/20.
//  Copyright © 2020 Brandon Plank. All rights reserved.
//

import SwiftUI

struct tutuBoxView: View {
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
    @ObservedObject var getTutuBox = tutuBox()
    var body: some View {
        VStack{
            List (getTutuBox.jsonData) {i in
                HStack{
                    Spacer()
                    ListRow(icon: i.icon, name: i.name, dev: i.dev, plist: i.plist)
                    Spacer()
                }
            }.padding(.horizontal, -15)
        }
        .navigationBarTitle("TutuBox Apps")
    }
}

class tutuBox: ObservableObject {
    @Published var jsonData = [tutuBoxtype]()
    init() {
        let session = URLSession(configuration: .default)
        session.dataTask(with: tutuboxUrl) { (data, response, error) in
            if error != nil && data == nil {
                return
            }
            do{
                let fetch = try JSONDecoder().decode([tutuBoxtype].self, from: data!)
                DispatchQueue.main.async {
                    self.jsonData = fetch
                }
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
}

struct tutuBoxtype: Decodable, Identifiable {
    let id: Int
    let name: String
    let icon: String
    let plist: String
    let dev: String
}

