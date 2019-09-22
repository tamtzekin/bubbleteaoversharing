using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class BBTManager : MonoBehaviour {
    [SerializeField]
    VNManager vnManager;
    [SerializeField]
    BubbleTea bubbleTea;
    [Header("Boba Recipe")]
    [SerializeField]
    BubbleTeaRecipe recipe;
    List<Ingredient> availableIngredients;
    [Header("UI")]
    int selectedIngredient;
    int SelectedIngredient {
        get { return selectedIngredient; }
        set {
            if (value != selectedIngredient)
            {
                if (value < recipe.Ingredients.Count)
                {
                    selectedIngredient = value;
                    assignToppingLetter();
                    toppingName.text = IngredientString();
                    currentTopping.sprite = Resources.Load<Sprite>("Sprites/" + IngredientString() + "_icon");
                    currentTopping.color = new Color(1, 1, 1, 1);
                }
            }
        }
    }
    [SerializeField]
    Image currentTopping;
    [SerializeField]
    Text assignedLetter;
    [SerializeField]
    Text toppingName;
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

	// Use this for initialization
	void Start () {
        stamina = maxStamina;
	}

    void UpdateStaminaBar()
    {
        staminaBar.rectTransform.localPosition = new Vector2(((float)stamina / (float)maxStamina * 100), 0);
    }

    // read the recipe and assign keys to ingredients
    void LoadIngredients()
    {
        availableIngredients = recipe.Ingredients;
        SelectedIngredient = 0;
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
            if (IngredientString() == "Ice" || IngredientString() == "Sugar")
            {
                //do the hold thing
                Debug.Log("ADD " + IngredientString());
            }
            else
            {
                bubbleTea.AddIngredient(availableIngredients[SelectedIngredient]);
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

        switch (SelectedIngredient)
        {
            case 0:
                fillToppingWithLetter(KeyCode.Q);
                break;
            case 1:
                fillToppingWithLetter(KeyCode.W);
                break;
            case 2:
                fillToppingWithLetter(KeyCode.E);
                break;
            case 3:
                fillToppingWithLetter(KeyCode.R);
                break;
            case 4:
                fillToppingWithLetter(KeyCode.T);
                break;
            case 5:
                fillToppingWithLetter(KeyCode.Y);
                break;
            case 6:
                fillToppingWithLetter(KeyCode.U);
                break;
            case 7:
                fillToppingWithLetter(KeyCode.I);
                break;
            case 8:
                fillToppingWithLetter(KeyCode.O);
                break;
            case 9:
                fillToppingWithLetter(KeyCode.P);
                break;
        }

        if (Input.GetKeyUp(KeyCode.Q))
        {
            SelectedIngredient = 0;
        }
        if (Input.GetKeyUp(KeyCode.W))
        {
            SelectedIngredient = 1;
        }
        if (Input.GetKeyUp(KeyCode.E))
        {
            SelectedIngredient = 2;
        }
        if (Input.GetKeyUp(KeyCode.R))
        {
            SelectedIngredient = 3;      
        }
        if (Input.GetKeyUp(KeyCode.T))
        {
            SelectedIngredient = 4;
        }
        if (Input.GetKeyUp(KeyCode.Y))
        {
            SelectedIngredient = 5;
        }
        if (Input.GetKeyUp(KeyCode.U))
        {
            SelectedIngredient = 6;
        }
        if (Input.GetKeyUp(KeyCode.I))
        {
            SelectedIngredient = 7;
        }
        if (Input.GetKeyUp(KeyCode.O))
        {
            SelectedIngredient = 8;
        }
        if (Input.GetKeyUp(KeyCode.P))
        {
            SelectedIngredient = 9;
        }
    }

    //Display correct letter for selected ingredient
    void assignToppingLetter()
    {
        switch (SelectedIngredient)
        {
            case 0:
                assignedLetter.text = "Q";
                break;
            case 1:
                assignedLetter.text = "W";
                break;
            case 2:
                assignedLetter.text = "E";
                break;
            case 3:
                assignedLetter.text = "R";
                break;
            case 4:
                assignedLetter.text = "T";
                break;
            case 5:
                assignedLetter.text = "Y";
                break;
            case 6:
                assignedLetter.text = "U";
                break;
            case 7:
                assignedLetter.text = "I";
                break;
            case 8:
                assignedLetter.text = "O";
                break;
            case 9:
                assignedLetter.text = "P";
                break;
        }
    }

    //extract string from Ingredient class
    string IngredientString()
    {
        string s = "";
        s += availableIngredients[SelectedIngredient];
        s = s.Replace(" (Ingredient)", "");
        return s;
    }
}
