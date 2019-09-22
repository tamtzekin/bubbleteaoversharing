using UnityEngine;
using UnityEngine.UI;
using Ink.Runtime;

public class VNManager : MonoBehaviour
{
	[SerializeField]
	Main main;

	[SerializeField]
	private TextAsset inkJSONAsset;
	private Story story;

	// UI Prefabs
	[SerializeField]
	private Button buttonPrefab;

	[SerializeField]
	private GameObject choiceHolder;

	[Header("Dialogue")]

	[SerializeField]
	GameObject dialogueBox;

	[SerializeField]
	private Text dialogueText;

	[SerializeField]
	GameObject speakerBox;

	[SerializeField]
	private Text speakerText;

	[Header("Cinematographer")]
	[SerializeField]
	CameraDirector cameraDirector;

	// Use this for initialization
	void Awake ()
	{
		dialogueBox.SetActive(false);
		speakerBox.SetActive(false);
		story = new Story(inkJSONAsset.text);
		dialogueText.text = "";
	}

	public void StartStory()
	{
		RefreshView();
	}

	// Update is called once per frame
	void Update ()
	{
		if(story.canContinue || choiceHolder.transform.childCount == 0)
		{
			if (Input.anyKeyDown && !Input.GetKeyDown(KeyCode.Escape))
			{
				RefreshView();
			}
		}

		for (int i = 0; i < choiceHolder.transform.childCount; i++)
		{
			string keyName = (i + 1).ToString();
			if (Input.GetKeyDown(keyName))
			{
				story.ChooseChoiceIndex(i);
				RefreshView();
			}
		}
	}

	void RefreshView()
	{
		// Remove all the UI on screen
		RemoveChildren();

		// Read all the content until we can't continue any more
		if (story.canContinue)
		{
			string text;
			do
			{
				// Continue gets the next line of the story
				text = story.Continue();
				// This removes any white space from the text.
				text = text.Trim();
				if(text.StartsWith("CAMERA"))
				{// If we're changing the camera
					string cameraName = text.Substring(7);
					Debug.Log("change camera to " + cameraName);
					cameraDirector.ChangeCamera(cameraName);
					text = "";// Skip this line
				}
			}
			while (text.Length == 0 && story.canContinue);
			// Display the text on screen!
			if ((text.Length > 0))
			{
				dialogueBox.SetActive(true);
				CreateContentView(text);
				return;
			}
		}

		// Display all the choices, if there are any!
		if (story.currentChoices.Count > 0)
		{
			Debug.Log("Choices " + story.currentChoices.Count);
			for (int i = 0; i < story.currentChoices.Count; i++)
			{
				Choice choice = story.currentChoices[i];
				Button button = CreateChoiceView(choice.text.Trim());
				// Tell the button what to do when we press it
				button.onClick.AddListener(delegate {
					OnClickChoiceButton(choice);
				});
			}
		}
		else
		{// If we've read all the content and there's no choices, the story is finished!
			Button choice = CreateChoiceView("THE END");
			choice.onClick.AddListener(delegate
			{
				RemoveChildren();
				main.Credits();
			});
		}
	}

	// When we click the choice button, tell the story to choose that choice!
	void OnClickChoiceButton(Choice choice)
	{
		story.ChooseChoiceIndex(choice.index);
		RefreshView();
	}

	// Updates dialogue showing the choice text
	void CreateContentView(string text)
	{
		int colonIndex = text.IndexOf(':');
		if(colonIndex > 0)
		{// Text has a speaker
			string speaker = text.Substring(0, colonIndex);
			speakerBox.SetActive(true);
			speakerText.text = speaker;
			dialogueText.text = text.Substring(colonIndex+1).Trim();
		}
		else
		{
			speakerBox.SetActive(false);
			dialogueText.text = text;
		}
	}

	// Creates a button showing the choice text
	Button CreateChoiceView(string text)
	{
		// Creates the button from a prefab
		Button choice = Instantiate(buttonPrefab) as Button;
		choice.transform.SetParent(choiceHolder.transform, false);

		// Gets the text from the button prefab
		Text choiceText = choice.GetComponentInChildren<Text>();
		choiceText.text = text;

		return choice;
	}

	// Destroys all the children of this gameobject (all the UI)
	void RemoveChildren()
	{
		int childCount = choiceHolder.transform.childCount;
		for (int i = childCount - 1; i >= 0; --i)
		{
			GameObject.Destroy(choiceHolder.transform.GetChild(i).gameObject);
		}
	}

    //returns a variable from ink script
    public object GetInkVar(string inkVar)
    {
        return story.variablesState[inkVar];
    }
}
