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
		liquidRenderer.material.SetColor("_Tint", teaColor);
	}

	void Update()
	{
		liquidRenderer.material.SetFloat("_FillAmount", Mathf.Lerp(1.8f, -0.1f, fillLevel));
	}
}
