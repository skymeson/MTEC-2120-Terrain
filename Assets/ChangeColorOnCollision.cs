using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ChangeColorOnCollision : MonoBehaviour
{

    public Color GetRandomColor()
    {
        return new Color(UnityEngine.Random.Range(0f, 1f), UnityEngine.Random.Range(0f, 1f), UnityEngine.Random.Range(0f, 1f));

    }


    public void OnCollisionEnter(Collision collision)
    {
        Renderer rend = GetComponent<Renderer>();
        rend.material.color = GetRandomColor();
        Debug.Log("OnCollisionEnter : " + collision.gameObject.name);
    }

}
