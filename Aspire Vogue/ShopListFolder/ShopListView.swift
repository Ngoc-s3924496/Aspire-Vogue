/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 1
 Author: Duong Vu Thanh Ngoc
 ID: s3924496
 Created  date: 31/07/2023
 Last modified: 07/08/2023
 Acknowledgement: SwiftUI, all the shop that appear in the app
 */

import SwiftUI

struct ShopListView: View {
    // Initialize variable
    var shopCategory = ["All", "Streetwear", "Casual", "Punk", "Romantic", "Glamorous"]
    @State private var selected = "All"
    @EnvironmentObject var shopData: ShopDataStore
    @AppStorage("appTheme") private var isDarkMode = false
    @State private var searchTerm = ""
    
    // Change the segmented picker styling
    init() {
        UISegmentedControl.appearance().setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(named: "itemColor")
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(named: "shopDetailBackground") as Any], for: .selected)
    }
    var body: some View {
        ScrollViewReader{ proxy in
            NavigationView(){
                ZStack{
                    VStack{
                        // Header
                        ListHeader(searchTerm: $searchTerm, selected: $selected).padding(.bottom, -25)
                        // Segmented Picker
                        Section{
                            ScrollView(.horizontal){
                                Picker(selection: $selected, label: EmptyView()){
                                    ForEach(shopCategory, id: \.self) {
                                        Text($0)
                                    }
                                }.pickerStyle(.segmented)
                                    .padding(.bottom, 20)
                            }
                        }
                        .padding(.horizontal, 20)
                        .background(Color("headerColor"))
                        List {
                            // List view if user search
                            if (self.searchTerm != ""){
                                if
                                    // Show message if no search found
                                    shopData.shops.filter({ $0.name.lowercased().contains(self.searchTerm.lowercased()) && (selected == "All" || $0.category.contains(selected)) }).count == 0{
                                    Text("No shop found")
                                        .font(.custom("Roboto-Regular", size: 18))
                                }
                                else{
                                    // Loop and filter shop that have name contain search input
                                    ForEach(shopData.shops.filter({($0.name.lowercased().contains(self.searchTerm.lowercased())) && (selected == "All" || $0.category.contains(selected))})){shop in
                                        // Show loved shops and have search input
                                        if (self.shopData.lovedFilter){
                                            if (shop.loved){
                                                ShopListRow(shop: shop)
                                                    .background(NavigationLink("", destination: ShopDetailView(shop: shop).navigationBarBackButtonHidden(true))).navigationTitle("")
                                                    .listRowSeparator(.hidden)
                                                    .listRowBackground(Color("scrollBackground"))
                                            }
                                        }
                                        // Show all shops and have search input
                                        else{
                                            ShopListRow(shop: shop)
                                                .background(NavigationLink("", destination: ShopDetailView(shop: shop).navigationBarBackButtonHidden(true))).navigationTitle("")
                                                .listRowSeparator(.hidden)
                                                .listRowBackground(Color("scrollBackground"))
                                        }
                                    }
                                }
                            }
                            // List view if user don't use search
                            else{
                                ForEach(shopData.shops.filter { shop in
                                    // Filter shops based on the selected category
                                    selected == "All" || shop.category.contains(selected)
                                }) { shop in
                                    // Show loved shops
                                    if (self.shopData.lovedFilter) {
                                        if (shop.loved) {
                                            ShopListRow(shop: shop)
                                                .background(NavigationLink("", destination: ShopDetailView(shop: shop).navigationBarBackButtonHidden(true))).navigationTitle("")
                                                .listRowSeparator(.hidden)
                                                .listRowBackground(Color("scrollBackground"))
                                        }
                                    }
                                    // Show all shops
                                    else{
                                        ShopListRow(shop: shop)
                                            .background(NavigationLink("", destination: ShopDetailView(shop: shop).navigationBarBackButtonHidden(true))).navigationTitle("")
                                            .listRowSeparator(.hidden)
                                            .listRowBackground(Color("scrollBackground"))
                                    }
                                }
                                
                            }
                            
                            
                        }.scrollContentBackground(.hidden)
                            .background(Color("scrollBackground"))
                        // Scroll to top button
                        Button{
                            withAnimation(.default){
                                proxy.scrollTo(1, anchor: .top)
                            }
                            
                        } label: {
                            Text("Scroll To Top")
                                .font(.custom("Roboto-Medium", size: 18))
                                .foregroundColor(Color("itemColor"))
                                .padding(.top, 5)
                                .padding(.bottom, -10)
                        }
                    }
                    
                }
            }
        }// Manage app color scheme
        .environment(\.colorScheme, isDarkMode ? .dark : .light)
    }
}

struct ShopListView_Previews: PreviewProvider {
    static var previews: some View {
        ShopListView()
            .environmentObject(ShopDataStore())
    }
}
