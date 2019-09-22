using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BubbleTea : MonoBehaviour
{
	[SerializeField]
	bool strawIn = true;

	[SerializeField]
	bool lidOn = true;

	[Header("Submodels")]

	[SerializeField]
	GameObject strawObject;

	[SerializeField]
	GameObject lidObject;

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
	}
}
