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
            print("not null stepFormVM")
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
                            .onSubmit {
                                self.intent.intentToChange(title: self.stepVM.title)
                            }
                        
                        
                        Text("Description :")
                        TextField("enter a description", text: $stepVM.description)
                            .onSubmit {
                                self.intent.intentToChange(description: self.stepVM.description)
                            }
                        
                        
                        Text("Time :")
                        TextField("", value: $stepVM.time, formatter: Formatters.int)
                            .onSubmit {
                                self.intent.intentToChange(time: self.stepVM.time)
                            }
                    }
                }
                
                Spacer()
                
                Text("Ingredients")
                    .font(.largeTitle)
                    .bold()
                
                HStack{
                    Spacer()
                    NavigationLink(destination: SelectIngredientForStep(intent : self.intent)){
                        Image(systemName: "plus")
                    }
                }
                
                
                ForEach(Array(self.stepVM.ingredients.keys), id: \.self) { ingredient in
                    HStack{
                        Text(ingredient.name)
                        Spacer()
                        TextField("",value: $stepVM.ingredients[ingredient],formatter : Formatters.int)
//                        Text("\(stepVM.ingredients[ingredient]!)")
                    }
                    Divider()
                }
                
                //                    ForEach(stepVM.ingredients.keys.sorted(), id : \.self){
                //
                //                        ingredient in
                //                        HStack{
                //                            Text("ok")
                //                            Text(ingredient.name)
                //                            Text("\(stepVM.ingredients[ingredient]!)")
                //                        }
                //                        .padding(.horizontal)
                //                    }
                //                    ForEach(self.stepVM.ingredients.sorted(by: >), id: \.key) { key, value in
                //                        HStack{
                //                            Text("ok")
                //                        }
                //                    }
                
            }
            .padding()
            .navigationTitle("Step Informations")
            
            Button("Save step"){
                self.intent.intentToChange(stepToAdd: self.stepVM.model)
            }
                .padding()
                .background(Color.salmon)
                .foregroundColor(.white)
                .cornerRadius(15)
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
