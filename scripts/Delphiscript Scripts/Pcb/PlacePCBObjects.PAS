{..............................................................................}
{ Summary Create and place PCB objects on a PCB document.                      }
{         Undo system is not updated                                           }
{ Copyright (c) 2005 by Altium Limited                                         }
{..............................................................................}

{..............................................................................}
Var
    Board     : IPCB_Board;
    WorkSpace : IWorkSpace;

{..............................................................................}

{..............................................................................}
Procedure PlaceAPCBVia(Dummy : Integer);
Var
    Via         : IPCB_Via;
    PadCache    : TPadCache;
Begin
    (* Create a Via object*)
    Via           := PCBServer.PCBObjectFactory(eViaObject, eNoDimension, eCreate_Default);
    Via.X         := MilsToCoord(2000);
    Via.Y         := MilsToCoord(2000);
    Via.Size      := MilsToCoord(50);
    Via.HoleSize  := MilsToCoord(20);
    Via.LowLayer  := eTopLayer;
    Via.HighLayer := eBottomLayer;

    (* Setup a pad cache *)
    Padcache := Via.GetState_Cache;
    Padcache.ReliefAirGap := MilsToCoord(11);
    Padcache.PowerPlaneReliefExpansion := MilsToCoord(11);
    Padcache.PowerPlaneClearance       := MilsToCoord(11);
    Padcache.ReliefConductorWidth      := MilsToCoord(11);
    Padcache.SolderMaskExpansion       := MilsToCoord(11);
    Padcache.SolderMaskExpansionValid  := eCacheManual;
    Padcache.PasteMaskExpansion        := MilsToCoord(11);
    Padcache.PasteMaskExpansionValid   := eCacheManual;

    (* Assign the new pad cache to the via *)
    Via.SetState_Cache                 := Padcache;

    Board.AddPCBObject(Via);
End;
{..............................................................................}

{..............................................................................}
Procedure PlaceAPCBTrack(X1, Y1, X2, Y2, Layer, Width);
Var
    Track         : IPCB_Track;
Begin
    (* Create a Track object*)
    Track             := PCBServer.PCBObjectFactory(eTrackObject, eNoDimension, eCreate_Default);
    Track.X1          := MilsToCoord(X1);
    Track.Y1          := MilsToCoord(Y1);
    Track.X2          := MilsToCoord(X2);
    Track.Y2          := MilsToCoord(Y2);
    Track.Layer       := Layer;
    Track.Width       := MilsToCoord(Width);
    Board.AddPCBObject(Track);
End;
{..............................................................................}

{..............................................................................}
Procedure PlaceASimplePad(Dummy : Integer);
Var
    Pad         : IPCB_Pad;
    Padcache    : TPadCache;
Begin
    (* Create a Pad object*)
    Pad := PCBServer.PCBObjectFactory(ePadObject, eNoDimension, eCreate_Default);

    // Location of pad on the PCB document.
    Pad.X        := MilsToCoord(4000);
    Pad.Y        := MilsToCoord(4000);

    // set up attributes of pad.
    Pad.HoleSize := MilsToCoord(38);
    Pad.Name     := 'A new simple Pad';
    Pad.Mode     := ePadMode_Simple;

    // For a simple pad, only need TopShape, TopXSize, TopYSize
    Pad.TopShape := eRounded;
    Pad.TopXSize := MilsToCoord(100);
    Pad.TopYSize := MilsToCoord(100);

    (* Setup a pad cache *)
    Padcache := Pad.GetState_Cache;
    Padcache.ReliefAirGap := MilsToCoord(11);
    Padcache.PowerPlaneReliefExpansion := MilsToCoord(11);
    Padcache.PowerPlaneClearance       := MilsToCoord(11);
    Padcache.ReliefConductorWidth      := MilsToCoord(11);
    Padcache.SolderMaskExpansion       := MilsToCoord(11);
    Padcache.SolderMaskExpansionValid  := eCacheManual;
    Padcache.PasteMaskExpansion        := MilsToCoord(11);
    Padcache.PasteMaskExpansionValid   := eCacheManual;

    (* Assign the new pad cache to the pad*)
    Pad.SetState_Cache                 := Padcache;

    Board.AddPCBObject(Pad);
