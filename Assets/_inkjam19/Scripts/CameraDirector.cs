using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraDirector : MonoBehaviour
{
	Dictionary<string, GameObject> cameraDictionary = new Dictionary<string, GameObject>();

	GameObject activeCameraObject;

	void Start ()
	{
		Camera[] cameras = FindObjectsOfType<Camera>();
		foreach(Camera aCamera in cameras)
		{
			cameraDictionary.Add(aCamera.gameObject.name, aCamera.gameObject);
			if(aCamera != Camera.main)
			{
				aCamera.gameObject.SetActive(false);
			}
		}
		activeCameraObject = Camera.main.gameObject;
	}

	public void ChangeCamera(string cameraName)
	{
		if(!cameraDictionary.ContainsKey(cameraName))
		{
			Debug.LogError("Camera Doesn't exist: " + cameraName);
			return;
		}
		activeCameraObject.SetActive(false);
		activeCameraObject = cameraDictionary[cameraName];
		activeCameraObject.SetActive(true);
	}
}
