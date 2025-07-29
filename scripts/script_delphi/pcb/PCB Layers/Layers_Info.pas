{..............................................................................}
{ Summary Layers information based on the current PCB layer stack              }
{         of the pcb document.                                                 }
{ Copyright (c) 2004 by Altium Limited                                         }
{..............................................................................}

{..............................................................................}
Function ConvertDielectricTypeTOString (DT : TDielectricType): String;
Begin
    Result := 'Unknown Type';
    Case DT Of
        eNoDielectric    : Result := 'No Dielectric';
        eCore            : Result := 'Core';
        ePrePreg         : Result := 'PrePreg';
        eSurfaceMaterial : Result := 'Surface Material';
    End;

End;
{..............................................................................}

{..............................................................................}
Function GetLayerInfo(BoardHandle : IPCB_Board; Var LayerID : TLayer) : String;
Var
    LayerObj : IPCB_LayerObject;
Begin
    LayerObj := BoardHandle.LayerStack.LayerObject[LayerId];

    Result := Layer2String(LayerID) + ', ' + LayerObj.Name + ', ' +
              'Copper' + ', ' + FloatToStr(LayerObj.CopperThickness / 10000) + ', ';

    If LayerObj.Dielectric.DielectricType <> eNoDielectric Then
    Begin
       Result := Result + ConvertDielectricTypeTOString(LayerObj.Dielectric.DielectricType) + ', ' +
                 LayerObj.Dielectric.DielectricMaterial +  ', ' + FloatToStr(LayerObj.Dielectric.DielectricHeight / 10000) + ', ' +
                 FloatToStr(LayerObj.Dielectric.DielectricConstant);
    End;

    LayerObj := BoardHandle.LayerStack.NextLayer(LayerObj);
    If LayerObj <> Nil Then
        LayerID := LayerObj.LayerID
    Else
        LayerID := eNoLayer;
End;
{..............................................................................}

{..............................................................................}
Procedure FetchLayersInformation;
Var
    BoardHandle : IPCB_Board;
    Str         : String;
    Filename    : String;
    OutFile     : TextFile;
    Layer       : TLayer;
    ReportDocument : IServerDocument;
Begin
    BoardHandle := PCBServer.GetCurrentPCBBoard;
    If BoardHandle = Nil Then
    Begin
       ShowError('Current document is not PCB document');
       Exit;
    End;

    Str := 'Layer, Name, Material, Cu Thickness,  Dielectric Material, type, constant, height ' + #13#10;

    Layer := MinLayer;
    Repeat
       Str := Str + GetLayerInfo(BoardHandle, Layer) + #13#10;
    Until Layer = eNoLayer;

    FileName := ChangeFileExt(BoardHandle.FileName, '') + '_LayerRpt.cvs';
    Try
        AssignFile(OutFile, Filename);
        Rewrite(OutFile);
        Write(OutFile, Str);
    Finally
        CloseFile(OutFile);
    End;

    ReportDocument := Client.OpenDocument('Text', FileName);
    If ReportDocument <> Nil Then
        Client.ShowDocument(ReportDocument);
End;
{..............................................................................}

{..............................................................................}
