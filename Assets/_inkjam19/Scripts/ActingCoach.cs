﻿using System.Collections;
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

	public void EnterCharacter(string characterName)
	{
		foreach (CharacterManager characterManager in characterManagers)
		{
			if (characterManager.characterName == characterName)
			{
				GetComponent<AudioSource>().Play();
				characterManager.gameObject.SetActive(true);
			}
		}
	}

	public void ExitCharacter(string characterName)
	{
		foreach (CharacterManager characterManager in characterManagers)
		{
			if (characterManager.characterName == characterName)
			{
				characterManager.gameObject.SetActive(false);
			}
		}
	}

	public void CharacterChangeExpression(string characterName, string expression)
	{
		foreach (CharacterManager characterManager in characterManagers)
		{
			if (characterManager.characterName == characterName)
			{
				characterManager.charExpression(expression);
			}
		}
	}

	public void CharacterChangePose(string characterName, string pose)
	{
		foreach (CharacterManager characterManager in characterManagers)
		{
			if (characterManager.characterName == characterName)
			{
				characterManager.setAnim(pose);
			}
		}
	}
}
