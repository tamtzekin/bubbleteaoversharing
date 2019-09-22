using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BubbleTea : MonoBehaviour
{
	[Header("Boba Appearance")]
	[SerializeField]
	bool strawIn = false;
    public bool StrawIn
    {
        get { return strawIn; }
        set
        {
            strawIn = value;
            strawObject.SetActive(value);
        }
    }
    [SerializeField]
	bool lidOn = false;
    public bool LidOn
    {
        get { return lidOn; }
        set
        {
            lidOn = value;
            lidObject.SetActive(value);
        }
    }

	[Range(0, 1)]
	[SerializeField]
	float fillLevel = 1.0f;
    public float FillLevel
    {
        get { return fillLevel; }
    }

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

    [SerializeField]
    List<IngredientScore> ingredientScores;

    void Start()
	{
	    strawObject.SetActive(StrawIn);
		lidObject.SetActive(LidOn);
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
        liquidRenderer.material.SetColor("_TopColor", teaColor);
    }

    public void AddMilk(float milkIncrement)
    {
        teaColor = Color.Lerp(teaColor, Color.white, milkIncrement);
        liquidRenderer.material.SetColor("_TopColor", teaColor);
    }

    public void AddIngredient(Ingredient ingredient)
    {
        if (!ingredients.Contains(ingredient))
        {
            ingredients.Add(ingredient);
            updateIngredients();
        }
    }

    public void AddTea(float speed)
    {
        fillLevel += speed * Time.deltaTime;
    }

    public void SealDrink()
    {
        LidOn = true;
    }

    public void InsertStraw()
    {
        StrawIn = true;
    }

    public void InitIngredientScores(List<IngredientScore> iScores)
    {
        ingredientScores = new List<IngredientScore>();
        foreach (IngredientScore iS in iScores)
        {
            IngredientScore temp = new IngredientScore();
            temp.ingredient = iS.ingredient;
            temp.score = 0;
            ingredientScores.Add(temp);
        }
    }

    public int GetIngredientScore(int index)
    {
        return ingredientScores[index].score;
    }

    public void modIngredientScore(int index, int score)
    {
        ingredientScores[index].score = Mathf.Clamp(score, 0, 4);
    }
}
