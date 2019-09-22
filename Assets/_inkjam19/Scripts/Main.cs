using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Main : MonoBehaviour
{
	[SerializeField]
	VNManager vnManager;

	[SerializeField]
	Canvas menuCanvas;

	void Start()
	{
		menuCanvas.gameObject.SetActive(false);
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
