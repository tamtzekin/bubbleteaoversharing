using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CharacterManager : MonoBehaviour {

    //Created this value for ease of reference.
    public int charNumber;

    Animator anim;

    GameObject eyesOne;
    GameObject eyesTwo;
    GameObject mouthOne;
    GameObject mouthTwo;

	// Use this for initialization
	void Start () {
        anim = GetComponentInChildren<Animator>();

        //Finding eyes and mouths within the prefab
        eyesOne = transform.Find("BodyParts/eyes_plate").gameObject;
        eyesTwo = transform.Find("BodyParts/eyes_plate_2").gameObject;
        mouthOne = transform.Find("BodyParts/mouth_plate").gameObject;
        mouthTwo = transform.Find("BodyParts/mouth_plate_2").gameObject;

        //Default expression is happy.
        charExpression("happy");
	}
	
	// Update is called once per frame
	void Update () {
	}

    //Triggers: Walk, Talk, Satisfied, Upset.
    public void setAnim(string trigger)
    {
        anim.SetTrigger(trigger);
    }

    //Either "happy" or sad"
    public void charExpression (string happyOrSad)
    {
        if (happyOrSad == "happy")
        {
            eyesOne.SetActive(true);
            eyesTwo.SetActive(false);
            mouthOne.SetActive(true);
            mouthTwo.SetActive(false);
        } else if (happyOrSad == "sad")
        {
            eyesOne.SetActive(false);
            eyesTwo.SetActive(true);
            mouthOne.SetActive(false);
            mouthTwo.SetActive(true);
        }
    }
}
