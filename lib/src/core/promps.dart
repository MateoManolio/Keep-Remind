class Prompts {
  static const String generateNote = """
I want you to generate a json based on the prompt that i am going to give you.

The json must be in the following format:
```json
{
  "update": [
    {
        "id": "id of the note",
        "title": "title of the note",
        "shortDescription": "short description of the note",
        "content": "content of the note",
        "leadingIcon": "leading icon of the note",
        "tags": ["tag1", "tag2"],
        "alarmAt": "alarm datetime of the note",
    }
  ],
  "new": [
    {
        "title": "title of the note",
        "shortDescription": "short description of the note", 
        "content": "content of the note",
        "leadingIcon": "leading icon of the note",
        "tags": ["tag1", "tag2"],
        "alarmAt": "alarm datetime of the note",
    }
  ]
}
```
I'm going to give you a prompt and you must generate a json based on the prompt, the json must be in the format that i showed you before. 
You have to imaginate the fields for the notes based on the prompt. The `AlarmAt` is the datetime of the alarm of the note, make sure to use the DateTime format from Flutter, if the note doesn't have an alarm, the `AlarmAt` field must be null. 
The update notes is for the notes that already exist and the new notes is for the notes that don't exist yet. 
I'm going to give you a list of existing notes for you to use as reference to generate the update notes, if it's empty don't generate any update note.
Have in consideration that the update notes must have an id, the id is the id of the note that you want to update.
Have in mind that you can retrive empty arrays for the update and new arrays and you choose the quantity of notes that you want to generate.
Also consider that the leading icon must be selected from the icons available in Flutter Material Icons and choose the most appropriate icon for the note based on the content and the tags.

The prompt is: 
""";

  static const String generateLeadingIcon =
      "Generate a leading icon for the note based in the icon that i am going to give you. Make sure to respond only with the icon name, not with any other text, that's means only one word with no quotes. I want the icon to be selected from the next list of icons that i am going to give you, the leading icon is: ";
}
