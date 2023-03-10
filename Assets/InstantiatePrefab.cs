using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InstantiatePrefab : MonoBehaviour
{
    public GameObject prefab;

    // Start is called before the first frame update
    void Start()
    {
        Spawn3DGridPrefabs();
    }

    public void Spawn3DGridPrefabs()
    {
        float spacing = 10;
         
        for (int i = 0; i < 10; i++)
        {
            for (int j = 0; j < 10; j++)
            {
                for (int k = 0; k < 10; k++)
                {
                    float x = i * spacing;
                    float y = j * spacing;
                    float z = k * spacing;
                    GameObject go = Instantiate(prefab, new Vector3(x, y, z), Quaternion.identity);

                    Renderer rend = go.GetComponent<Renderer>();
                    rend.material.color = GetColorRGB(x / 10 / spacing, y / 10 / spacing, z / 10 / spacing);
                }
            }
        }
    }

    public void SpawnCirclePrefabs()
    {
        for (int i = 0; i < 12; i++)
        {
            float x = 5 * Mathf.Cos(2 * Mathf.PI * i / 12);
            float y = 5 * Mathf.Sin(2 * Mathf.PI * i / 12);
            Instantiate(prefab, new Vector3(x, 5, y), Quaternion.identity);


        }
    }

    public Color GetRandomColor()
    {
        return new Color(UnityEngine.Random.Range(0f, 1f), UnityEngine.Random.Range(0f, 1f), UnityEngine.Random.Range(0f, 1f));
    }

    public Color GetColorRGB(float r, float g, float b)
    {
        return new Color(r, g, b);
    }
}
