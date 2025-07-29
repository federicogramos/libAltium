{..............................................................................}
{ Summary Demo the rotation of an existing component on a current PCB.         }
{ Copyright (c) 2004 by Altium Limited                                         }
{..............................................................................}

{..............................................................................}
Procedure RotateAComponent;
Var
    Board     : IPCB_Board;
    Iterator  : IPCB_BoardIterator;
    Component : IPCB_Component;
    Layer     : TLayer;
Begin
    Board := PCBServer.GetCurrentPCBBoard;
    If Board = Nil Then Exit;

    // Initialize the PCB editor.
    PCBServer.PreProcess;

    //Grab the first component from the PCB only.
    Iterator        := Board.BoardIterator_Create;
    Iterator.AddFilter_ObjectSet(MkSet(eComponentObject));
    Iterator.AddFilter_LayerSet(AllLayers);
    Iterator.AddFilter_Method(eProcessAll);

    Component := Iterator.FirstPCBObject;

    // If no components found, exit.
    If Component = Nil Then
    Begin
        Board.BoardIterator_Destroy(Iterator);
        Exit;
    End;

    // Notify the PCB that the pcb object is going to be modified
    PCBServer.SendMessageToRobots(Component.I_ObjectAddress, c_Broadcast, PCBM_BeginModify , c_NoEventData);


    // Set the reference point of the component.
    // Note that IPCB_Component is inherited from IPCB_Group
    // and thus the X,Y properties are inherited.
    Component.X := Component.X + MilsToCoord(100);
    Component.Y := Component.Y + MilsToCoord(100);

    // Rotate a component 45 degrees.
    Component.Rotation := 45;

    // If Component is on Top layer, its placed on bottom layer and vice versa.
    Layer := Component.Layer;
    If (Layer = eTopLayer) Then
    Begin
        Component.Layer := eBottomLayer;
    End
    Else If (Layer = eBottomLayer) Then
        Component.Layer := eTopLayer;

    // Notify the PCB editor that the pcb object has been modified
    PCBServer.SendMessageToRobots(Component.I_ObjectAddress, c_Broadcast, PCBM_EndModify , c_NoEventData);

    Board.BoardIterator_Destroy(Iterator);

    // Reset the PCB
    PCBServer.PostProcess;

    Client.SendMessage('PCB:Zoom', 'Action=Redraw' , 255, Client.CurrentView);
End;
{..............................................................................}

{..............................................................................}
