using Godot;
using System;
using System.Reflection.Metadata;

public partial class dialogue_test : Node
{
	[Export]
	public RichTextLabel RTL;
	public string TextString = "Welcome to [color=gold][b]Hope's Peak Academy[/b][/color]!";
	
	public void _Ready() {
		RTL.Clear();
		for (int i = 0; i < TextString.Length; i++) {
			if (TextString[i] == '[') {
				int closingBracketIndex = TextString.IndexOf(']', i);
				if (closingBracketIndex != -1) {
					string tag = TextString.Substring(i, closingBracketIndex - i + 1);
					RTL.AppendText(tag);
					i = closingBracketIndex; // Move index to the end of the tag
				} else {
					RTL.AppendText(TextString[i].ToString());
				}
			} else {
				RTL.AppendText(TextString[i].ToString());
			}
		}
	}
}
