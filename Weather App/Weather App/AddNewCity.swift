//
//  AddNewCity.swift
//  Weather App
//
//  Created by Afrah Faisal on 04/02/1445 AH.
//

import SwiftUI

struct AddNewCity: View {
   @State var text = ""
    var body: some View {
        NavigationStack{
            VStack{
                TextField("new city" , text: $text)
                    .textFieldStyle(.roundedBorder)
                        .cornerRadius(5)
                       
            }
                .padding(.vertical, 4)
                .padding(.horizontal, 4)
            
                .navigationTitle("Add New City")
                .toolbar{
                    ToolbarItemGroup {
                        NavigationLink {
                            ContentView()
                        } label: {
                           Text("add")
                             .foregroundColor(.gray)
                                .bold()
                            .frame(width: 37 , height: 28)
                        }
                    }
                }
        }
       
            
    }
}
struct AddNewCity_Previews: PreviewProvider {
    static var previews: some View {
        AddNewCity()
    }
}

