import SwiftUI

struct FoodRecipesView: View {
    @StateObject private var viewModel = RecipeViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer().frame(height: 20)
                if viewModel.recipes.isEmpty {
                    Spacer()
                    
                    Image(systemName: "fork.knife.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 201)
                        .foregroundColor(.orange)
                    
                    Text("There's no recipe yet")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Please add your recipes")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Spacer()
                } else { // List of saved recipes
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(viewModel.recipes) { recipe in
                                NavigationLink(destination: RecipeDetailView(viewModel: viewModel, recipe: recipe)) {
                                    ZStack(alignment: .bottomLeading) {
                                        if let image = recipe.image {
                                            Image(uiImage: image)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: UIScreen.main.bounds.width, height: 250) // Full screen width
                                                .clipped()
                                        }
                                        // Semi-transparent overlay for text
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color.black.opacity(0.9), Color.clear]),
                                            startPoint: .bottom,
                                            endPoint: .top
                                        )
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(recipe.title)
                                                .font(.headline)
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                            
                                            Text(recipe.description)
                                                .font(.subheadline)
                                                .foregroundColor(.white)
                                                .lineLimit(2)
                                        }
                                        .padding()
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Food Recipes")  // Apply these to NavigationStack content
            .toolbar {
                NavigationLink(destination: NewRecipeView(viewModel: viewModel)) {
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundColor(.orange)
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

struct FoodRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        FoodRecipesView()
    }
}

