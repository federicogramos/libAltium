{..............................................................................}
{ Summary Create a Net class that has a GND member for a PCB document          }
{                                                                              }
{ Copyright (c) 2005 by Altium Limited                                         }
{..............................................................................}

{..............................................................................}
Procedure CreateANewNetClass;
Var
    Board    : IPCB_Board;
    NetClass : IPCB_ObjectClass;
Begin
    Board := PCBServer.GetCurrentPCBBoard;
    If Board = Nil Then Exit;

    PCBServer.PreProcess;

    NetClass := PCBServer.PCBClassFactoryByClassMember(eClassMemberKind_Net);
    NetClass.SuperClass := False;
    NetClass.Name := 'NetGndClass';
    NetClass.AddMemberByName('GND');

    Board.AddPCBObject(NetClass);
    PCBServer.PostProcess;
End;
{..............................................................................}
