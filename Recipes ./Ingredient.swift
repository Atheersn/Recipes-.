import SwiftUI
import Combine

class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var ingredients: [Ingredient] = [] // Store ingredients for the current recipe being created

    // Function to add a new recipe
    func addRecipe(title: String, description: String, image: UIImage?) {
        let newRecipe = Recipe(title: title, description: description, ingredients: ingredients, image: image)
        recipes.append(newRecipe)
        ingredients.removeAll() // Clear ingredients for the next recipe
    }
    
    // Function to add a single ingredient
    func addIngredient(name: String, measurement: String, serving: Int) {
        guard !name.isEmpty else { return }
        let ingredient = Ingredient(name: name, measurement: measurement, serving: serving)
        ingredients.append(ingredient)
    }
    
    // Function to delete a recipe
    func deleteRecipe(_ recipe: Recipe) {
        if let index = recipes.firstIndex(where: { $0.id == recipe.id }) {
            recipes.remove(at: index)
        }
    }
}

