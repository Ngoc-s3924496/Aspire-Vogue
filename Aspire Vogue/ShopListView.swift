//
//  ShopListView.swift
//  Aspire Vogue
//
//  Created by Duong Vu Thanh Ngoc on 31/07/2023.
//

import SwiftUI

struct ShopListView: View {
    // Initialize variable
    @EnvironmentObject var shopData: ShopDataStore
    @AppStorage("appTheme") private var isDarkMode = false
    @State private var searchTerm = ""
    
    var body: some View {
        NavigationView(){
            ZStack{
                VStack{
                    // Header
                    ListHeader(searchTerm: $searchTerm).padding(.bottom, -25)
                    List {
                        // List view if user search
                        if (self.searchTerm != ""){
                            if
                                // Show message if no search found
                                (shopData.shops.filter({$0.name.lowercased().contains(self.searchTerm.lowercased())})).count == 0{
                                Text("No shop found")
                                    .font(.custom("Roboto-Regular", size: 18))
                            }
                            else{
                                // Loop and filter shop that have name contain search input
                                ForEach(shopData.shops.filter({$0.name.lowercased().contains(self.searchTerm.lowercased())})){shop in
                                    // Show loved shops and have search input
                                    if (self.shopData.lovedFilter){
                                        if (shop.loved){
                                            ListRow(shop: shop)
                                                .background(NavigationLink("", destination: ShopDetailView(shop: shop).navigationBarBackButtonHidden(true))).navigationTitle("")
                                                .listRowSeparator(.hidden)
                                                .listRowBackground(Color("scrollBackground"))
                                        }
                                    }
                                    // Show all shops and have search input
                                    else{
                                        ListRow(shop: shop)
                                            .background(NavigationLink("", destination: ShopDetailView(shop: shop).navigationBarBackButtonHidden(true))).navigationTitle("")
                                            .listRowSeparator(.hidden)
                                            .listRowBackground(Color("scrollBackground"))
                                    }
                                }
                            }
                        }
                        // List view if user don't use search
                        else{
                            ForEach(shopData.shops){ shop in
                                // Show loved shops
                                if (self.shopData.lovedFilter){
                                    if (shop.loved){
                                        ListRow(shop: shop)
                                            .background(NavigationLink("", destination: ShopDetailView(shop: shop).navigationBarBackButtonHidden(true))).navigationTitle("")
                                            .listRowSeparator(.hidden)
                                            .listRowBackground(Color("scrollBackground"))
                                    }
                                }
                                // Show all shops
                                else{
                                    ListRow(shop: shop)
                                        .background(NavigationLink("", destination: ShopDetailView(shop: shop).navigationBarBackButtonHidden(true))).navigationTitle("")
                                        .listRowSeparator(.hidden)
                                        .listRowBackground(Color("scrollBackground"))
                                }
                            }
                        }
                    }.scrollContentBackground(.hidden)
                        .background(Color("scrollBackground"))
                    
                }
            }
        } // Manage app color scheme
        .environment(\.colorScheme, isDarkMode ? .dark : .light)
    }
}

struct ListRow: View{
    var shop: Shop
    var body: some View{
        ZStack{
            Color("shopRowBackground").frame(width: 320, height: 90)
                .cornerRadius(7)
            HStack{
                Image(shop.image[0]).resizable()
                    .frame(width: 90, height: 90)
                    .cornerRadius(7)
                VStack(alignment: .listRowSeparatorLeading){
                    Text(shop.name)
                        .font(.custom("Roboto-Medium", size: 17))
                        .padding(.bottom, 1)
                    Text(shop.address)
                        .font(.custom("Roboto-Regular", size: 13))
                        .lineSpacing(3)
                }.frame(width: 140)
                HStack{
                    Spacer()
                    Text(shop.price)
                        .font(.custom("Roboto-Bold", size: 13))
                    Image(shop.loved ? "heart-fill" : "heart-outline")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 15, height: 15)
                }.padding(.trailing, 15)
                    .padding(.bottom, 42)
            }
        }.padding(.leading, 30)
            .padding(.trailing, 30)
    }
}

struct ShopListView_Previews: PreviewProvider {
    static var previews: some View {
        ShopListView()
            .environmentObject(ShopDataStore())
    }
}
