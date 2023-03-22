using System.Collections;
using System.Collections.Generic;
using UnityEngine;

using System;

public class MyFisrtScript : MonoBehaviour
{
    public float speed = 5;
    public Color color;

    private Renderer rend; 

    // Start is called before the first frame update
    void Start()
    {

        rend = GetComponent<Renderer>();
        rend.material.color = GetRandomColor(); 
    }

    public Color GetRandomColor()
    {
        return new Color(UnityEngine.Random.Range(0f, 1f), UnityEngine.Random.Range(0f, 1f), UnityEngine.Random.Range(0f, 1f));
         
    }

    // Update is called once per frame
    void Update()
    {
        if(Input.GetKeyDown(KeyCode.Space))
        {
            rend.material.color = GetRandomColor();
        }
    }
}