End;
{..............................................................................}

{..............................................................................}
Procedure PlaceATopMidBotStackPad(Dummy : Integer);
Var
    Pad         : IPCB_Pad;
    Padcache    : TPadCache;
Begin
    (* Create a Pad object*)
    Pad := PCBServer.PCBObjectFactory(ePadObject, eNoDimension, eCreate_Default);

    // Location of pad on the PCB document.
    Pad.X        := MilsToCoord(3000);
    Pad.Y        := MilsToCoord(3000);

    // set up attributes of pad.
    Pad.HoleSize := MilsToCoord(38);
    Pad.Name     := 'A new TopMidBot Pad';
    Pad.Mode     := ePadMode_LocalStack;

    //
    Pad.TopShape := eOctagonal;
    Pad.TopXSize := MilsToCoord(75);
    Pad.TopYSize := MilsToCoord(75);

    Pad.MidShape := eRectangular;
    Pad.MidXSize := MilsToCoord(50);
    Pad.MidYSize := MilsToCoord(50);

    Pad.BotShape := eOctagonal;
    Pad.BotXSize := MilsToCoord(100);
    Pad.BotYSize := MilsToCoord(100);


    (* Setup a pad cache *)
    Padcache := Pad.GetState_Cache;
    Padcache.ReliefAirGap := MilsToCoord(11);
    Padcache.PowerPlaneReliefExpansion := MilsToCoord(11);
    Padcache.PowerPlaneClearance       := MilsToCoord(11);
    Padcache.ReliefConductorWidth      := MilsToCoord(11);
    Padcache.SolderMaskExpansion       := MilsToCoord(11);
    Padcache.SolderMaskExpansionValid  := eCacheManual;
    Padcache.PasteMaskExpansion        := MilsToCoord(11);
    Padcache.PasteMaskExpansionValid   := eCacheManual;

    (* Assign the new pad cache to the pad*)
    Pad.SetState_Cache                 := Padcache;

    Board.AddPCBObject(Pad);
End;
{..............................................................................}

{..............................................................................}
Procedure  PlaceAFullStackPad(0);
Var
    Pad         : IPCB_Pad;
    Padcache    : TPadCache;
Begin
    (* Create a Pad object*)
    Pad := PCBServer.PCBObjectFactory(ePadObject, eNoDimension, eCreate_Default);

    // Location of pad on the PCB document.
    Pad.X        := MilsToCoord(3500);
    Pad.Y        := MilsToCoord(3500);

    // set up attributes of pad.
    Pad.HoleSize := MilsToCoord(10);
    Pad.Name     := 'A new fullstack Pad';
    Pad.Mode     := ePadMode_ExternalStack;

    // Set up full stack pad
    Pad.XStackSizeOnLayer(eTopLayer) := MilsToCoord(20);
    Pad.YStackSizeOnLayer(eTopLayer) := MilsToCoord(20);
    Pad.StackShapeOnLayer(eTopLayer) := eRounded;

    Pad.XStackSizeOnLayer(eMidLayer1) := MilsToCoord(20);
    Pad.YStackSizeOnLayer(eMidLayer1) := MilsToCoord(20);
    Pad.StackShapeOnLayer(eMidLayer1) := eRounded;

    Pad.XStackSizeOnLayer(eMidLayer2) := MilsToCoord(20);
    Pad.YStackSizeOnLayer(eMidLayer2) := MilsToCoord(20);
    Pad.StackShapeOnLayer(eMidLayer2) := eRounded;

    Pad.XStackSizeOnLayer(eBottomLayer) := MilsToCoord(20);
    Pad.YStackSizeOnLayer(eBottomLayer) := MilsToCoord(20);
    Pad.StackShapeOnLayer(eBottomLayer) := eOctagonal;



    (* Setup a pad cache *)
    Padcache := Pad.GetState_Cache;
    Padcache.ReliefAirGap := MilsToCoord(11);
    Padcache.PowerPlaneReliefExpansion := MilsToCoord(11);
    Padcache.PowerPlaneClearance       := MilsToCoord(11);
    Padcache.ReliefConductorWidth      := MilsToCoord(11);
    Padcache.SolderMaskExpansion       := MilsToCoord(11);
    Padcache.SolderMaskExpansionValid  := eCacheManual;
    Padcache.PasteMaskExpansion        := MilsToCoord(11);
    Padcache.PasteMaskExpansionValid   := eCacheManual;

    (* Assign the new pad cache to the pad*)
    Pad.SetState_Cache                 := Padcache;

    Board.AddPCBObject(Pad);
