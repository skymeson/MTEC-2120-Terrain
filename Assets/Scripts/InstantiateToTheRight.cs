using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InstantiateToTheRight : MonoBehaviour
{
    public GameObject someObject;
    Vector3 thePosition;
    void Start()
    {
        //Instantiate an object to the right of the current object
        thePosition = transform.TransformPoint(Vector3.right * 2);
        Instantiate(someObject, thePosition, someObject.transform.rotation);
    }
}
