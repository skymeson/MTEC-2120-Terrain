using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HelloWorld : MonoBehaviour
{

    GameObject prefab; 
    // Start is called before the first frame update
    void Start()
    {
        Debug.Log("The result is : " + Mathf.Max(5, 10));
    }

    // Update is called once per frame
    void Update()
    {
        if(Input.GetKeyDown(KeyCode.Space))
        {
            Ray ray = new Ray(transform.position, transform.forward);
            RaycastHit rayHit;

            if (Physics.Raycast(ray, out rayHit, Mathf.Infinity))
            {
                Debug.Log("Hello world!" + rayHit.point);
                GameObject bullet = Instantiate(prefab, rayHit.point, Quaternion.Euler(90, 0, 0)); 

            }

        }
    }
}
