//
//  StepRow.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 20/02/2022.
//

import SwiftUI

struct StepRow: View {
    @State var numEtape : Int
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text("Etape " + String(numEtape) + " :")
                    .font(.title2)
                    .bold()
                Text("Mélanger les oeufs")
                    .font(.title3)
            }
            Text("Dans un saladier mélangez les différents ingrédients jusqu`à obtention d'une pate homogène")
                .font(.body)
            
        }
        
    }
}

struct StepRow_Previews: PreviewProvider {
    static var previews: some View {
        StepRow(numEtape: 2)
    }
}
