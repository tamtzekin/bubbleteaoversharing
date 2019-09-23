using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Main : MonoBehaviour
{
	[SerializeField]
	VNManager vnManager;

    GameObject gameplayUI;

	[SerializeField]
	Canvas menuCanvas;

	[SerializeField]
	Canvas startMenuCanvas;

	[SerializeField]
	CameraDirector cameraDirector;

	[SerializeField]
	GameObject credits;

	[SerializeField]
	GameObject[] creditsObjects;

	enum State { MainMenu, Credits, Game};

	State currentState;

	void Start()
	{
		currentState = State.MainMenu;
		menuCanvas.gameObject.SetActive(false);
		vnManager.gameObject.SetActive(false);
        gameplayUI = GameObject.Find("GameplayUI");
        gameplayUI.SetActive(false);
		credits.SetActive(false);
		cameraDirector.ChangeCamera("CameraMenu");
	}

	void Update ()
	{
		if (currentState == State.Game)
		{
			if (Input.GetKeyDown(KeyCode.Escape))
			{
				vnManager.gameObject.SetActive(!vnManager.gameObject.activeSelf);
                gameplayUI.SetActive(!vnManager.gameObject.activeSelf);
				if (!vnManager.gameObject.activeSelf)
				{
					menuCanvas.gameObject.SetActive(true);
				}
				else
				{
					menuCanvas.gameObject.SetActive(false);
				}
			}
		}
	}

	public void Begin()
	{
		startMenuCanvas.gameObject.SetActive(false);
		cameraDirector.ChangeCamera("SecondCamera");
		vnManager.gameObject.SetActive(true);
        gameplayUI.SetActive(true);
		vnManager.StartStory();
		currentState = State.Game;
	}

	public void Credits()
	{
		cameraDirector.ChangeCamera("CameraMenu");
		startMenuCanvas.gameObject.SetActive(false);
		credits.SetActive(true);
		for (int i = 0; i < creditsObjects.Length; i++)
		{
			creditsObjects[i].SetActive(false);
		}
		StartCoroutine(CreditsCoroutine());
	}

	IEnumerator CreditsCoroutine()
	{
		for(int i = 0; i < creditsObjects.Length; i++)
		{
			creditsObjects[i].SetActive(true);
			if(i > 0)
			{
				creditsObjects[i-1].SetActive(false);
			}
			yield return new WaitForSeconds(3f);
		}
		credits.SetActive(false);
		startMenuCanvas.gameObject.SetActive(true);
	}

	public void Return()
	{
		vnManager.gameObject.SetActive(true);
        gameplayUI.SetActive(true);
		menuCanvas.gameObject.SetActive(false);
	}

	public void Quit()
	{
		Application.Quit();
	}
}
