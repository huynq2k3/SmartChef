using System;
using System.Collections;
using System.Collections.Generic;
using Microsoft.Unity.VisualStudio.Editor;
using UnityEngine;
using UnityEngine.UI;
using Image = UnityEngine.UI.Image;

public class ProgressBarUI : MonoBehaviour
{
    [SerializeField] private GameObject iHasProgressGameObject;
    [SerializeField] private Image bar;

    private IHasProgress iHasProgress;
    private void Start()
    {
        iHasProgress = iHasProgressGameObject.GetComponent<IHasProgress>();
        iHasProgress.OnProgressChanged += IHasProgressOnProgressChanged;

        bar.fillAmount = 0;
        Hide();
    }

    private void IHasProgressOnProgressChanged(object sender, IHasProgress.OnProgressChangedEventArgs e)
    {
        bar.fillAmount = e.progressNormalized;
        
        if(e.progressNormalized == 0 || e.progressNormalized ==1)
            Hide();
        else Show();
    }

    void Show()
    {
        gameObject.SetActive(true);
    }

    void Hide()
    {
        gameObject.SetActive(false);
    }
}