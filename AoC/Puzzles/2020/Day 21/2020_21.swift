//
//  2020_21.swift
//  AoC
//
//  Created by Joshua Gohlke on 1/6/21.
//


import Foundation

struct p2020_21: Puzzle {
//    var data = testInput.parseToStringArray()
    var data = input_2020_21.parseToStringArray()
    var runPart = 2
    
    func parseRecipe(_ line: String) -> (ingredients: [String], allergens: [String]) {
        var ing: [String] = []
        var all: [String] = []
        if line.contains(" (contains ") {
            let spl = line.components(separatedBy: " (contains ")
            spl[0].components(separatedBy: " ").forEach { ing.append($0) }
            spl[1].dropLast().components(separatedBy: ", ").forEach { all.append($0) }
        } else {
            line.components(separatedBy: " ").forEach { ing.append($0) }
        }
        return (ing,all)
    }
    
    
    func getMatches() -> [String: String] {
        var allergens: [String: [[String]]] = [:]
        for line in data {
            let response = parseRecipe(line)
            // add allergen to dict if does not exist
            for allergen in response.allergens {
                if allergens.has(key: allergen) {
                    allergens[allergen]!.append(response.ingredients)
                } else {
                    allergens[allergen] = [response.ingredients]
                }
            }
        }
        var commonIngredients: [String: [String]] = [:]
        // go through each allergen and find common ingredients
        for allergen in allergens {
            if allergen.value.count > 1 {
                var common: [String] = []
                common = allergen.value[0]
                for list in allergen.value[1...] {
                    // filter out uncommon elements
                    common = common.filter(list.contains)
                }
                commonIngredients[allergen.key] = common
            }
        }
        var matches: [String: String] = [:]
        // find allergens with a single common ingredient. These should be matches.
        commonIngredients.forEach { if $0.value.count == 1 { matches[$0.key] = $0.value[0] } }
        commonIngredients.removeAll(keys: matches.keys)
        
        // Do Until Empty: Remove matched pairs from commonIngredients and check again.
        while commonIngredients.count > 0 {
            for kv in commonIngredients {
                let tmp = kv.value
                for el in tmp {
                    if matches.values.contains(el) {
                        commonIngredients[kv.key]!.removeAll(where: {$0 == el})
                    }
                }
            }
            commonIngredients.forEach { if $0.value.count == 1 { matches[$0.key] = $0.value[0] } }
            commonIngredients.removeAll(keys: matches.keys)
        }
                
        // Go back through original list and remove ingredients that are matched. The
        // remaining item (hopefully) should be a match for unmatched allergens.
        for recipe in data.map({ parseRecipe($0) }) {
            var rem: [String] = []
            for ingredient in recipe.ingredients {
                if !matches.values.contains(ingredient){
                    rem.append(ingredient)
                }
            }
            if rem.count == 1 && recipe.allergens.count == 1 {
                if !matches.has(key: recipe.allergens[0]) {
                    matches[recipe.allergens[0]] = rem[0]
                }
            }
        }
        return matches
    }
    

    func part1() -> Any {
        let matches = getMatches()
        
        // Go through original list and count instances of ingredients that don't have a match to an allergen
        var cnt = 0
        for recipe in data.map({ parseRecipe($0) }) {
            for ingredient in recipe.ingredients {
                if !matches.values.contains(ingredient) {
                    cnt += 1
                }
            }
        }
        
        // return that count
        return cnt
    }

    func part2() -> Any {
        let matches = getMatches()
        return matches.keys.sorted().map { matches[$0]! }.joined(separator: ",")
    }
}


fileprivate let testInput = Data(raw: """
mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
trh fvjkl sbzzf mxmxvkd (contains dairy)
sqjhc fvjkl (contains soy)
sqjhc mxmxvkd sbzzf (contains fish)
""")  //  kfcds, nhms, sbzzf, trh  -> 5 instances // mxmxvkd,sqjhc,fvjkl



