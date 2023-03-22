using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class MyInputUnityEventExample : MonoBehaviour
{

    public float jumpForce = 1000; 
    public void OnJump(InputAction.CallbackContext context)
    {
        Debug.Log("On Jump called");
        Rigidbody rigid = GetComponent<Rigidbody>();
        rigid.AddForce(0, jumpForce, 0);
    }


}
