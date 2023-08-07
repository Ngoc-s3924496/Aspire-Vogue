/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 1
 Author: Duong Vu Thanh Ngoc
 ID: s3924496
 Created  date: 31/07/2023
 Last modified: 07/08/2023
 Acknowledgement: SwiftUI
 */

import SwiftUI

struct ShopDetailCarousel : View{
    var shop: Shop
    @State var imageOffset = [
        ImageCarousel(offset: 0),
        ImageCarousel(offset: 0),
        ImageCarousel(offset: 0),
        ImageCarousel(offset: 0),
        ImageCarousel(offset: 0),
        ImageCarousel(offset: 0),
        ImageCarousel(offset: 0)
    ]
    @State var scrolled = 0
    
    var body: some View{
        GeometryReader{reader in
            ZStack{
                // Loop and add image into the stack
                ForEach(1..<8){i in
                    let id = 7 - i
                    HStack{
                        Image(shop.image[8-i])
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        // Change the size of the image based on the ID and scrolled value
                            .frame(width: reader.size.width-20, height: reader.size.height - CGFloat(id - scrolled) * 35)
                            .cornerRadius(20)
                        // Change the image horizontal offset based on the ID and scrolled value
                            .offset(x: id - scrolled <= 2 ? CGFloat((id - scrolled) * 20) : 40)
                        Spacer(minLength: 0)
                    }
                    .contentShape(Rectangle())
                    // Wrapped offset is based on imageOffset value
                    .offset(x: imageOffset[id].offset)
                    .gesture(
                        DragGesture().onChanged{value in
                            withAnimation{
                                // Change offset if swipped to left, prevent left swipped for last image
                                if value.translation.width < 0 && id != 6{
                                    imageOffset[id].offset = value.translation.width
                                }
                                // Change offset if swipped to right, prevent left swipped for first image
                                else{
                                    if id > 0 {
                                        imageOffset[id - 1].offset = -(reader.size.width-20 + 60) + value.translation.width
                                    }
                                }
                                
                            }
                        }.onEnded{ value in
                            withAnimation{
                                // If swipped left
                                if value.translation.width < 0{
                                    // If swipped left over a thresold, move the image out of the view, prevent left swipped on the last
                                    if -value.translation.width > 180 && id != 6{
                                        imageOffset[id].offset = -(reader.size.width-20 + 60)
                                        scrolled += 1
                                    }
                                    // Return to original position if distance did not reach thresold
                                    else{
                                        imageOffset[id].offset = 0
                                    }
                                }
                                // If swipped right
                                else{
                                    // If not first image
                                    if id > 0 {
                                        // If swipped right over a thresold, move the image back into view
                                        if value.translation.width > 180{
                                            imageOffset[id - 1].offset = 0
                                            scrolled -= 1
                                        }
                                        // Return image to original position if distance did not reach thresold
                                        else{
                                            imageOffset[id - 1].offset = -(reader.size.width-20 + 60)
                                        }
                                    }
                                }
                            }
                        }
                    )
                }
            }
        }.frame(width: 300, height: 400)
            .padding(.top, -CGFloat(scrolled * 18))
        // Circle carousel indicator
        HStack(spacing: 10){
            ForEach(0..<7){ i in
                Circle()
                    .fill(Color.black.opacity(scrolled == i ? 0.9 : 0.1))
                    .frame(width: 8, height: 8)
                    .scaleEffect(scrolled == i ? 1.15 : 1)
                    .animation(.spring(), value: scrolled == i)
            }
        }.padding(.top, 20 + CGFloat(scrolled * 18))
            .padding(.bottom, 20)
    }
}

struct ImageCarousel{
    var offset: CGFloat
}
