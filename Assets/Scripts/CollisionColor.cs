using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CollisionColor : MonoBehaviour
{
    MeshRenderer thisRenderer;

    // Start is called before the first frame update
    void Start()
    {
        thisRenderer = GetComponent<MeshRenderer>();
    }
    private void OnCollisionEnter(Collision collision)
    {
        Color randomColor = new Color(Random.Range(0.0f, 1.0f), 
                                      Random.Range(0.0f, 1.0f), 
                                      Random.Range(0.0f, 1.0f));
        Material newMaterial = new Material(thisRenderer.material);
        newMaterial.SetColor("_Color", randomColor);
        thisRenderer.material = newMaterial;
    }

   /* private void OnTriggerEnter(Collider other)
    {
        Debug.Log(other.name);
    }*/
}
