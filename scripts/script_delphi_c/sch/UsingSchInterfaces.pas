{..............................................................................}
{ Summary Demo the use of Schematic Interfaces by looking for components on    }
{ the schematic sheet.                                                         }
{                                                                              }
{ Copyright (c) 2004 by Altium Limited                                         }
{..............................................................................}

{..............................................................................}
Function BooleanToStr (AValue : Boolean) : TString;
Begin
    Result := '';
    If AValue = True Then Result := 'True'
    Else                  Result := 'False';
End;
{..............................................................................}

{..............................................................................}
Function RotationToStr (AValue : TRotationBy90) : TString;
Begin
    Result := '';
    Case AValue Of
        eRotate0   : Result := '0 Deg'  ;
        eRotate90  : Result := '90 Deg' ;
        eRotate180 : Result := '180 Deg';
        eRotate270 : Result := '270 Deg';
    End;
End;
{..............................................................................}

{..............................................................................}
Procedure GetComponentInformation;
Var
    CurrentSheet    : ISch_Document;
    Iterator        : ISch_Iterator;
    Component       : ISch_Component;
    S               : TDynamicString;
    ReportDocument  : IServerDocument;
    ImplList        : TList;
    Implement       : ISch_Implementation;
    i,j             : Integer;
    FootprintString : TDynamicString;
    Componentslist  : TStringList;
    WSM             : IWorkSpace;
Begin
    CurrentSheet := SchServer.GetCurrentSchDocument;
    If CurrentSheet = Nil Then Exit;

    If CurrentSheet.ObjectID = eSchLib Then
    Begin
         ShowError('Please run the script on a schematic document.');
         Exit;
    End;


    Iterator := CurrentSheet.SchIterator_Create;
    Iterator.AddFilter_ObjectSet(MkSet(eSchComponent));

    Componentslist := TStringList.Create;
    Try
        Component := Iterator.FirstSchObject;

        While Component <> Nil Do
        Begin
            ImplList := GetState_AllImplementations(Component);

            FootprintString := '';
            For j := 0 To ImplList.Count - 1 Do
            Begin
                //ImplList[j] -> SchImplementation.I_ObjectAddress;
                Implement := ImplList[j];
                If Implement <> Nil Then
                    If StringsEqual(Implement.ModelType, 'PCBLIB') And Implement.IsCurrent Then
                        FootprintString := Implement.ModelName;
            End;

            Componentslist.Add(
                'Designator: '       + Component.Designator.Text                + ', ' +
                'Footprint: '        + FootprintString                          + ', ' +
                'Comment:'           + Component.Comment.Text                   + ', ' +
                'UniqueID: '         + Component.UniqueId                       + ', ' +
                'Orientation: '      + RotationToStr(Component.Orientation)     + ', ' +
                'IsMirrored: '       + BooleanToStr(Component.IsMirrored)       + ', ' +
                'AreaColor: '        + IntToStr(Component.AreaColor)            + ', ' +
                'PinColor: '         + IntToStr(Component.PinColor)             + ', ' +
                'ShowHiddenFields: ' + BooleanToStr(Component.ShowHiddenFIelds) + ', ' +
                'LibraryPath: '      + Component.LibraryPath                    + ', ' +
                'Description: '      + Component.ComponentDescription);

            Component := Iterator.NextSchObject;
            Componentslist.Add('');
        End;

    Finally
        CurrentSheet.SchIterator_Destroy (Iterator);
    End;


    Componentslist.Add('Report created on '+ DateToStr(Date) + ' ' + TimeToStr(Time));
    S := 'C:\Report.Txt';

    Componentslist.Insert(0,'Schematic Components Report...');
    Componentslist.Insert(1,'==============================');
    Componentslist.Insert(2,'');
    Componentslist.Insert(3,'');

    ComponentsList.SaveToFile(S);
    ComponentsList.Free;

    ReportDocument := Client.OpenDocument('Text', S);
    If ReportDocument <> Nil Then
        Client.ShowDocument(ReportDocument);
End;
{..............................................................................}

{..............................................................................}
End.
