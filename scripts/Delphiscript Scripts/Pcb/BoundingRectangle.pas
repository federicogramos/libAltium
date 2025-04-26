{..............................................................................}
{ Summary Obtaining the bounding rectangle of a component.                     }
{ Copyright (c) 2004 by Altium Limited                                         }
{..............................................................................}

{..............................................................................}
Var
    MinX, MinY, MaxX, MaxY : Integer;
{..............................................................................}

{..............................................................................}
Procedure ProcessObjectsOfAComponent(Const P : IPCB_Primitive);
Var
    R : TCoordRect;
Begin
    // check for comment / name objects
    If P.ObjectId <> eTextObject Then
    Begin
        R := P.BoundingRectangle;

        If R.left   < MinX Then MinX := R.left;
        If R.bottom < MinY Then MinY := R.bottom;
        If R.right  > MaxX Then MaxX := R.right;
        If R.top    > MaxY Then MaxY := R.top;
    End;
End;
{..............................................................................}

{..............................................................................}
Procedure ProcessItems(Component    : IPCB_Component;
                       SetOfObjects : TObjectSet;
                       SetOfLayers  : TLayerSet);
Var
    Iterator  : IPCB_GroupIterator;
    Handle    : IPCB_Primitive;
Begin
    Iterator := Component.GroupIterator_Create;
    Iterator.AddFilter_ObjectSet(SetOfObjects);
    Iterator.AddFilter_LayerSet(SetOfLayers);
    Handle   := Iterator.FirstPCBObject;
    While Handle <> Nil Do
    Begin
        ProcessObjectsOfAComponent(Handle);
        Handle := Iterator.NextPCBObject;
    End;
    Component.GroupIterator_Destroy(Iterator);
End;
{..............................................................................}

{..............................................................................}
Procedure ComponentInfo;
Var
    MidX, MidY : Double;
    Component  : IPCB_Component;
    Iterator   : IPCB_BoardIterator;
    Board      : IPCB_Board;
    S          : TPCBString;
Begin
    Board := PCBServer.GetCurrentPCBBoard;
    If Board = Nil Then Exit;

    BeginHourGlass;

    // setting extreme constants...
    MinX :=  2147483647;
    MinY :=  2147483647;
    MaxX := -2147483647;
    MaxY := -2147483647;

    // set up filter for component objects only
    Iterator := Board.BoardIterator_Create;
    Iterator.AddFilter_ObjectSet(MkSet(eComponentObject));
    Iterator.AddFilter_LayerSet(AllLayers);
    Iterator.AddFilter_Method(eProcessAll);

    // Looks for the first component and then calculates the Mid X and MidY
    // of this component taking all the prims of this component into account.
    Component := Iterator.FirstPCBObject;
    If Component <> Nil Then
    Begin
        //enables you to look for primitives inside a component easily.
        ProcessItems(Component, AllObjects, AllLayers);
    End;
    Board.BoardIterator_Destroy(Iterator);

    MidX := (MinX + MaxX)/2;
    MidY := (MinY + MaxY)/2;

    EndHourGlass;
    S := Component.Name.Text;
    ShowInfo('Component''s ' + S + ' midpoint X and Y are : '+ #13 +
             'MidX = ' + FloatToStr(MidX) + ', MidY = ' + FloatToStr(MidY));
End;
{..............................................................................}

{..............................................................................}
