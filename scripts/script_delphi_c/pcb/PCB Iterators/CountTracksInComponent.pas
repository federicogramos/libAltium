{..............................................................................}
{ Summary Count tracks of five different components on a current PCB document. }
{ Copyright (c) 2004 by Altium Limited                                         }
{..............................................................................}

{..............................................................................}
Procedure CountTracks;
Var
    Track                   : IPCB_Primitive;
    TrackIteratorHandle     : IPCB_GroupIterator;
    Component               : IPCB_Component;
    ComponentIteratorHandle : IPCB_BoardIterator;
    TrackCount              : Integer;
    ComponentCount          : Integer;
    S                       : TPCBString;
Begin
    TrackCount     := 0;
    ComponentCount := 0;
    If PCBServer.GetCurrentPCBBoard = Nil Then Exit;

    ComponentIteratorHandle := PCBServer.GetCurrentPCBBoard.BoardIterator_Create;
    ComponentIteratorHandle.AddFilter_ObjectSet(MkSet(eComponentObject));
    ComponentIteratorHandle.AddFilter_LayerSet(AllLayers);
    ComponentIteratorHandle.AddFilter_Method(eProcessAll);

    S := '';
    Component := ComponentIteratorHandle.FirstPCBObject;
    While (Component <> Nil) Do
    Begin
        TrackIteratorHandle := Component.GroupIterator_Create;
        TrackIteratorHandle.AddFilter_ObjectSet(MkSet(eTrackObject));
        TrackIteratorHandle.AddFilter_LayerSet(MkSet(eTopOverlay));

        Track := TrackIteratorHandle.FirstPCBObject;
        While (Track <> Nil) Do
        Begin
            Inc(TrackCount);
            Track := TrackIteratorHandle.NextPCBObject;
        End;

        S := S + ('This component ' + Component.SourceDesignator  + ' has ' +  IntToStr(TrackCount)  + ' tracks.') + #13;

        TrackCount := 0;
        Component.GroupIterator_Destroy(TrackIteratorHandle);

        Component := ComponentIteratorHandle.NextPCBObject;
        Inc(ComponentCount);
        If (ComponentCount > 5) Then Break;
    End;
    ShowInfo(S);
    PCBServer.GetCurrentPCBBoard.BoardIterator_Destroy(ComponentIteratorHandle);
End;
{..............................................................................}

{..............................................................................}
