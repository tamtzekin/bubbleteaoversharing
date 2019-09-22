using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BubbleTeaRecipe : MonoBehaviour
{
    [Header("Boba Properties")]
    [SerializeField]
    string teaName;
    [SerializeField]
    List<Ingredient> ingredients;
    [SerializeField]
    Color teaColor;

    public List<Ingredient> Ingredients {
        get { return ingredients; }
    }
}
