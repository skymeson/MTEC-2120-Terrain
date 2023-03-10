using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HundredGameObjectsHomework3 : MonoBehaviour
{
    public GameObject prefab;
    //[SerializeField] private GameObject objectToOrbit;

    // Start is called before the first frame update
    void Start()
    {
        SpawnCirclePrefabs();
    }

    public void SpawnCirclePrefabs()
    {
        for (int i = 0; i < 101; i++)
        {
            float x = 5 * Mathf.Cos(2 * Mathf.PI * i / 100);
            float y = 5 * Mathf.Sin(2 * Mathf.PI * i / 100);
            Instantiate(prefab, new Vector3(x, 5, y), Quaternion.identity);
        }
    }
}
