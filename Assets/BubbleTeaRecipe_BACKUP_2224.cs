using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[System.Serializable]
public class IngredientScore
{
    public Ingredient ingredient;
    [Range(0, 4)]
    public int correctScore;
}

public class BubbleTeaRecipe : MonoBehaviour
{
    [Header("Boba Properties")]
    [SerializeField]
    string teaName;
    [SerializeField]
    List<IngredientScore> ingredientScores;
    [SerializeField]
    Color teaColor;

    //returns all ingredients in recipe
    public List<Ingredient> Ingredients {
        get {
            List<Ingredient> temp = new List<Ingredient>();
            foreach (IngredientScore ingScore in ingredientScores)
            {
                temp.Add(ingScore.ingredient);
            }
            return temp; }
    }
}
