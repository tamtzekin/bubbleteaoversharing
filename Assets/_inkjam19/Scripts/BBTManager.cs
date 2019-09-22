using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class BBTManager : MonoBehaviour {
    [SerializeField]
    VNManager vnManager;
    CameraDirector cameraDirector;
    [SerializeField]
    BubbleTeaRecipe recipe;
    [SerializeField]
    List<Ingredient> availableIngredients;
    [SerializeField]
    int selectedIngredient = 0;
    int SelectedIngredient {
        get { return selectedIngredient; }
        set { if (value < recipe.Ingredients.Count)
            {
                selectedIngredient = value;
            }
        }
    }
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
    }

    // Update is called once per frame
    void Update () {
        manageInput();
	}

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
                if(Input.GetKey(KeyCode.Q))
                {
                    //fill with ingredient 0
                }
                break;
            case 1:
                if (Input.GetKey(KeyCode.W))
                {
                    //fill with ingredient 1
                }
                break;
            case 2:
                if (Input.GetKey(KeyCode.E))
                {
                    //fill with ingredient 2
                }
                break;
            case 3:
                if (Input.GetKey(KeyCode.R))
                {
                    //fill with ingredient 3
                }
                break;
            case 4:
                if (Input.GetKey(KeyCode.T))
                {
                    //fill with ingredient 4
                }
                break;
            case 5:
                if (Input.GetKey(KeyCode.Y))
                {
                    //fill with ingredient 5
                }
                break;
            case 6:
                if (Input.GetKey(KeyCode.U))
                {
                    //fill with ingredient 6
                }
                break;
            case 7:
                if (Input.GetKey(KeyCode.I))
                {
                    //fill with ingredient 7
                }
                break;
            case 8:
                if (Input.GetKey(KeyCode.O))
                {
                    //fill with ingredient 8
                }
                break;
            case 9:
                if (Input.GetKey(KeyCode.P))
                {
                    //fill with ingredient 9
                }
                break;
        }

        if (Input.GetKeyUp(KeyCode.Q) && SelectedIngredient != 0)
        {
            SelectedIngredient = 0;
        }
        if (Input.GetKeyUp(KeyCode.W) && SelectedIngredient != 1)
        {
            SelectedIngredient = 1;
        }
        if (Input.GetKeyUp(KeyCode.E) && SelectedIngredient != 2)
        {
            SelectedIngredient = 2;
        }
        if (Input.GetKeyUp(KeyCode.R) && SelectedIngredient != 3)
        {
            SelectedIngredient = 3;      
        }
        if (Input.GetKeyUp(KeyCode.T) && SelectedIngredient != 4)
        {
            SelectedIngredient = 4;
        }
        if (Input.GetKeyUp(KeyCode.Y) && SelectedIngredient != 5)
        {
            SelectedIngredient = 5;
        }
        if (Input.GetKeyUp(KeyCode.U) && SelectedIngredient != 6)
        {
            SelectedIngredient = 6;
        }
        if (Input.GetKeyUp(KeyCode.I) && SelectedIngredient != 7)
        {
            SelectedIngredient = 7;
        }
        if (Input.GetKeyUp(KeyCode.O) && SelectedIngredient != 8)
        {
            SelectedIngredient = 8;
        }
        if (Input.GetKeyUp(KeyCode.P) && SelectedIngredient != 9)
        {
            SelectedIngredient = 9;
        }
    }
}
