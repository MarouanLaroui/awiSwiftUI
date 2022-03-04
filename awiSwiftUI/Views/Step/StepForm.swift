//
//  StepForm.swift
//  awiSwiftUI
//
//  Created by Marouan Laroui  on 25/02/2022.
//

import SwiftUI

struct StepForm: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var stepVM : StepFormVM = StepFormVM(model: Step(title: "", description: "", time: 1, ingredients: [:]))
    @ObservedObject var recipe : Recipe
    var gridItems = [GridItem(.adaptive(minimum : 150))]
    var listIntent : StepIntent
    var intent = StepIntent()
    
    init(intent : StepIntent, stepFormVM : StepFormVM? = nil, recipe : Recipe){

        self.recipe = recipe
        if (stepFormVM != nil) {self.stepVM = stepFormVM!}
        
        self.listIntent = intent
        self.intent.addObserver(viewModel: stepVM)
    }
    
    var body: some View {
        ScrollView{
            VStack(alignment : .leading){
                LazyVGrid(columns: gridItems, alignment : .leading){
                    Group{
                        Text("Titre : ")
                        TextField("Renseignez un titre", text: $stepVM.title)
                            .onSubmit {
                                self.intent.intentToChange(title: self.stepVM.title)
                            }
                        
                        
                        Text("Description :")
                        TextField("Renseignez une description", text: $stepVM.description)
                            .onSubmit {
                                self.intent.intentToChange(description: self.stepVM.description)
                            }
                        
                        
                        Text("Durée :")
                        TextField("Renseignez une durée", value: $stepVM.time, formatter: Formatters.int)
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
                            .onSubmit {
                                self.intent.intentToChange(ingredient: ingredient, quantity: stepVM.ingredients[ingredient]!)
                            }
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
            .navigationTitle("Informations sur l'étape")
            
            Button("Enregistrer l'étape"){
                print(self.stepVM.model.ingredients)
                Task{
                    await self.listIntent.intentToChange(stepToAdd: self.stepVM.model, recipeId: self.recipe.id!)
                    self.presentationMode.wrappedValue.dismiss()
                }
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
