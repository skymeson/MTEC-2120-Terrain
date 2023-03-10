using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MyOrbitScript : MonoBehaviour
{
    //[SerializeField] private GameObject objectToOrbit;

    public GameObject sun;
    public Vector3 rotationAxis;
    public float rotationAngle = 1.0f;
    private float countdown = 1.0f;
   // Transform tran;
    // Start is called before the first frame update
    void Start()
    {
        //tran.position = new Vector3(0, 1, 0);  
    }

    // Update is called once per frame
    void Update()
    {
        //Transform orbitTransform = objectToOrbit.transform;
        //Vector3 orbitPosition = orbitTransform.position;
        //Vector3 orbitAxis = Vector3.up; //orbit around y axis
        //float orbitAngle = 1.0f;

        CountdownToColorChange();
        //transform.RotateAround(orbitPosition, orbitAxis, orbitAngle);
        transform.RotateAround(sun.transform.position, rotationAxis, rotationAngle);

    }

    public void CountdownToColorChange()
    {
        if(countdown < 0)
        {
            Renderer rend = sun.GetComponent<Renderer>();
            rend.material.color = sun.GetComponent<MyFirstScript>().GetRandomColor();
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
