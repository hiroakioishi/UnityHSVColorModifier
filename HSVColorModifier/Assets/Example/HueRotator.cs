using UnityEngine;
using System.Collections;

public class HueRotator : MonoBehaviour {

	public irishoak.ImageEffects.HSVColorModifier HSVColorModifierScript;

	void Start () {
	
	}
	
	void Update () {

		HSVColorModifierScript.HueOffset += Time.deltaTime * 0.25f;

	}
}
