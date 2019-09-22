using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class FloatingNumber : MonoBehaviour {
    RectTransform rectTransform;
    public float duration;
    float t;
    Vector3 initPos;
    Color initColor;
    TextMeshPro textMesh;

    // Use this for initialization
    void Start () {
        rectTransform = gameObject.GetComponent<RectTransform>();
        textMesh = gameObject.GetComponent<TextMeshPro>();
        initPos = rectTransform.localPosition;
        initColor = textMesh.color;
    }
	
	// Update is called once per frame
	void Update () {
        t += Time.deltaTime / duration;
        //lerp from center to above cup
        rectTransform.localPosition = Vector3.Lerp(initPos, new Vector3(0, 200), t);
        if (rectTransform.localPosition.y >= 175)
        {
            //lerp from color to clear
            textMesh.color = Color.Lerp(initColor, Color.clear, t / 2f);
            if(textMesh.color.a <= 0.05)
            {
                Destroy(gameObject);
            }
        }
    }
}
