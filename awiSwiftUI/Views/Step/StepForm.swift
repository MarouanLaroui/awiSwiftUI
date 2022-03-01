//
//  StepForm.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 25/02/2022.
//

import SwiftUI

struct StepForm: View {
    
    @ObservedObject var stepVM : StepFormVM = StepFormVM(model: Step(title: "", description: "", time: 1, ingredients: [:]))
    var gridItems = [GridItem(.adaptive(minimum : 150))]
    var intent : StepIntent
    
    init(intent : StepIntent, stepFormVM : StepFormVM? = nil){
        if let stepFormVM = stepFormVM {
            self.stepVM = stepFormVM
        }
        self.intent = intent
        self.intent.addObserver(viewModel: stepVM)
    }
    
    var body: some View {
        ScrollView{
            VStack(alignment : .leading){
                LazyVGrid(columns: gridItems, alignment : .leading){
                    Group{
                        Text("Title")
                        TextField("enter a title", text: $stepVM.title)
                        Text("Description :")
                        TextField("enter a description", text: $stepVM.description)
                        Text("Time :")
                        TextField("", value: $stepVM.time, formatter: Formatters.int)
                    }
                }
                
                Spacer()
                
                Text("Ingredients")
                    .font(.largeTitle)
                    .bold()
                
                HStack{
                    Spacer()
                    NavigationLink(destination: SelectIngredientForStep()){
                        Image(systemName: "plus")
                    }
                }
                List{
                    ForEach(stepVM.ingredients.keys.sorted(), id : \.self){
                        ingredient in
                        HStack{
                            Text(ingredient.name)
                            Text("\(stepVM.ingredients[ingredient]!)")
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .padding()
            .navigationTitle("Step Informations")
        }
        
    }
}
/*
struct StepForm_Previews: PreviewProvider {
    static var previews: some View {
        StepForm()
    }
}
*/
