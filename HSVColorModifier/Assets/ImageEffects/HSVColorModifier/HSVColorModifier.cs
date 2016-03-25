using UnityEngine;
using System.Collections;

namespace irishoak.ImageEffects {

	[ExecuteInEditMode]
	public class HSVColorModifier : MonoBehaviour {

		public Shader shader;

		Material _m;

		[Range(0, 1)]
		public float HueScale  = 1.0f;
		public float HueOffset = 0.0f;

		[Range(0, 1)]
		public float SaturationScale  = 1.0f;
		public float SaturationOffset = 0.0f;

		[Range(0, 1)]
		public float ValueScale  = 1.0f;
		public float ValueOffset = 0.0f;

		void OnRenderImage (RenderTexture src, RenderTexture dst) {

			if (_m == null) {
				_m = new Material (shader);
				_m.hideFlags = HideFlags.DontSave;
			}

			_m.SetFloat ("_HueScale",         HueScale);
			_m.SetFloat ("_HueOffset",        HueOffset);
			_m.SetFloat ("_SaturationScale",  SaturationScale);
			_m.SetFloat ("_SaturationOffset", SaturationOffset);
			_m.SetFloat ("_ValueScale",       ValueScale);
			_m.SetFloat ("_ValueOffset",      ValueOffset);

			Graphics.Blit (src, dst, _m);

		}

		void OnDestroy () {

			if (_m != null) {
				DestroyImmediate (_m);
			}
		
		}
	}
}