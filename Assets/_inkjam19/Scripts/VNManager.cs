using UnityEngine;
using UnityEngine.UI;
using Ink.Runtime;

public class VNManager : MonoBehaviour
{
	[SerializeField]
	private TextAsset inkJSONAsset;
	private Story story;

	// UI Prefabs
	[SerializeField]
	private Text dialogueText;
	[SerializeField]
	private Button buttonPrefab;

	[SerializeField]
	private GameObject choiceHolder;

	[SerializeField]
	GameObject dialogueBox;

	// Use this for initialization
	void Start ()
	{
		story = new Story(inkJSONAsset.text);
		dialogueText.text = "";
		StartStory();
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
			if (Input.anyKeyDown)
			{
				RefreshView();
			}
		}
		else if(choiceHolder.transform.childCount > 0)
		{
			if (Input.GetKeyDown("1"))
			{
				story.ChooseChoiceIndex(0);
				RefreshView();
			}
			else if (Input.GetKeyDown("2"))
			{
				story.ChooseChoiceIndex(1);
				RefreshView();
			}
			else if (Input.GetKeyDown("3"))
			{
				story.ChooseChoiceIndex(2);
				RefreshView();
			}
			else if (Input.GetKeyDown("4"))
			{
				story.ChooseChoiceIndex(3);
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
			// Continue gets the next line of the story
			string text = story.Continue();
			// This removes any white space from the text.
			text = text.Trim();
			// Display the text on screen!
			CreateContentView(text);
			return;
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
		// If we've read all the content and there's no choices, the story is finished!
		else
		{
		}
	}

	// When we click the choice button, tell the story to choose that choice!
	void OnClickChoiceButton(Choice choice)
	{
		story.ChooseChoiceIndex(choice.index);
		RefreshView();
	}

	// Creates a button showing the choice text
	void CreateContentView(string text)
	{
		dialogueText.text = text;
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
}
