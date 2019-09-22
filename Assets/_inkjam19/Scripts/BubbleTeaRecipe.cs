using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BubbleTeaRecipe : MonoBehaviour
{
    [Header("Boba Properties")]
    [SerializeField]
    string teaName;
    [SerializeField]
    List<IngredientScore> ingredientScores;
    public List<IngredientScore> IngredientScores
    {
        get { return ingredientScores; }
        set { ingredientScores = value; }
    }
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
    [SerializeField]
    Color teaColor;
    public Color TeaColor
    {
        get { return teaColor; }
    }
}
