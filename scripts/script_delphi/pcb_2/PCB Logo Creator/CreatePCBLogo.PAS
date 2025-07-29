{..............................................................................}
{ Summary Converts a monochrome image as a PCB Logo into a series of thin      }
{         PCB tracks that can be placed on a PCB document as a logo.           }
{                                                                              }
{         Version 1.3                                                          }
{                                                                              }
{..............................................................................}

{......................................................................................................................}
Function ObtainCoordinate(AString : String; Var AnIndex : Integer) : String;
Var
    J : Integer;
Begin
    Result := 0;
    J := AnIndex;
    For J := AnIndex to Length(AString) Do
    Begin
        If (Copy(AString, J, 1) = ',') Then
        Begin
            Result := StrToInt(Copy(AString, AnIndex, J - AnIndex));
            AnIndex := J + 1;
            Break;
        End;
    End;
End;
{..............................................................................}

{......................................................................................................................}
Procedure CreateAPCBLogo(ABoard : IPCB_Board, AContainer : TStringList, ALayer : TLayer, AWidth : Float);
Var
    I, J, Z, AnIndex : Integer;
    ATrack      : TString;
    X1,Y1,X2,Y2 : TCoord;
    PCBTrack    : IPCB_Track;
    Sheet       : IPCB_Sheet;
    OffSet      : TCoord;
Begin
    // have the container of PCB tracks to blast on a blank PCB document.
    If AContainer.Count < 1 Then Exit;

    For I := 0 to AContainer.Count - 1 Do
    Begin
        // a track is composed of four coordinates so process each string into four values
        AnIndex := 1;
        ATrack  := AContainer.Strings[I];
        For Z := 1 to 4 Do
        Begin
            Case Z Of
            1 : X1 := ObtainCoordinate(ATrack, AnIndex);
            2 : Y1 := ObtainCoordinate(ATrack, AnIndex);
            3 : X2 := ObtainCoordinate(ATrack, AnIndex);
            4 : Y2 := StrToInt(Copy(ATrack, AnIndex, (Length(ATrack) - AnIndex + 1)));
            End
        End;

        If ABoard <> Nil Then
        Begin
            // obtain the coordinates of the sheet so can place logo within the board
            Sheet  := ABoard.PCBSheet;
            OffSet := MilsToCoord(100);

            // place a new track on the blank PCB
            PCBTrack       := PCBServer.PCBObjectFactory(eTrackObject, eNoDimension, eCreate_Default);
            PCBTrack.Width := Round(MilsToCoord(1) * AWidth);

            PCBTrack.X1    := Sheet.SheetX + MilsToCoord(X1) + Offset;
            PCBTrack.Y1    := Sheet.SheetY + MilsToCoord(Y1) + Offset;
            PCBTrack.X2    := Sheet.SheetX + MilsToCoord(X2) + Offset;
            PCBTrack.Y2    := Sheet.SheetY + MilsToCoord(Y2) + Offset;
            PCBTrack.Layer := ALayer;

             ABoard.AddPCBObject(PCBTrack);
        End;
    End;

    Client.SendMessage('PCB:Zoom', 'Action=All' , 255, Client.CurrentView);
End;
{......................................................................................................................}

{......................................................................................................................}
