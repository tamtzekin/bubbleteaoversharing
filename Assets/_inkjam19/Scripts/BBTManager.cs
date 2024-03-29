﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class BBTManager : MonoBehaviour {
	[SerializeField]
	VNManager vnManager;

    BubbleTea bubbleTea;
    Vector3 initBBTSize;
    public BubbleTea BubbleTea
    {
        get { return bubbleTea; }
        set { bubbleTea = value; }
    }
    [Header("Boba Recipe")]
    [SerializeField]
    BubbleTeaRecipe recipe;
    List<Ingredient> availableIngredients;

    int selectedIngredient = -1;
    int SelectedIngredientIndex {
        get { return selectedIngredient; }
        set {
            if (value != selectedIngredient)
            {
                if (value < recipe.Ingredients.Count)
                {
                    selectedIngredient = value;
                    updateToppingUI();
                    updateCurrentTopping();
                }
            }
        }
    }

    // "UI - Toppings"
    Image prevTopping;
    Image currentTopping;
    Image nextTopping;
    Text assignedLetter;
    Text toppingName;

    [Header("UI - Stamina")]
    public int maxStamina;
    Image staminaBar;
    int storyTiredness = 0;
    public int StoryTiredness
    {
        get { return storyTiredness; }
        set
        {
            storyTiredness = value;
            UpdateStaminaBar();
        }
    }
    int workTiredness = 0;
    public int WorkTiredness
    {
        get { return workTiredness; }
        set
        {
            workTiredness = value;
            UpdateStaminaBar();
        }
    }

    [Header("Mods")]
    public float teaFillSpeed;
    public float ingredientTimerIncrement;
    float ingredientTimer;
    float t;
    KeyCode[] ingredientKeyCodes;

	// Use this for initialization
	void Awake () {
        //stamina = maxStamina;
        bubbleTea = GameObject.Find("BubbleTea").GetComponent<BubbleTea>();
        initBBTSize = bubbleTea.gameObject.transform.localScale;
        initKeyCodes();
        LoadUI();
        LoadIngredients();
	}

    int Tiredness()
    {
        return storyTiredness + workTiredness;
    }

    int stamina()
    {
        return maxStamina - Tiredness();
    }

    //store which keys control toppings in array
    void initKeyCodes()
    {
        ingredientKeyCodes = new KeyCode[10];
        ingredientKeyCodes[0] = KeyCode.Q;
        ingredientKeyCodes[1] = KeyCode.W;
        ingredientKeyCodes[2] = KeyCode.E;
        ingredientKeyCodes[3] = KeyCode.R;
        ingredientKeyCodes[4] = KeyCode.T;
        ingredientKeyCodes[5] = KeyCode.Y;
        ingredientKeyCodes[6] = KeyCode.U;
        ingredientKeyCodes[7] = KeyCode.I;
        ingredientKeyCodes[8] = KeyCode.O;
        ingredientKeyCodes[9] = KeyCode.P;
    }

    //Set all variables for UI
    void LoadUI()
    {
        prevTopping = GameObject.Find("PrevTopping").GetComponent<Image>();
        currentTopping = GameObject.Find("CurrentTopping").GetComponent<Image>();
        nextTopping = GameObject.Find("NextTopping").GetComponent<Image>();

        assignedLetter = GameObject.Find("AssignedLetter").GetComponent<Text>();
        toppingName = GameObject.Find("ToppingName").GetComponent<Text>();

        //staminaBar = GameObject.Find("TirednessBar").GetComponent<Image>();
    }

    //stamina bar moves depending on value of stamina
    void UpdateStaminaBar()
    {
        staminaBar.rectTransform.localPosition = new Vector2(((float)stamina() / (float)maxStamina * 100), 0);
    }

    // read the recipe and assign keys to ingredients
    void LoadIngredients()
    {
        availableIngredients = recipe.Ingredients;
        bubbleTea.SetTeaColor(recipe.TeaColor);
        bubbleTea.InitIngredientScores(recipe.IngredientScores);
        SelectedIngredientIndex = Random.Range(0, recipe.IngredientScores.Count - 1);
    }

    // Update is called once per frame
    void Update () {
        manageInput();
        /*if(staminaBar.transform.parent.localScale.x != 10)
        {
            //0.3f of a sec, move back to original scale
            t += Time.deltaTime / 0.3f;
            staminaBar.transform.parent.localScale = Vector3.Lerp(staminaBar.transform.parent.localScale, new Vector3(10f, 10f), t);
        } else
        {
            t = 0;
        }*/

		//Seal the deal
		if (Input.GetKeyUp(KeyCode.S) && !BubbleTea.LidOn)
		{
			//Debug.Log(vnManager.GetInkVar("tiredness"));
			BubbleTea.SealDrink();
			StartCoroutine(vnManager.RestartStoryCoroutine());
		}
	}

    //manage what happens with the different toppings
    void fillToppingWithLetter(KeyCode kc)
    {
        //cannot add anything to drink if sealed or tired
        if (canUseAction() && !bubbleTea.LidOn)
        {
            if (Input.GetKey(kc))
            {
				//hacks
                if (IngredientString(SelectedIngredientIndex) == "Ice2" || IngredientString(SelectedIngredientIndex) == "Sugar2")
                {
                    //if ice or sugar user holds down key to slowly increase %
                    ingredientTimer += Time.deltaTime;
                    if (ingredientTimer >= ingredientTimerIncrement)
                    {
                        int newScore = bubbleTea.GetIngredientScore(SelectedIngredientIndex) + 1;
                        if (newScore <= 4)
                        {
                            bubbleTea.AddIngredient(availableIngredients[SelectedIngredientIndex]);
                            bubbleTea.modIngredientScore(SelectedIngredientIndex, newScore);
                            //show % UI
                            GameObject levelsText = (GameObject)Instantiate(Resources.Load("Prefabs/FloatingNumber"));
                            levelsText.transform.SetParent(bubbleTea.gameObject.transform);
                            levelsText.GetComponent<RectTransform>().localPosition = new Vector3(0, 100, -5);
                            levelsText.GetComponent<RectTransform>().localRotation = new Quaternion(0, 0, 0, 1);
                            levelsText.GetComponent<TextMeshPro>().text = (newScore * 25) + "%";
                        }
                        ingredientTimer = 0;
                    }
                }
                else if (IngredientString(SelectedIngredientIndex) == "Tea")
                {
                    //increase cup fill
                    bubbleTea.AddTea(teaFillSpeed);
                    bubbleTea.modIngredientScore(SelectedIngredientIndex, (int)(bubbleTea.FillLevel * 4f));
                }
                else if (IngredientString(SelectedIngredientIndex) == "Milk")
                {
                    //change bubble tea color to white-ish
                    bubbleTea.AddMilk(teaFillSpeed * Time.deltaTime);
                }
                else
                {
                    //make score max (4) when anything else is added
                    bubbleTea.AddIngredient(availableIngredients[SelectedIngredientIndex]);
                    bubbleTea.modIngredientScore(SelectedIngredientIndex, 4);
                }
            }
        }
        if(Input.GetKeyUp(kc))
        {
            if (!bubbleTea.LidOn)
            {
                if (canUseAction())
                {
                    if (IngredientString(SelectedIngredientIndex) == "Milk")
                    {
                        //complete the milk addition regardless of time held
                        bubbleTea.AddMilk(1f);
                        bubbleTea.modIngredientScore(SelectedIngredientIndex, 4);
                    }
                    //add tiredness after any action
                    //WorkTiredness++;
                }
                else
                {
                    //blip stamina bar if empty
                    staminaBar.transform.parent.localScale = new Vector3(11f, 10f);
                }
            }
        }
    }

    //check for if lid on and has stamina
    bool canUseAction()
    {
        return stamina() > 0;
    }

    //manage the keyboard input
    void manageInput()
    {
         //depending which ingredient is selected fill it
        if (SelectedIngredientIndex >= 0)
        {
            fillToppingWithLetter(ingredientKeyCodes[SelectedIngredientIndex]);
        }

        //switch between selected ingredients with QWERTY keys
        if (ingredientKeyCodes.Length > 0)
        {
            for (int i = 0; i < ingredientKeyCodes.Length; i++)
            {
                if (Input.GetKeyUp(ingredientKeyCodes[i]))
                {
                    SelectedIngredientIndex = i;
                }
            }
        }
    }

    // ?crosscheck scores of recipe to bubbletea
    public float GetTeaScore()
    {
        int recipeScore = 0;
        int userScore = 0;
        for(int i = 0; i < recipe.IngredientScores.Count; i++)
        {
            recipeScore += recipe.IngredientScores[i].score;
            userScore += bubbleTea.GetIngredientScore(i);
        }
        float descrepency = Mathf.Abs(userScore - recipeScore);
        return (recipeScore - descrepency) / recipeScore;
    }

    //Display correct letter for selected ingredient
    void assignToppingLetter()
    {
        assignedLetter.text = ingredientKeyCodes[SelectedIngredientIndex].ToString();
    }

    //extract string from Ingredient class with associated index i
    string IngredientString(int i)
    {
        string s = "";
        s += availableIngredients[i];
        s = s.Replace(" (Ingredient)", "");
        return s;
    }

    //grouped method
    void updateToppingUI()
    {
        updatePrevTopping();
        updateCurrentTopping();
        updateNextTopping();
    }

    //changes sprites for topping UI
    void updatePrevTopping()
    {
        if (SelectedIngredientIndex >= 1)
        {
            prevTopping.sprite = Resources.Load<Sprite>("Sprites/" + IngredientString(SelectedIngredientIndex - 1) + "_icon");
            prevTopping.color = Color.white;
        }
        else
        {
            prevTopping.sprite = null;
            prevTopping.color = Color.clear;
        }
    }

    //changes sprites for topping UI
    void updateNextTopping()
    {
        if (SelectedIngredientIndex < availableIngredients.Count - 1)
        {
            nextTopping.sprite = Resources.Load<Sprite>("Sprites/" + IngredientString(SelectedIngredientIndex + 1) + "_icon");
            nextTopping.color = Color.white;
        }
        else
        {
            nextTopping.sprite = null;
            nextTopping.color = Color.clear;
        }
    }

    //changes sprites for topping UI
    void updateCurrentTopping()
    {
        assignToppingLetter();
        toppingName.text = IngredientString(SelectedIngredientIndex);
        currentTopping.sprite = Resources.Load<Sprite>("Sprites/" + IngredientString(SelectedIngredientIndex) + "_icon");
        currentTopping.color = Color.white;
    }

    public void SetDrinkSize(string size)
    {
        if (size == "large")
        {
            bubbleTea.gameObject.transform.localScale *= 1.5f;
        }
        else
        {
            bubbleTea.gameObject.transform.localScale = initBBTSize;
        }
    }
}
