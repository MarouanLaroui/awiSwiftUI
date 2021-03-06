//
//  StepRow.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 20/02/2022.
//

import SwiftUI

struct StepRow: View {
    
    @State var numEtape : Int
    @StateObject var step : Step
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text("Etape " + String(numEtape) + " :")
                    .font(.title2)
                    .bold()
                Text(step.title)
                    .font(.title3)
            }
            Text(step.description)
                .font(.body)
            
        }
        .padding(.horizontal)
        
        
    }
}
