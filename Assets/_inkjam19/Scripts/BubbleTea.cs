using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BubbleTea : MonoBehaviour
{
	[Header("Boba Appearance")]
	[SerializeField]
	bool strawIn = true;

	[SerializeField]
	bool lidOn = true;

	[Range(0, 1)]
	[SerializeField]
	float fillLevel = 1.0f;

	[SerializeField]
	Color teaColor;

	[Header("Boba Properties")]
	[SerializeField]
	List<Ingredient> ingredients;

	[Header("Submodels")]

	[SerializeField]
	GameObject strawObject;

	[SerializeField]
	GameObject lidObject;

	[SerializeField]
	MeshRenderer liquidRenderer;

	[SerializeField]
	IngredientGroup[] ingredientGroups;

	void Start()
	{
		if(!strawIn)
		{
			strawObject.SetActive(false);
		}

		if (!lidOn)
		{
			lidObject.SetActive(false);
		}
		liquidRenderer.material.SetFloat("_FillAmount", Mathf.Lerp(1.8f, -0.1f, fillLevel));
        SetTeaColor(teaColor);
        updateIngredients();
	}

	void Update()
	{
		liquidRenderer.material.SetFloat("_FillAmount", Mathf.Lerp(1.8f, -0.1f, fillLevel));
	}

    void updateIngredients()
    {
        foreach (Ingredient ingredient in ingredients)
        {
            foreach (IngredientGroup ingredientGroup in ingredientGroups)
            {
                if (ingredientGroup.ingredient == ingredient)
                {
                    ingredientGroup.gameObject.SetActive(true);
                } 
            }
        }
    }

    public void SetTeaColor(Color color)
    {
        teaColor = color;
        liquidRenderer.material.SetColor("_Tint", teaColor);
    }

    public void AddIngredient(Ingredient ingredient)
    {
        if (!ingredients.Contains(ingredient))
        {
            ingredients.Add(ingredient);
            updateIngredients();
        }
    }
}
