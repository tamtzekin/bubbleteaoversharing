using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class BBTManager : MonoBehaviour {
    [SerializeField]
    VNManager vnManager;
    [SerializeField]
    BubbleTea bubbleTea;
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
    [Header("UI - Toppings")]
    [SerializeField]
    Image prevTopping;
    [SerializeField]
    Image currentTopping;
    [SerializeField]
    Image nextTopping;
    [SerializeField]
    Text assignedLetter;
    [SerializeField]
    Text toppingName;

    [Header("UI - Stamina")]
    public int maxStamina;
    public Image staminaBar;
    private int stamina;
    public int Stamina {
        get { return stamina; }
        set {
            stamina = value;
            UpdateStaminaBar();
        }
    }
    [Header("Mods")]
    public float teaFillSpeed;
    public float ingredientTimerIncrement;
    float ingredientTimer;
    KeyCode[] ingredientKeyCodes;

	// Use this for initialization
	void Start () {
        stamina = maxStamina;
        initKeyCodes();
	}

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

    void UpdateStaminaBar()
    {
        staminaBar.rectTransform.localPosition = new Vector2(((float)stamina / (float)maxStamina * 100), 0);
    }

    // read the recipe and assign keys to ingredients
    void LoadIngredients()
    {
        availableIngredients = recipe.Ingredients;
        bubbleTea.SetTeaColor(recipe.TeaColor);
        bubbleTea.InitIngredientScores(recipe.IngredientScores);
        SelectedIngredientIndex = 0;
    }

    // Update is called once per frame
    void Update () {
        manageInput();
	}

    //manage what happens with the different toppings
    void fillToppingWithLetter(KeyCode kc)
    {
        if(Input.GetKey(kc))
        {
            if (IngredientString(SelectedIngredientIndex) == "Ice" || IngredientString(SelectedIngredientIndex) == "Sugar")
            {
                ingredientTimer += Time.deltaTime;
                if(ingredientTimer >= ingredientTimerIncrement)
                {
                    int newScore = bubbleTea.GetIngredientScore(SelectedIngredientIndex) + 1;
                    if (newScore <= 4)
                    {
                        bubbleTea.modIngredientScore(SelectedIngredientIndex, newScore);
                        GameObject levelsText = (GameObject)Instantiate(Resources.Load("Prefabs/FloatingNumber"));
                        levelsText.transform.parent = bubbleTea.gameObject.transform;
                        levelsText.GetComponent<RectTransform>().localPosition = new Vector3(0, 100, -5);
                        levelsText.GetComponent<RectTransform>().localRotation = new Quaternion(0, 0, 0, 1);
                        levelsText.GetComponent<TextMeshPro>().text = "+" + (newScore * 25) + "%";
                    }
                    ingredientTimer = 0;
                }
            }
            else if (IngredientString(SelectedIngredientIndex) == "Tea")
            {
                //increase cup fill
                bubbleTea.AddTea(teaFillSpeed);
                Debug.Log(bubbleTea.FillLevel);
                bubbleTea.modIngredientScore(SelectedIngredientIndex, 4);
            }
            else if (IngredientString(SelectedIngredientIndex) == "Milk")
            {
                //change bubble tea color to white-ish
                bubbleTea.AddMilk(teaFillSpeed * Time.deltaTime);
            }
            else
            {
                bubbleTea.AddIngredient(availableIngredients[SelectedIngredientIndex]);
                bubbleTea.modIngredientScore(SelectedIngredientIndex, 4);
            }
        }
        if(Input.GetKeyUp(kc))
        {
            if (IngredientString(SelectedIngredientIndex) == "Milk")
            {
                //complete the milk addition regardless of time held
                bubbleTea.AddMilk(1f);
                bubbleTea.modIngredientScore(SelectedIngredientIndex, 4);
            }
        }
    }

    //manage the keyboard input
    void manageInput()
    {
        if (Input.GetKeyUp(KeyCode.A))
        {
            Debug.Log(vnManager.GetInkVar("tiredness"));
            Stamina--;
            LoadIngredients();
        }
        //depending which ingredient is selected fill it
        if (SelectedIngredientIndex >= 0)
        {
            fillToppingWithLetter(ingredientKeyCodes[SelectedIngredientIndex]);
        }

        //switch between selected ingredients with QWERTY keys
        for (int i = 0; i < ingredientKeyCodes.Length; i++)
        {
            if(Input.GetKeyUp(ingredientKeyCodes[i]))
            {
                SelectedIngredientIndex = i;
            }
        }
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

    void updateToppingUI()
    {
        updatePrevTopping();
        updateCurrentTopping();
        updateNextTopping();
    }

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

    void updateCurrentTopping()
    {
        assignToppingLetter();
        toppingName.text = IngredientString(SelectedIngredientIndex);
        currentTopping.sprite = Resources.Load<Sprite>("Sprites/" + IngredientString(SelectedIngredientIndex) + "_icon");
        currentTopping.color = Color.white;
    }
}
