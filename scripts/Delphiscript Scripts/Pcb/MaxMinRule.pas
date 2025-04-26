{..............................................................................}
{ Summary Create a new max min width routing constraint rule.                  }
{ Copyright (c) 2004 by Altium Limited                                         }
{..............................................................................}

{..............................................................................}
Procedure RunMaxMinRuleExample;
Var
    PCBBoard   : IPCB_Board;
    P          : IPCB_MaxMinWidthConstraint;
    SystemUnit : TUnit;
    MaxLimit   : TCoord;
    MinLimit   : TCoord;
    L          : TLayer;
Begin
    PCBBoard := PCBServer.GetCurrentPCBBoard;
    If PCBBoard = Nil Then Exit;

    (* Create a Max Min Width Routing rule *)
    P := PCBServer.PCBRuleFactory(eRule_MaxMinWidth);

    (* Set values *)
    P.NetScope  := eNetScope_AnyNet;
    P.LayerKind := eRuleLayerKind_SameLayer;

    (* Define values for the Min Max Width Constraint rule *)
    SystemUnit := eImperial; {SystemUnit - eImperial or eMetric}
    StringToCoordUnit('10mils', MinLimit, SystemUnit);
    StringToCoordUnit('20mils', MaxLimit, SystemUnit);

    For L := MinLayer To MaxLayer Do
    Begin
        P.MaxWidth    [L] := MaxLimit;
        P.MinWidth    [L] := MinLimit;
        P.FavoredWidth[L] := MaxLimit;
    End;

    P.Name    := 'Custom Width Rule';
    P.Comment := 'Custom Width Rule';

    (* Add to Board *)
    PCBBoard.AddPCBObject(P);
End;
{..............................................................................}

{..............................................................................}
