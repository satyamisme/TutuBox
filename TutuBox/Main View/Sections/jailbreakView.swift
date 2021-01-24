//
//  jailbreakView.swift
//  TutuBox
//
//  Created by Brandon Plank on 7/12/20.
//  Copyright © 2020 Brandon Plank. All rights reserved.
//

import SwiftUI

struct jailbreakView: View {
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
    @ObservedObject var getJailbreak = jailbreak()
    var body: some View {
        VStack{
            List (getJailbreak.jsonData) {i in
                HStack{
                    Spacer()
                    ListRow(icon: i.icon, name: i.name, dev: i.dev, plist: i.plist)
                    Spacer()
                }
            }.padding(.horizontal, -15)
        }
        .navigationBarTitle("Jailbreaks")
    }
}


struct jailbreakView_Previews: PreviewProvider {
    static var previews: some View {
        jailbreakView()
    }
}

class jailbreak: ObservableObject {
    @Published var jsonData = [jailbreaktype]()
    init() {
        let session = URLSession(configuration: .default)
        session.dataTask(with: jailbreakUrl) { (data, response, error) in
            if error != nil && data == nil {
                return
            }
            do{
                let fetch = try JSONDecoder().decode([jailbreaktype].self, from: data!)
                DispatchQueue.main.async {
                    self.jsonData = fetch
                }
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
}

struct jailbreaktype: Decodable, Identifiable {
    let id: Int
    let name: String
    let icon: String
    let plist: String
    let dev: String
}
