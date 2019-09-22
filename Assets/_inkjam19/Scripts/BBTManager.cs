using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class BBTManager : MonoBehaviour {
    [SerializeField]
    VNManager vnManager;
    CameraDirector cameraDirector;

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

    // Update is called once per frame
    void Update () {

		if (Input.GetKeyUp(KeyCode.A))
        {
            Debug.Log(vnManager.GetInkVar("tiredness"));
            Stamina--;
        }
	}
}