End;
{..............................................................................}

{..............................................................................}
Procedure PlaceAPCBFill(Dummy : Integer);
Var
    Fill : IPCB_Fill;
Begin
    (* Create a Fill object*)
    Fill             := PCBServer.PCBObjectFactory(eFillObject, eNoDimension,eCreate_Default);
    Fill.X1Location  := MilsToCoord(2000);
    Fill.Y1Location  := MilsToCoord(2000);
    Fill.X2Location  := MilsToCoord(2500);
    Fill.Y2Location  := MilsToCoord(2500);
    Fill.Layer       := eBottomLayer;
    Fill.Rotation    := 45;

    Board.AddPCBObject(Fill);
End;
{..............................................................................}

{..............................................................................}
Procedure PlaceAPCBArc(Dummy : Integer);
Var
    Arc : IPCB_Arc;
Begin
    Arc := PCBServer.PCBObjectFactory(eArcObject, eNoDimension, eCreate_Default);
    Arc.XCenter    := MilsToCoord(Board.XOrigin + 1800);
    Arc.YCenter    := MilsToCoord(Board.YOrigin + 1800);
    Arc.Radius     := MilsToCoord(200);
    Arc.LineWidth  := MilsToCoord(50);
    Arc.StartAngle := 0;
    Arc.EndAngle   := 270;
    Arc.Layer      := eBottomLayer;
    Board.AddPCBObject(Arc);
End;
{..............................................................................}

{..............................................................................}
Procedure PlaceAPCBComponent(Dummy : Integer);
Begin
    If IntegratedLibraryManager = Nil Then Exit;

End;
{..............................................................................}

{..............................................................................}
Procedure PlaceAPCBText(Dummy : Integer);
Var
    TextObj : IPCB_Text;
Begin
    (* create a text object on a top overlay *)
    Board.LayerIsDisplayed[eTopOverLay] := True;

    TextObj := PCBServer.PCBObjectFactory(eTextObject, eNoDimension, eCreate_Default);
    TextObj.XLocation := MilsToCoord(Board.XOrigin + 4000);
    TextObj.YLocation := MilsToCoord(Board.YOrigin + 2000);
    TextObj.Layer     := eTopOverlay;
    TextObj.Text      := 'Text Object';
    TextObj.Size      := MilsToCoord(90);   // sets the height of the text.

    Board.AddPCBObject(TextObj);
End;
{..............................................................................}

{..............................................................................}
Procedure PlacePCBObjects;
Begin
    (*create a new pcb document *)
    WorkSpace := GetWorkSpace;
    If WorkSpace = Nil Then Exit;
    Workspace.DM_CreateNewDocument('PCB');

    If PCBServer = Nil Then Exit;
    Board := PCBServer.GetCurrentPCBBoard;
    If Board = Nil then exit;

    (* Place new PCB objects*)
    PlaceAPCBVia(0);

    PlaceAPCBTrack(1000,1000,1500,1500,eTopLayer,50);
    PlaceAPCBTrack(1500,1500,1500,1000,eTopLayer,50);
    PlaceAPCBTrack(1500,1000,1000,1000,eTopLayer,50);

    PlaceASimplePad(0);
    PlaceATopMidBotStackPad(0);
    PlaceAFullStackPad(0);

    PlaceAPCBFill(0);
    PlaceAPCBArc(0);
    PlaceAPCBComponent(0);
    PlaceAPCBText(0);

    (* Refresh PCB workspace *)
    ResetParameters;
    AddStringParameter('Action', 'All');
    RunProcess('PCB:Zoom');
End;
{..............................................................................}

{..............................................................................}

