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
    int selectedIngredient = -1;
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
    KeyCode[] keyCodes;

	// Use this for initialization
	void Start () {
        stamina = maxStamina;
        initKeyCodes();
	}

    void initKeyCodes()
    {
        keyCodes = new KeyCode[10];
        keyCodes[0] = KeyCode.Q;
        keyCodes[1] = KeyCode.W;
        keyCodes[2] = KeyCode.E;
        keyCodes[3] = KeyCode.R;
        keyCodes[4] = KeyCode.T;
        keyCodes[5] = KeyCode.Y;
        keyCodes[6] = KeyCode.U;
        keyCodes[7] = KeyCode.I;
        keyCodes[8] = KeyCode.O;
        keyCodes[9] = KeyCode.P;
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
            if (IngredientString() == "Ice" || IngredientString() == "Sugar" || IngredientString() == "Tea")
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
        //depending which ingredient is selected fill it
        if (SelectedIngredient >= 0)
        {
            fillToppingWithLetter(keyCodes[SelectedIngredient]);
        }

        //switch between selected ingredients with QWERTY keys
        for (int i = 0; i < keyCodes.Length; i++)
        {
            if(Input.GetKeyUp(keyCodes[i]))
            {
                SelectedIngredient = i;
            }
        }
    }

    //Display correct letter for selected ingredient
    void assignToppingLetter()
    {
        assignedLetter.text = keyCodes[SelectedIngredient].ToString();
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
