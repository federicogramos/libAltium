{..............................................................................}
{ Summary Queries mechanical layers of the current PCB document.               }
{ Copyright (c) 2004 by Altium Limited                                         }
{..............................................................................}
Procedure QueryMechLayers;
Var
    Board   : IPCB_Board;
    Layer   : TLayer;
    LS      : IPCB_LayerStack;
    LObject : IPCB_LayerObject;
    S       : String;
Begin
    Board := PCBServer.GetCurrentPCBBoard;
    If Board = Nil Then Exit;
    LS := Board.LayerStack;
    If LS = Nil Then Exit;
    S := '';

    For Layer := eMechanical1 to eMechanical16 Do
    Begin
        LObject := LS.LayerObject[Layer];
        // If a mechanical layer is not enabled (as per the Board Layers and
        //   Colors dialog) then this layer cannot be displayed nor have any objects on it.
        If Not (LObject.MechanicalLayerEnabled) Then
            S := S + LObject.Name + ' is NOT enabled (thus it cannot be displayed nor have any objects on it).' + #13
        Else
        Begin
           If (LObject.IsDisplayed[Board] = True) and (LObject.UsedByPrims) Then
               S := S + LObject.Name + ' is displayed and there are objects on it.' + #13;

           If (LObject.IsDisplayed[Board] = True) and Not (LObject.UsedByPrims) Then
               S := S+ LObject.Name + ' is displayed and there are NO objects on it.' + #13;

           If (LObject.IsDisplayed[Board] = False) and (LObject.UsedByPrims) Then
                S := S + LObject.Name + ' is NOT displayed and there are objects on it.' + #13;

           If (LObject.IsDisplayed[Board] = False) and Not (LObject.UsedByPrims) Then

              S := S + LObject.Name + ' is NOT displayed and there are NO objects on it.' + #13;
        End;

    // The IsInLayerStack property checks whether the layer is part of the layer
    // stack or not.
    // If Not LObject.IsInLayerStack
    // ShowMessage(LObject.Name + 'is not in layer stack!');

    End;
    ShowMessage(S);
End;
{..............................................................................}

{..............................................................................}
