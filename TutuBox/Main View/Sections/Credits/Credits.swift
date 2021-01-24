//
//  Credits.swift
//  TutuBox
//
//  Created by Brandon Plank on 7/16/20.
//  Copyright © 2020 Brandon Plank. All rights reserved.
//

import SwiftUI

struct CreditsView: View {
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
    @ObservedObject var getCreds = credits()
    var body: some View {
        VStack{
            ForEach (getCreds.jsonData) {i in
                Spacer()
                AvatarRow(username: i.username, role: i.role, name: i.name)
                Spacer()
            }
        }
    }
}

class credits: ObservableObject {
    @Published var jsonData = [creditstype]()
    init() {
        let session = URLSession(configuration: .default)
        session.dataTask(with: creditsUrl) { (data, response, error) in
            if error != nil && data == nil {
                return
            }
            do{
                let fetch = try JSONDecoder().decode([creditstype].self, from: data!)
                DispatchQueue.main.async {
                    self.jsonData = fetch
                }
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
}

struct creditstype: Decodable, Identifiable {
    let id: Int
    let username: String
    let role: String
    let name: String
}

