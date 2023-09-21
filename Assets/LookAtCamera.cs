using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LookAtCamera : MonoBehaviour
{
    [SerializeField] private GameObject objectToLook;
    [SerializeField]private GameObject objectThatLook;
    [SerializeField] private float yPos;
    private Vector3 objectToLooKPos;

    void Start()
    {
        // Encuentra la cámara principal en la escena
        //cameraTransform = Camera.main.transform;
    }

    private void FixedUpdate()
    {
        LookAtMe();
    }
    private void LookAtMe()
    {
        objectToLooKPos = objectToLook.transform.position;
        objectToLooKPos.y = yPos;
        objectThatLook.transform.LookAt(objectToLooKPos);
    }


}
