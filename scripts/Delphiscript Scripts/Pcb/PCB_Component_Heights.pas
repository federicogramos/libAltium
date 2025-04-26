{..............................................................................}
{ Summary Changes the height property of a component on a current PCB document.}
{ Copyright (c) 2004 by Altium Limited                                         }
{..............................................................................}

{..............................................................................}
Procedure CompHeight;
Var
    Component : IPCB_Component;
    Iterator  : IPCB_BoardIterator;
    Board     : IPCB_Board;
Begin
    Board := PCBServer.GetCurrentPCBBoard;
    If Board = Nil Then Exit;

    Iterator := Board.BoardIterator_Create;
    Iterator.AddFilter_ObjectSet(MkSet(eComponentObject));
    Iterator.AddFilter_LayerSet(AllLayers);
    Iterator.AddFilter_Method(eProcessAll);

    // very first component on PCB document fetched.
    // best have a PCB with only one component.
    Component := Iterator.FirstPCBObject;
    If Component <> Nil Then
    Begin
        ShowInfo('Component Designator ' + Component.SourceDesignator + #13 +
                 'Component''s Original Height = ' + IntToStr(Component.Height));

        (* Notify PCB of a modify- the height of a component is going to be changed *)
        Try
           PCBServer.PreProcess;
           PCBServer.SendMessageToRobots(Component.I_ObjectAddress, c_Broadcast, PCBM_BeginModify, c_noEventData);

            (* objects coordinates are stored in internal coordinates values *)
            Component.Height := MilsToCoord(25);

            // notify PCB that the document is dirty bec comp height changed.
            PCBServer.SendMessageToRobots(Component.I_ObjectAddress, c_Broadcast, PCBM_EndModify, c_noEventData);
            Board.BoardIterator_Destroy(Iterator);
         Finally
             PCBServer.PostProcess;
         End;

         (* Check if component height has changed *)
          ShowInfo('Component Designator ' + Component.SourceDesignator + #13 +
                   'Component''s New Height = ' + IntToStr(CoordToMils(Component.Height)) + ' mils');
      End;
End;
{..............................................................................}

{..............................................................................}
