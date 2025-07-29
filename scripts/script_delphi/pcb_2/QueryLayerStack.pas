{..............................................................................}
{ Summary Queries the Layer Stack of the current PCB document.                 }
{ Copyright (c) 2004 by Altium Limited                                         }
{..............................................................................}
Procedure QueryTheLayerStack;
Var
    PCBBoard      : IPCB_Board;
    TheLayerStack : IPCB_LayerStack;
    i             : Integer;
    LayerObj      : IPCB_LayerObject;
    LS            : String;
Begin
    PCBBoard := PCBServer.GetCurrentPCBBoard;
    If PCBBoard = Nil Then Exit;

    // Note that the Layer stack only stores existing copper based layers.
    // But you can use the LayerObject property to fetch all layers.
    TheLayerStack := PCBBoard.LayerStack;
    If TheLayerStack = Nil Then Exit;

    LS       := '';
    LayerObj := TheLayerStack.FirstLayer;
    Repeat
        LS       := LS + Layer2String(LayerObj.LayerID) + #13#10;
        LayerObj := TheLayerStack.NextLayer(LayerObj);
    Until LayerObj = Nil;

    ShowInfo('The Layer Stack has :'#13#10 + LS);
End;
{..............................................................................}

{..............................................................................}
