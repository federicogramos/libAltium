{..............................................................................}
{ Summary Queries the layers of IPCB_MechanicalLayer type.                     }
{         IPCB_MechanicalLayer interface introduced in Altium Designer SP3     }
{                                                                              }
{ Copyright (c) 2005 by Altium Limited                                         }
{..............................................................................}

{..............................................................................}
Function BooleanToString(AValue : Boolean) : String;
Begin
    Result := 'False';
    If AValue Then Result := 'True';
End;
{..............................................................................}

{..............................................................................}
Procedure QueryAllMechLayers;
Var
    PCBBoard      : IPCB_Board;
    TheLayerStack : IPCB_LayerStack;
    i             : Integer;
    LayerObj      : IPCB_MechanicalLayer;
    Layer         : TLayer;
    LS            : String;
Begin
    PCBBoard := PCBServer.GetCurrentPCBBoard;
    If PCBBoard = Nil Then Exit;

    // Note that the Layer stack only stores existing copper based layers.
    // But you can use the LayerObject property to fetch all layers.
    TheLayerStack := PCBBoard.LayerStack;
    If TheLayerStack = Nil Then Exit;

    LS := '';
    For Layer := eMechanical1 to eMechanical16 Do
    Begin
        LayerObj := TheLayerStack.LayerObject[Layer];
        ShowMessage(Layer2String(Layer) + #13 +
                    ' linked '                         + BooleanToString(LayerObj.LinkToSheet) + #13 +
                    ' enabled '                        + BooleanToString(LayerObj.MechanicalLayerEnabled) + #13 +
                    ' displayed in single layer mode ' + BooleanToString(LayerObj.DisplayInSingleLayerMode) + #13);
        End;
    End;
End;
{..............................................................................}

{..............................................................................}
