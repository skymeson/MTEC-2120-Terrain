using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HW5Listener : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        HW5.OnClick += OnClickEventListener;  // += means subscribe to events

    }



    void OnClickEventListener(GameObject g)
    {
        Debug.Log("Raycast hit gameobject : " + g.name);
    }
}
