using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Main : MonoBehaviour
{
	[SerializeField]
	VNManager vnManager;

	[SerializeField]
	Canvas menuCanvas;

	[SerializeField]
	Canvas startMenuCanvas;

	[SerializeField]
	CameraDirector cameraDirector;

	[SerializeField]
	GameObject credits;

	enum State { MainMenu, Credits, Game};

	State currentState;

	void Start()
	{
		currentState = State.MainMenu;
		menuCanvas.gameObject.SetActive(false);
		vnManager.gameObject.SetActive(false);
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
		cameraDirector.ChangeCamera("Main Camera");
		vnManager.gameObject.SetActive(true);
		vnManager.StartStory();
		currentState = State.Game;
	}

	public void Return()
	{
		vnManager.gameObject.SetActive(true);
		menuCanvas.gameObject.SetActive(false);
	}

	public void Quit()
	{
		Application.Quit();
	}
}
