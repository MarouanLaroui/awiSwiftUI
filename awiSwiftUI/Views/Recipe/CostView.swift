//
//  CostView.swift
//  awiSwiftUI
//
//  Created by m1 on 02/03/2022.
//

import Foundation
import SwiftUI

struct CostView : View {
    var threeColumns: [GridItem] =
             Array(repeating: .init(.flexible()), count: 3)
    var twoColumns: [GridItem] =
             Array(repeating: .init(.flexible()), count: 2)
        
    @State var recipe : Recipe
    @State var durationTime : Int
    
    @State var coefficient = 2
    @State var totalCost = 0
    @State var costPerPortion : Double = 0

    //Input
    @State var fluidCostPerHour = 3
    @State var employeCostPerHour = 15
    @State var seasoningPercentage  = 5
    
    //Coûts matières première
    @State var ingredientCost = 0
    @State var seasoningTotal = 0
    @State var subtotal = 0
    
    //Coûts de production
    @State var fluidCost = 0
    @State var employeCost = 0
    
    //Coût total
    @State var totalSellingPrice : Double = 0
    @State var sellingPriceByPortion : Double = 0
    @State var totalBenefice : Double = 0
    @State var beneficeByPortion : Double = 0
    @State var rentabilityThreshold : Double = 0
    
    
    func calculateCosts() {
        self.seasoningTotal = (self.seasoningPercentage*ingredientCost/100)
        self.subtotal = self.seasoningTotal + self.ingredientCost
        self.fluidCost = (self.fluidCostPerHour * self.durationTime)
        self.employeCost = (self.employeCostPerHour * (self.durationTime)/60)
        self.totalCost = self.subtotal + self.fluidCost + self.employeCost
        
        self.totalSellingPrice = Double(self.totalCost + self.coefficient)
        self.sellingPriceByPortion = Double(self.totalSellingPrice) / Double(self.recipe.nbOfServing)
        self.rentabilityThreshold = ceil(Double(self.totalCost) / self.sellingPriceByPortion)
        self.totalBenefice = self.totalSellingPrice - Double(self.totalCost)
        self.beneficeByPortion = self.totalBenefice / Double(self.recipe.nbOfServing)
        self.costPerPortion = Double(self.totalCost) / Double(self.recipe.nbOfServing)
        
        self.sellingPriceByPortion = round(self.sellingPriceByPortion * 100)/100
        self.rentabilityThreshold = round(self.rentabilityThreshold * 100)/100
        self.totalBenefice = round(self.totalBenefice * 100)/100
        self.beneficeByPortion = round(self.beneficeByPortion * 100)/100
        self.costPerPortion = round(self.costPerPortion * 100)/100
    }
    
    
    var body: some View{
        ScrollView{
            
            //----- PARAMETRAGE du calcul des coûts -----
            Group{
                Text("Paramétrage du calcul des coûts")
                    .font(.largeTitle)
                    .bold()
                
                //Pourcentage coût de l'assaisonnement
                HStack{
                    Text("Pourcentage du coût de l'assaisonnement : ")
                    TextField("",value : $seasoningPercentage, formatter:  Formatters.int)
                }
                
                //Coût personnel horaire
                HStack{
                    Text("Coût personnel horaire : ")
                    TextField("",value : $employeCostPerHour, formatter:  Formatters.int)
                }
                
                //Coût horaire fluide
                HStack{
                    Text("Coût horaire fluide : ")
                    TextField("",value : $fluidCostPerHour, formatter:  Formatters.int)
                }
                
                //Coefficient
                HStack{
                    Text("Coefficient : ")
                    TextField("",value : $coefficient, formatter:  Formatters.decimal)
                }
            }
            
            .padding(.horizontal)
            
            //----- COÛTS MATIERES PREMIERES -----
            Group{
                LazyVGrid(columns: threeColumns){
                    
                    //Coût matière des ingrédients = ingredientCost
                    VStack{
                        Text("\(ingredientCost)€")
                            .font(.title2)
                            .foregroundColor(Color.salmon)
                        Text("Coût matière des ingrédients")
                            .opacity(0.7)
                            .multilineTextAlignment(.center)
                    }
                    .padding(15)
                    
                    //Coût de l'assaisonnement = seasoningTotal
                    VStack{
                        Text("\(seasoningTotal)€")
                            .font(.title2)
                            .foregroundColor(Color.salmon)
                        Text("Coût de l'assaisonnement")
                            .opacity(0.7)
                            .multilineTextAlignment(.center)
                    }
                    .padding(15)
                    
                    //Sous total matière/assaisonnement = subtotal
                    VStack{
                        Text("\(subtotal)€")
                            .font(.title2)
                            .foregroundColor(Color.salmon)
                        Text("Sous total matière/assaisonnement")
                            .opacity(0.7)
                            .multilineTextAlignment(.center)
                    }
                    .padding(15)
                    
                }
            }
            
            //----- COÛTS DE PRODUCTION -----
            Group{
                LazyVGrid(columns: twoColumns){
                    
                    //Coût concernant le personnel = employeCost
                    VStack{
                        Text("\(employeCost)€")
                            .font(.title2)
                            .foregroundColor(Color.salmon)
                        Text("Coût concernant le personnel")
                            .opacity(0.7)
                            .multilineTextAlignment(.center)
                    }
                    .padding(15)
                    
                    //Coût concernant les fluides = fluidCost
                    VStack{
                        Text("\(fluidCost)€")
                            .font(.title2)
                            .foregroundColor(Color.salmon)
                        Text("Coût concernant les fluides")
                            .opacity(0.7)
                            .multilineTextAlignment(.center)
                    }
                    .padding(15)
                    
                }
            }
            
            
            //----- COUT TOTAL ET INFORMATIONS -----
            Group{
                
                LazyVGrid(columns: twoColumns){
                    //Coût total de la recette = totalCost
                    VStack{
                        Text("\(totalCost)€")
                            .font(.title2)
                            .foregroundColor(Color.salmon)
                        Text("Coût total de la recette")
                            .opacity(0.7)
                    }
                    .padding(15)
                    
                    //Coût par portion = costPerPortion
                    VStack{
                        Text("\(costPerPortion, specifier: "%.2f")€")
                            .font(.title2)
                            .foregroundColor(Color.salmon)
                        Text("Coût par portion")
                            .opacity(0.7)
                    }
                    .padding(15)
                    
                    
                }
                
                VStack{
                    
                    Text("Statistiques de vente")
                        .font(.largeTitle)
                        .bold()
                        
                }
                .padding()
            }
            
            Group{
                LazyVGrid(columns: threeColumns){
                    
                    //Prix de vente total = totalSellingPrice
                    VStack{
                        Text("\(totalSellingPrice, specifier: "%.2f")€")
                            .font(.title2)
                            .foregroundColor(Color.salmon)
                        Text("Prix de vente total")
                            .opacity(0.7)
                            .multilineTextAlignment(.center)
                    }
                    .padding(15)
                    
                    //Prix de vente par unité = sellingPriceByPortion
                    VStack{
                        Text("\(sellingPriceByPortion, specifier: "%.2f")€")
                            .font(.title2)
                            .foregroundColor(Color.salmon)
                        Text("Prix de vente par unité")
                            .opacity(0.7)
                            .multilineTextAlignment(.center)
                    }
                    .padding(15)
                    
                    //Bénéfice total de la recette = totalbenefice
                    VStack{
                        Text("\(totalBenefice, specifier: "%.2f")€")
                            .font(.title2)
                            .foregroundColor(Color.salmon)
                        Text("Bénéfice total de la recette")
                            .opacity(0.7)
                            .multilineTextAlignment(.center)
                    }
                    .padding(15)
                    
                }
            }
            
            
            LazyVGrid(columns: twoColumns){
                //beneficeByPortion = this.totalBenefice / this.nbOfServing;
                VStack{
                    Text("\(beneficeByPortion, specifier: "%.2f")€")
                        .font(.title2)
                        .foregroundColor(Color.salmon)
                    Text("Bénéfice par portion")
                        .opacity(0.7)
                }
                .padding(15)
                
                //rentabilityThreshold = Math.ceil(this.totalCost / this.sellingPriceByPortion)
                VStack{
                    Text("\(rentabilityThreshold, specifier: "%.2f")€")
                        .font(.title2)
                        .foregroundColor(Color.salmon)
                    Text("Seuil de rentabilité de la recette")
                        .opacity(0.7)
                        .multilineTextAlignment(.center)
                }
                .padding(15)
                
            }
            
        }
        .padding(.bottom, 50)
        .padding(.top, 50)
        .task{
            let resultCost = await RecipeDAO.getRecipeCost(id: self.recipe.id!)
        
            //Coût
            switch(resultCost){
            case .success(let resIngredientCost):
                self.ingredientCost = resIngredientCost
            case .failure(let error):
                print("error while retrieving ingredientCost" + error.localizedDescription)
            }
            
        }
        
        // -- CALCUL DES COÛTS --
        .onAppear{
            calculateCosts()
        }
        .onSubmit {
            calculateCosts()
        }
        
            
    }
}
