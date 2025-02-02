﻿using Dacodelaac.Variables;
using UnityEngine;
using UnityEngine.EventSystems;
using Event = Dacodelaac.Events.Event;

public class FloatingJoystick : Joystick
{   
    public override void Initialize()
    {
        base.Initialize();
        // background.gameObject.SetActive(false);
    }

    public override void OnPointerDown(PointerEventData eventData)
    {
        // background.anchoredPosition = ScreenPointToAnchoredPosition(eventData.position);
        // background.gameObject.SetActive(true);
        base.OnPointerDown(eventData);
    }

    public override void OnPointerUp(PointerEventData eventData)
    {
        // background.gameObject.SetActive(false);
        base.OnPointerUp(eventData);
    }
}