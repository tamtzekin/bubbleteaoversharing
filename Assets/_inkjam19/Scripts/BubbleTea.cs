using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BubbleTea : MonoBehaviour
{
	[SerializeField]
	bool strawIn = true;

	[Header("Submodels")]

	[SerializeField]
	GameObject strawObject;

	void Start()
	{
		if(!strawIn)
		{
			strawObject.SetActive(false);
		}
	}
}
