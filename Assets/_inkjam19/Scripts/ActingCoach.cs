using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ActingCoach : MonoBehaviour
{
	CharacterManager[] characterManagers;

	void Start()
	{
		characterManagers = FindObjectsOfType<CharacterManager>();
		foreach (CharacterManager characterManager in characterManagers)
		{
			characterManager.gameObject.SetActive(false);
		}
	}
}
