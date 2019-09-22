using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[System.Serializable]
public class IngredientScore
{
    public Ingredient ingredient;
    [Range(0, 4)]
    public int score;
}