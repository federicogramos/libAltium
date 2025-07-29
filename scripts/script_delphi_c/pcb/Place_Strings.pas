{..............................................................................}
{ Summary Places new text string objects on a current PCB document.            }
{ Copyright (c) 2004 by Altium Limited                                         }
{..............................................................................}

{..............................................................................}
Procedure CreateStrings;
Var
    Sheet   : IPCB_Sheet;
    Board   : IPCB_Board;
    TextObj : IPCB_Text;
Begin
    // Checks if current document is a PCB kind if not, exit.
    Board := PCBServer.GetCurrentPCBBoard;
    If Board = Nil Then Exit;

    Sheet := Board.PCBSheet;

    // Initialize PCB server.
    PCBServer.PreProcess;

    // Toggle Top Overlay and Bottom Overlay layers to true.
    Board.LayerIsDisplayed[eTopOverLay] := True;
    Board.LayerIsDisplayed[eBottomOverLay] := True;

    //
    //Create a first text object non True Type font.
    TextObj := PCBServer.PCBObjectFactory(eTextObject, eNoDimension, eCreate_Default);

    // notify that the pcb object is going to be modified
    PCBServer.SendMessageToRobots(TextObj.I_ObjectAddress ,c_Broadcast, PCBM_BeginModify , c_NoEventData);

    TextObj.XLocation := Sheet.SheetX + MilsToCoord(500);
    TextObj.YLocation := Sheet.SheetY + MilsToCoord(500);
    TextObj.Layer     := eTopOverlay;
    TextObj.Text      := 'Traditional Protel Text';
    TextObj.Size       := MilsToCoord(90);   // sets the height of the text.

    Board.AddPCBObject(TextObj);

    // notify that the pcb object has been modified
    PCBServer.SendMessageToRobots(TextObj.I_ObjectAddress, c_Broadcast, PCBM_EndModify         , c_NoEventData);
    PCBServer.SendMessageToRobots(Board  .I_ObjectAddress, c_Broadcast, PCBM_BoardRegisteration, TextObj.I_ObjectAddress);


    //
    // second TextObject with True Type Font enabled.
    TextObj := PCBServer.PCBObjectFactory(eTextObject, eNoDimension, eCreate_Default);

    // notify that the pcb object is going to be modified
    PCBServer.SendMessageToRobots(TextObj.I_ObjectAddress, c_Broadcast, PCBM_BeginModify, c_NoEventData);

    TextObj.XLocation := Sheet.SheetX + MilsToCoord(1000);
    TextObj.YLocation := Sheet.SheetY + MilsToCoord(1000);
    TextObj.Layer     := eBottomOverlay;

    TextObj.UseTTFonts := True;
    TextObj.Italic := True;
    TextObj.Bold := False;
    TextObj.FontName := 'ARIAL';

    // inverts the text object and a text boundary is created around the text
    // The Inverted and InvertedTTTextBorder properties are useful for situations
    // if text is to be placed on a copper region and create a cutout in the region.
    // the color of the inverted border is the layer color and the text color itself
    // is black.
    TextObj.Inverted := True;
    // The InvertedTTextBorder property determines the distance between the boundary of the
    // the text object itself to the text border boundary.
    TextObj.InvertedTTTextBorder := MilsToCoord(100);

    TextObj.Text      := 'Text with True Type Property enabled.';
    TextObj.Size       := MilsToCoord(200);    // sets the height of the text.

    Board.AddPCBObject(TextObj);

    // notify that the pcb object has been modified
    PCBServer.SendMessageToRobots(TextObj.I_ObjectAddress, c_Broadcast, PCBM_EndModify , c_NoEventData);
    PCBServer.SendMessageToRobots(Board.I_ObjectAddress, c_Broadcast, PCBM_BoardRegisteration,TextObj.I_ObjectAddress);

    // Set LayerIsUsed property to true, since text objects now exist on these Overlay layers.
    Board.LayerIsUsed[eTopOverLay]    := True;
    Board.LayerIsUsed[eBottomOverLay] := True;

    PCBServer.PostProcess;
    Client.SendMessage('PCB:Zoom', 'Action=Redraw' , 255, Client.CurrentView);
End;
{..............................................................................}

{..............................................................................}
