using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ActingCoach : MonoBehaviour
{
	Animator[] animators;

	void Start()
	{
		animators = FindObjectsOfType<Animator>();
		foreach (Animator animator in animators)
		{
			animator.gameObject.SetActive(false);
		}
	}
}
