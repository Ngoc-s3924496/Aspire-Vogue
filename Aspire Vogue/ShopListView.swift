//
//  ShopListView.swift
//  Aspire Vogue
//
//  Created by Duong Vu Thanh Ngoc on 31/07/2023.
//

import SwiftUI

struct ShopListView: View {
    @EnvironmentObject var shopData: ShopDataStore
    @AppStorage("appTheme") private var isDarkMode = false
    @State private var searchTerm = ""
    var body: some View {
        NavigationView(){
            ZStack{
                VStack{
                    ListHeader(searchTerm: $searchTerm).padding(.bottom, -25)
                    List {
                        if (self.searchTerm != ""){
                            if (shopData.shops.filter({$0.name.lowercased().contains(self.searchTerm.lowercased())})).count == 0{
                                Text("No shop found")
                                    .font(.custom("Roboto-Regular", size: 18))
                            }
                            else{
                                ForEach(shopData.shops.filter({$0.name.lowercased().contains(self.searchTerm.lowercased())})){shop in
                                    if (self.shopData.LovedFilter){
                                        if (shop.loved){
                                            ListRow(shop: shop)
                                                .background(NavigationLink("", destination: ShopDetailView(shop: shop).navigationBarBackButtonHidden(true))).navigationTitle("")
                                                .listRowSeparator(.hidden)
                                                .listRowBackground(Color("scrollBackground"))
                                        }
                                    }
                                    else{
                                        ListRow(shop: shop)
                                            .background(NavigationLink("", destination: ShopDetailView(shop: shop).navigationBarBackButtonHidden(true))).navigationTitle("")
                                            .listRowSeparator(.hidden)
                                            .listRowBackground(Color("scrollBackground"))
                                    }
                                }
                            }
                        }
                        else{
                            ForEach(shopData.shops){ shop in
                                if (self.shopData.LovedFilter){
                                    if (shop.loved){
                                        ListRow(shop: shop)
                                            .background(NavigationLink("", destination: ShopDetailView(shop: shop).navigationBarBackButtonHidden(true))).navigationTitle("")
                                            .listRowSeparator(.hidden)
                                            .listRowBackground(Color("scrollBackground"))
                                    }
                                }
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
        }.environment(\.colorScheme, isDarkMode ? .dark : .light)
    }
}

struct ShopListView_Previews: PreviewProvider {
    static var previews: some View {
        ShopListView()
            .environmentObject(ShopDataStore())
    }
}

struct ListHeader: View {
    @EnvironmentObject var shopData: ShopDataStore
    @AppStorage("appTheme") private var isDarkMode = false
    @Binding var searchTerm: String
    var body: some View{
        ZStack{
            Color("headerColor").edgesIgnoringSafeArea(.top)
                .frame(width: 450, height: 60)
            HStack{
                if (!shopData.SearchShow){
                    Image("logo2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 106.5, height: 96)
                        .padding(.trailing, 120)
                        .padding(.leading, -20)
                    Button{
                        self.shopData.LovedFilter.toggle()
                    } label: {
                        Image(shopData.LovedFilter ? "heart-fill" : "heart-outline")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .padding(.top, -17.5)
                            .padding(.trailing, 10)
                    }
                    Button{
                        self.isDarkMode.toggle()
                    } label: {
                        Image("night")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .padding(.top, -17.5)
                            .padding(.trailing, 10)
                    }
                    
                }
                HStack{
                    if (shopData.SearchShow){
                        Image("search")
                            .resizable()
                            .aspectRatio(contentMode: .fit
                            )
                            .frame(width: 20, height: 20)
                            .padding(.leading, 20)
                            .padding(.trailing, 5)
                        TextField("Shop search", text: $searchTerm)
                            .padding(.vertical, 10)
                            .foregroundColor(Color("itemColor"))
                        Button{
                            withAnimation(.easeIn(duration: 0.15)){
                                shopData.SearchShow.toggle()
                                searchTerm = ""
                            }
                            
                        } label: {
                            Image(systemName: "xmark").foregroundColor(Color("itemColor"))
                        }.padding(.horizontal,15)
                        
                    }
                    else{
                        Button{
                            withAnimation(.easeIn(duration: 0.15)){
                                shopData.SearchShow.toggle()
                            }
                        } label: {
                            Image("search")
                                .resizable()
                                .aspectRatio(contentMode: .fit
                                )
                                .frame(width: 25, height: 25)
                                .padding(5)
                        }
                    }
                }.background(!shopData.SearchShow ? .clear : Color("searchBarColor"))
                    .cornerRadius(20)
                    .padding(.top, !shopData.SearchShow ? -17.5 : 27)
                    .padding(.bottom, !shopData.SearchShow ? 0 : 30)
                    .padding(.horizontal, !shopData.SearchShow ? 0 : 36)
                
            }
        }.padding(.top, -20)
        
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
