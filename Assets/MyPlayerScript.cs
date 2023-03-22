using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

// Component to sit next to PlayerInput.
[RequireComponent(typeof(PlayerInput))]
public class MyPlayerScript : MonoBehaviour
{

    public float jumpForce = 1000;

    //public GameObject projectilePrefab;

    //private Vector2 m_Look;
    private Vector2 m_Move;
    //private bool m_Fire;

    // 'Fire' input action has been triggered. For 'Fire' we want continuous
    // action (that is, firing) while the fire button is held such that the action
    // gets triggered repeatedly while the button is down. We can easily set this
    // up by having a "Press" interaction on the button and setting it to repeat
    // at fixed intervals.
    //public void OnFire()
    //{
    //    Instantiate(projectilePrefab);
    //}



    public void OnJump(InputValue value)
    {

        float jumpVal = value.Get<float>();


        Debug.Log("On Jump called " + jumpVal);
        Rigidbody rigid = GetComponent<Rigidbody>();
        rigid.AddForce(0, jumpForce, 0);
    }


    // 'Move' input action has been triggered.
    public void OnMove(InputValue value)
    {
        m_Move = value.Get<Vector2>();

        // (0, 1) Up
        // (0, -1) Down
        // (-1, 0) Left
        // (1, 0) Right

    }

    //// 'Look' input action has been triggered.
    //public void OnLook(InputValue value)
    //{
    //    m_Look = value.Get<Vector2>();
    //}

    public void OnUpdate()
    {
        // Update transform from m_Move and m_Look
    }

}
