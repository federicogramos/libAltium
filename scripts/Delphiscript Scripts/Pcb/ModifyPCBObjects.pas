{..............................................................................}
{ Summary Fetching and modifying PCB Objects and updating the Undo System      }
{ Use of the RobotManager interface to send PCB messages                       }
{ Copyright (c) 2004 by Altium Limited                                         }
{..............................................................................}

{..............................................................................}
Var
    Board : IPCB_Board;
    Fill  : IPCB_Fill;

{..................................................................................................}

{..............................................................................}
Procedure CreateObject(Dummy : Integer = 0);
Begin
    PCBServer.PreProcess;
    Fill     := PCBServer.PCBObjectFactory(eFillObject, eNoDimension, eCreate_Default);
    Fill.X1Location := MilsToCoord(4000);
    Fill.Y1Location := MilsToCoord(4000);
    Fill.X2Location := MilsToCoord(4400);
    Fill.Y2Location := MilsToCoord(4400);
    Fill.Rotation   := 0;
    Fill.Layer      := eTopLayer;

    // Adds the Fill object into the PCB database for the current PCB document.
    Board.AddPCBObject(Fill);
    PCBServer.PostProcess;
End;
{..................................................................................................}

{..................................................................................................}
Procedure ModifyObject(Dummy : Integer = 0);
Begin
    PCBServer.PreProcess;

    //Undo the fill object.
    PCBServer.SendMessageToRobots(Fill.I_ObjectAddress, c_Broadcast, PCBM_BeginModify , c_NoEventData);
    Fill.Layer := eBottomLayer;
    PCBServer.SendMessageToRobots(Fill.I_ObjectAddress, c_Broadcast, PCBM_EndModify , c_NoEventData);

    PCBServer.PostProcess;
End;
{..................................................................................................}

{..................................................................................................}
Procedure RemoveObject(Dummy : Integer = 0);
Begin
    PCBServer.PreProcess;

    //Remove the fill object.
    Board.RemovePCBObject(Fill);

    PCBServer.PostProcess;
End;
{..................................................................................................}

{..................................................................................................}
Procedure CreateModifyRemoveAObject;
Begin
    CreateNewDocumentFromDocumentKind('PCB');
    Board := PCBServer.GetCurrentPCBBoard;
    If Board = Nil Then Exit;

    ShowInfo('Creating an object');
    CreateObject;
    Client.SendMessage('PCB:Zoom', 'Action=Redraw' , 255, Client.CurrentView);

    ShowInfo('Modifying this object');
    ModifyObject;
    Client.SendMessage('PCB:Zoom', 'Action=Redraw' , 255, Client.CurrentView);

    ShowInfo('Undoing the modification');
    RemoveObject;

    Client.SendMessage('PCB:Zoom', 'Action=Redraw' , 255, Client.CurrentView);
End;
{..................................................................................................}

{..................................................................................................}
