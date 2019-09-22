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

	void Start()
	{
		menuCanvas.gameObject.SetActive(false);
		vnManager.gameObject.SetActive(false);
		credits.SetActive(false);
		cameraDirector.ChangeCamera("CameraMenu");
	}

	void Update ()
	{
		if(Input.GetKeyDown(KeyCode.Escape))
		{
			vnManager.gameObject.SetActive(!vnManager.gameObject.activeSelf);
			if(!vnManager.gameObject.activeSelf)
			{
				menuCanvas.gameObject.SetActive(true);
			}
			else
			{
				menuCanvas.gameObject.SetActive(false);
			}
		}
	}

	public void Begin()
	{
		startMenuCanvas.gameObject.SetActive(false);
		cameraDirector.ChangeCamera("Main Camera");
		vnManager.gameObject.SetActive(true);
		vnManager.StartStory();
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
