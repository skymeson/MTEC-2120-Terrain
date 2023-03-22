using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MyOrbitScript : MonoBehaviour
{

    public GameObject sun;

    public Vector3 rotationAxis;

    public float rotationAngle = 1.0f;

    private float countdown = 1.0f;

    Transform tran;

    private void Start()
    {
        tran.position = new Vector3(0, 1, 0); 
    }

    // Update is called once per frame
    void Update()
    {
        CountdownToColorChange();

    }


    public void RotateAroundSun()
    {
        transform.RotateAround(sun.transform.position, rotationAxis, rotationAngle);
    }

    public void CountdownToColorChange()
    {
        if(countdown < 0 )
        {
            Renderer rend = sun.GetComponent<Renderer>();
            rend.material.color = sun.GetComponent<MyFisrtScript>().GetRandomColor();
            countdown = 1.0f;
        }
        else
        {
            countdown -= Time.deltaTime; 
        }
    }


    public void OnCollisionEnter(Collision collision)
    {
        Debug.Log("OnCollisionEnter : " + collision.gameObject.name);
    }


    public void OnTriggerEnter(Collider other)
    {
        Debug.Log("OnTriggerEnter : " + other.gameObject.name);

    }
}
