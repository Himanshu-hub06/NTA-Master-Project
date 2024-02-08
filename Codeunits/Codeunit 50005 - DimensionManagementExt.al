
codeunit 50005 "DimensionManagement Ext"
{
    EventSubscriberInstance = StaticAutomatic;
    SingleInstance = true;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"", 'OnBeforeGetConditionalCardPageID', '', true, true)]
    /// <summary>
    /// EditDimensionSet2.
    /// </summary>
    /// <param name="DimSetID">Integer.</param>
    /// <param name="NewCaption">Text[250].</param>
    /// <param name="VAR GlobalDimVal1">Code[20].</param>
    /// <param name="VAR GlobalDimVal2">Code[20].</param>
    /// <returns>Return value of type Integer.</returns>
    procedure EditDimensionSet2(DimSetID: Integer; NewCaption: Text[250]; VAR GlobalDimVal1: Code[20]; VAR GlobalDimVal2: Code[20]): Integer
    var
        EditDimSetEntries: Page "Edit Dimension Set Entries";
        NewDimSetID: Integer;
    begin
        NewDimSetID := DimSetID;
        DimSetEntry.RESET;
        DimSetEntry.FILTERGROUP(2);
        DimSetEntry.SETRANGE("Dimension Set ID", DimSetID);
        DimSetEntry.FILTERGROUP(0);
        EditDimSetEntries.SETTABLEVIEW(DimSetEntry);
        EditDimSetEntries.SetFormCaption(NewCaption);
        EditDimSetEntries.RUNMODAL;
        NewDimSetID := EditDimSetEntries.GetDimensionID;
        UpdateGlobalDimFromDimSetID(NewDimSetID, GlobalDimVal1, GlobalDimVal2);
        DimSetEntry.RESET;
        EXIT(NewDimSetID);
    end;

    /// <summary>
    /// UpdateGlobalDimFromDimSetID.
    /// </summary>
    /// <param name="DimSetID">Integer.</param>
    /// <param name="VAR GlobalDimVal1">Code[20].</param>
    /// <param name="VAR GlobalDimVal2">Code[20].</param>
    procedure UpdateGlobalDimFromDimSetID(DimSetID: Integer; VAR GlobalDimVal1: Code[20]; VAR GlobalDimVal2: Code[20])
    var
    begin
        GetGLSetup;
        GlobalDimVal1 := '';
        GlobalDimVal2 := '';
        IF GLSetupShortcutDimCode[1] <> '' THEN
            IF DimSetEntry.GET(DimSetID, GLSetupShortcutDimCode[1]) THEN
                GlobalDimVal1 := DimSetEntry."Dimension Value Code";
        IF GLSetupShortcutDimCode[2] <> '' THEN
            IF DimSetEntry.GET(DimSetID, GLSetupShortcutDimCode[2]) THEN
                GlobalDimVal2 := DimSetEntry."Dimension Value Code";

    end;

    /// <summary>
    /// GetGLSetup.
    /// </summary>
    LOCAL procedure GetGLSetup()
    var
        GLSetup: Record "General Ledger Setup";
    begin
        IF NOT HasGotGLSetup THEN BEGIN
            GLSetup.GET;
            GLSetupShortcutDimCode[1] := GLSetup."Shortcut Dimension 1 Code";
            GLSetupShortcutDimCode[2] := GLSetup."Shortcut Dimension 2 Code";
            GLSetupShortcutDimCode[3] := GLSetup."Shortcut Dimension 3 Code";
            GLSetupShortcutDimCode[4] := GLSetup."Shortcut Dimension 4 Code";
            GLSetupShortcutDimCode[5] := GLSetup."Shortcut Dimension 5 Code";
            GLSetupShortcutDimCode[6] := GLSetup."Shortcut Dimension 6 Code";
            GLSetupShortcutDimCode[7] := GLSetup."Shortcut Dimension 7 Code";
            GLSetupShortcutDimCode[8] := GLSetup."Shortcut Dimension 8 Code";
            HasGotGLSetup := TRUE;
        END;
    end;

    local procedure ValidateDimValueCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        DimVal: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
    begin
        GetGLSetup;
        IF (GLSetupShortcutDimCode[FieldNumber] = '') AND (ShortcutDimCode <> '') THEN
            ERROR(Text002, GLSetup.TABLECAPTION);
        DimVal.SETRANGE("Dimension Code", GLSetupShortcutDimCode[FieldNumber]);
        IF ShortcutDimCode <> '' THEN BEGIN
            DimVal.SETRANGE(Code, ShortcutDimCode);
            IF NOT DimVal.FINDFIRST THEN BEGIN
                DimVal.SETFILTER(Code, STRSUBSTNO('%1*', ShortcutDimCode));
                IF DimVal.FINDFIRST THEN
                    ShortcutDimCode := DimVal.Code
                ELSE
                    ERROR(
                      STRSUBSTNO(Text003,
                        ShortcutDimCode, DimVal.FIELDCAPTION(Code)));
            END;
        END;
    end;

    local procedure CheckDim(DimCode: Code[20]): Boolean
    var
        Dim: Record Dimension;
    begin
        IF Dim.GET(DimCode) THEN BEGIN
            IF Dim.Blocked THEN BEGIN
                DimErr :=
                  STRSUBSTNO(Text014, Dim.TABLECAPTION, DimCode);
                EXIT(FALSE);
            END;
        END ELSE BEGIN
            DimErr :=
              STRSUBSTNO(Text015, Dim.TABLECAPTION, DimCode);
            EXIT(FALSE);
        END;
        EXIT(TRUE);
    end;

    local procedure GetDimensionSetID(VAR DimSetEntry2: Record "Dimension Set Entry"): Integer
    begin
        EXIT(DimSetEntry.GetDimensionSetID(DimSetEntry2));
    end;

    /// <summary>
    /// GetDimErr.
    /// </summary>
    /// <returns>Return value of type Text[250].</returns>
    procedure GetDimErr(): Text[250]
    begin
        EXIT(DimErr);
    end;

    /// <summary>
    /// CheckDimValue.
    /// </summary>
    /// <param name="DimCode">Code[20].</param>
    /// <param name="DimValCode">Code[20].</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure CheckDimValue(DimCode: Code[20]; DimValCode: Code[20]): Boolean
    var
        DimVal: Record "Dimension Value";
    begin
        IF (DimCode <> '') AND (DimValCode <> '') THEN BEGIN
            IF DimVal.GET(DimCode, DimValCode) THEN BEGIN
                IF DimVal.Blocked THEN BEGIN
                    DimErr :=
                      STRSUBSTNO(
                        Text016, DimVal.TABLECAPTION, DimCode, DimValCode);
                    EXIT(FALSE);
                END;
                IF NOT (DimVal."Dimension Value Type" IN
                        [DimVal."Dimension Value Type"::Standard,
                         DimVal."Dimension Value Type"::"Begin-Total"])
                THEN BEGIN
                    DimErr :=
                      STRSUBSTNO(Text017, DimVal.FIELDCAPTION("Dimension Value Type"),
                        DimVal.TABLECAPTION, DimCode, DimValCode, FORMAT(DimVal."Dimension Value Type"));
                    EXIT(FALSE);
                END;
            END ELSE BEGIN
                DimErr :=
                  STRSUBSTNO(
                    Text018, DimVal.TABLECAPTION, DimCode);
                EXIT(FALSE);
            END;
        END;
        EXIT(TRUE);
    end;

    /// <summary>
    /// GetDimensionSet.
    /// </summary>
    /// <param name="VAR TempDimSetEntry">Record "Dimension Set Entry".</param>
    /// <param name="DimSetID">Integer.</param>
    procedure GetDimensionSet(VAR TempDimSetEntry: Record "Dimension Set Entry"; DimSetID: Integer)
    var
        DimSetEntry2: Record "Dimension Set Entry";
    begin
        TempDimSetEntry.DELETEALL;
        WITH DimSetEntry2 DO BEGIN
            SETRANGE("Dimension Set ID", DimSetID);
            IF FINDSET THEN
                REPEAT
                    TempDimSetEntry := DimSetEntry2;
                    TempDimSetEntry.INSERT;
                UNTIL NEXT = 0;
        END;
    end;


    procedure ValidateShortcutDimValues(FieldNumber: Integer; VAR ShortcutDimCode: Code[20]; VAR DimSetID: Integer)
    var
        DimVal: Record "Dimension Value";
        TempDimSetEntry: Record "Dimension Set Entry";
    begin
        ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimVal."Dimension Code" := GLSetupShortcutDimCode[FieldNumber];
        IF ShortcutDimCode <> '' THEN BEGIN
            DimVal.GET(DimVal."Dimension Code", ShortcutDimCode);
            IF NOT CheckDim(DimVal."Dimension Code") THEN
                ERROR(GetDimErr);
            IF NOT CheckDimValue(DimVal."Dimension Code", ShortcutDimCode) THEN
                ERROR(GetDimErr);
        END;
        GetDimensionSet(TempDimSetEntry, DimSetID);
        IF TempDimSetEntry.GET(TempDimSetEntry."Dimension Set ID", DimVal."Dimension Code") THEN
            IF TempDimSetEntry."Dimension Value Code" <> ShortcutDimCode THEN
                TempDimSetEntry.DELETE;
        IF ShortcutDimCode <> '' THEN BEGIN
            TempDimSetEntry."Dimension Code" := DimVal."Dimension Code";
            TempDimSetEntry."Dimension Value Code" := DimVal.Code;
            TempDimSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
            // IF TempDimSetEntry.INSERT THEN;
        END;
        DimSetID := GetDimensionSetID(TempDimSetEntry);

    end;

    procedure GetDeltaDimSetID(DimSetID: Integer; NewParentDimSetID: Integer; OldParentDimSetID: Integer): Integer
    var
        TempDimSetEntry,
        TempDimSetEntryNew,
        TempDimSetEntryDeleted : Record "Dimension Set Entry";
    begin
        // Returns an updated DimSetID based on parent's old and new DimSetID
        IF NewParentDimSetID = OldParentDimSetID THEN
            EXIT(DimSetID);
        GetDimensionSet(TempDimSetEntry, DimSetID);
        GetDimensionSet(TempDimSetEntryNew, NewParentDimSetID);
        GetDimensionSet(TempDimSetEntryDeleted, OldParentDimSetID);
        IF TempDimSetEntryDeleted.FINDSET THEN
            REPEAT
                IF TempDimSetEntryNew.GET(NewParentDimSetID, TempDimSetEntryDeleted."Dimension Code") THEN BEGIN
                    IF TempDimSetEntryNew."Dimension Value Code" = TempDimSetEntryDeleted."Dimension Value Code" THEN
                        TempDimSetEntryNew.DELETE;
                    TempDimSetEntryDeleted.DELETE;
                END;
            UNTIL TempDimSetEntryDeleted.NEXT = 0;

        IF TempDimSetEntryDeleted.FINDSET THEN
            REPEAT
                IF TempDimSetEntry.GET(DimSetID, TempDimSetEntryDeleted."Dimension Code") THEN
                    TempDimSetEntry.DELETE;
            UNTIL TempDimSetEntryDeleted.NEXT = 0;

        IF TempDimSetEntryNew.FINDSET THEN
            REPEAT
                IF TempDimSetEntry.GET(DimSetID, TempDimSetEntryNew."Dimension Code") THEN BEGIN
                    IF TempDimSetEntry."Dimension Value Code" <> TempDimSetEntryNew."Dimension Value Code" THEN BEGIN
                        TempDimSetEntry."Dimension Value Code" := TempDimSetEntryNew."Dimension Value Code";
                        TempDimSetEntry."Dimension Value ID" := TempDimSetEntryNew."Dimension Value ID";
                        TempDimSetEntry.MODIFY;
                    END;
                END ELSE BEGIN
                    TempDimSetEntry := TempDimSetEntryNew;
                    TempDimSetEntry."Dimension Set ID" := DimSetID;
                    TempDimSetEntry.INSERT;
                END;
            UNTIL TempDimSetEntryNew.NEXT = 0;

        EXIT(GetDimensionSetID(TempDimSetEntry));
    end;

    procedure LookupDimValueCode(FieldNumber: Integer; VAR ShortcutDimCode: Code[20])
    var
        DimVal: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
    begin
        GetGLSetup;
        IF GLSetupShortcutDimCode[FieldNumber] = '' THEN
            ERROR(Text002, GLSetup.TABLECAPTION);
        DimVal.SETRANGE("Dimension Code", GLSetupShortcutDimCode[FieldNumber]);
        DimVal."Dimension Code" := GLSetupShortcutDimCode[FieldNumber];
        DimVal.Code := ShortcutDimCode;
        IF PAGE.RUNMODAL(0, DimVal) = ACTION::LookupOK THEN BEGIN
            CheckDim(DimVal."Dimension Code");
            CheckDimValue(DimVal."Dimension Code", DimVal.Code);
            ShortcutDimCode := DimVal.Code;
        END;
    end;



    var
        TempDimBuf1: Record "Dimension Buffer";
        TempDimBuf2: Record "Dimension Buffer";
        ObjTransl: Record "Object Translation";
        DimValComb: Record "Dimension Value Combination";
        JobTaskDimTemp: Record "Job Task Dimension";
        DefaultDim: Record "Default Dimension";
        DimSetEntry: Record "Dimension Set Entry";
        TempDimSetEntry2: Record "Dimension Set Entry";
        TempDimCombInitialized: Boolean;
        TempDimCombEmpty: Boolean;
        DimCombErr: Text[250];
        DimValuePostingErr: Text[250];
        DimErr: Text[250];
        DocDimConsistencyErr: Text[250];
        HasGotGLSetup: Boolean;
        GLSetupShortcutDimCode: array[8] of Code[20];
        DimSetFilterCtr, LastDimSetIDInFilter : Integer;
        Text000: Label 'Dimensions %1 and %2 can not be used concurrently.';
        Text001: Label 'Dimension combinations %1 - %2 and %3 - %4 can not be used concurrently.';
        Text002: Label 'This Shortcut Dimension is not defined in the %1.';
        Text003: Label '%1 is not an available %2 for that dimension.';
        Text004: Label 'Select a %1 for the %2 %3.';
        Text005: Label 'Select a %1 for the %2 %3 for %4 %5.';
        Text006: Label 'Select %1 %2 for the %3 %4.';
        Text007: Label 'Select %1 %2 for the %3 %4 for %5 %6.';
        Text008: Label '%1 %2 must be blank.';
        Text009: Label '%1 %2 must be blank for %3 %4.';
        Text010: Label '%1 %2 must not be mentioned.';
        Text011: Label '%1 %2 must not be mentioned for %3 %4.';
        Text012: Label 'A %1 used in %2 has not been used in %3.';
        Text013: Label '%1 for %2 %3 is not the same in %4 and %5.';
        Text014: Label '%1 %2 is blocked.';
        Text015: Label '%1 %2 can not be found.';
        Text016: Label '%1 %2 - %3 is blocked.';
        Text017: Label '%1 for %2 %3 - %4 must not be %5.';
        Text018: Label '%1 for %2 is missing.';
        Text019: Label 'You have changed a dimension.\\Do you want to update the lines?';
        DimensionIsBlockedErr: Label 'The combination of dimensions used in %1 %2 is blocked (Error: %3).';
        LineDimensionBlockedErr: Label 'The combination of dimensions used in %1 %2, line no. %3 is blocked (Error: %4).';
        InvalidDimensionsErr: Label 'The dimensions used in %1 %2 are invalid (Error: %3).';
        LineInvalidDimensionsErr: Label 'The dimensions used in %1 %2, line no. %3 are invalid (Error: %4).';

}
