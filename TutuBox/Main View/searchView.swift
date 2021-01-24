//
//  searchView.swift
//  TutuBox
//
//  Created by Brandon Plank on 7/12/20.
//  Copyright © 2020 Brandon Plank. All rights reserved.
//

import SwiftUI

struct searchView: View {
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
    @State private var searchTerm: String = ""
    @ObservedObject var getSearch = search()
    var body: some View {
        VStack{
            SearchBar(text: $searchTerm).padding(.leading, 8).padding(.trailing, 8)
            List {
                ForEach(getSearch.jsonData.filter({ searchTerm.isEmpty ? true: $0.name.localizedCaseInsensitiveContains(searchTerm)})) { i in
                    HStack{
                        Spacer()
                        ListRow(icon: i.icon, name: i.name, dev: i.dev, plist: i.plist)
                        Spacer()
                    }
                }
            }.padding(.horizontal, -15)
        }.onTapGesture {
            self.endEditing()
        }
    }
    
    private func endEditing(){
        UIApplication.shared.endEditing()
    }
}

class search: ObservableObject {
    @Published var jsonData = [searchtype]()
    
    init() {
        getJSON()
    }
    
    func getJSON(){
        if let url = URL(string: searchUrl) {
            if let d = try? Data(contentsOf: url) {
                let decoder = JSONDecoder()
                
                if let data = try? decoder.decode([searchtype].self, from: d) {
                    jsonData = data
                }
                
            }
        }
    }
    
}

struct searchtype: Codable, Identifiable {
    let id = UUID()
    let idin: Int
    let name: String
    let icon: String
    let plist: String
    let dev: String
    
    enum CodingKeys: String, CodingKey {
        case idin = "id"
        case name = "name"
        case icon = "icon"
        case plist = "plist"
        case dev = "dev"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        idin = try values.decodeIfPresent(Int.self, forKey: .idin) ?? 0
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? "N/A"
        icon = try values.decodeIfPresent(String.self, forKey: .icon) ?? "N/A"
        plist = try values.decodeIfPresent(String.self, forKey: .plist) ?? "N/A"
        dev = try values.decodeIfPresent(String.self, forKey: .dev) ?? "N/A"
    }
}
