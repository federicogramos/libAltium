{..............................................................................}
{ Summary Fetch component classes from a PCB document                          }
{                                                                              }
{ Copyright (c) 2005 by Altium Limited                                         }
{..............................................................................}
Var
    ComponentList : TStringList;
{..............................................................................}

{..............................................................................}
Procedure GenerateCompReport(Brd : IPCB_Board);
Var
    ClassRpt : TStringList;
    AObjectClass : IPCB_ObjectClass;
    I, J     : Integer;
    FileName : String;
    Document : IServerDocument;
Begin
    ClassRpt := TStringList.Create;
    ClassRpt.Add('Component Class Report');
    ClassRpt.Add('');

    For i := 0 To ComponentList.Count - 1 Do
    Begin
        AObjectClass := ComponentList.Objects[I];
        If Not AObjectClass.SuperClass Then
        Begin
            // not a super class, so get member names
            J := 0;
            ClassRpt.Add(AObjectClass.Name);
            While AObjectClass.MemberName[J] <> '' Do
            Begin
                ClassRpt.Add(' ' +AObjectClass.MemberName[J]);
                Inc(J);
            End;
        End
        Else
            ClassRpt.Add('All Components');

        // add a blank line
        ClassRpt.Add('');
    End;

    // Display the object class and its members report
    FileName := ChangeFileExt(Brd.FileName,'.REP');
    ClassRpt.SaveToFile(Filename);
    ClassRpt.Free;

    Document  := Client.OpenDocument('Text', FileName);
    If Document <> Nil Then
        Client.ShowDocument(Document);
End;
{..............................................................................}

{..............................................................................}
Procedure FillComponentClassList(ABrd : IPCB_Board);
Var
    Iterator  : IPCB_BoardIterator;
    c         : IPCB_ObjectClass;
Begin
    Iterator := ABrd.BoardIterator_Create;

    Iterator.SetState_FilterAll;
    Iterator.AddFilter_ObjectSet(MkSet(eClassObject));

    c := Iterator.FirstPCBObject;
    While c <> Nil Do
    Begin
        If c.MemberKind = eClassMemberKind_Component Then
            ComponentList.AddObject(c.Name, c);
        c := Iterator.NextPCBObject;
    End;
    ABrd.BoardIterator_Destroy(Iterator);
End;
{..............................................................................}

{..............................................................................}
Procedure GenerateComponentClassesReport;
Var
    Brd : IPCB_Board;
Begin
    Try
        Brd := PCBServer.GetCurrentPCBBoard;
        If Not Assigned(Brd) Then
        Begin
            ShowMessage('The current Document is not a PCB Document.');
            Exit;
        End;

        ComponentList := TStringList.Create;
        FillComponentClassList(Brd);
        GenerateCompReport(Brd);

    Finally
        ComponentList.Free;
    End;
End;
{..............................................................................}

{..............................................................................}































































































