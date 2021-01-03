/// <summary>
/// Page TKA Sales Ser. Order Lines API (ID 81013).
/// </summary>
page 81013 "TKA Sales Ser. Order Lines API"
{
    Caption = 'salesServiceOrderLinesAPI', Locked = true;
    PageType = API;
    APIPublisher = 'keptyCZ';
    APIGroup = 'swProjectEMaster';
    APIVersion = 'v1.0';
    EntityName = 'salesServiceOrderLine';
    EntitySetName = 'salesServiceOrderLines';

    InsertAllowed = true;
    ModifyAllowed = true;
    DeleteAllowed = true;
    DelayedInsert = true;

    SourceTable = "Sales Line";
    SourceTableView = where("TKA SWEM Service Order" = const(true));

    layout
    {
        area(content)
        {
            repeater(Reptr)
            {
                field(documentNo; Rec."Document No.") { }
                field(lineNo; Rec."Line No.")
                {
                    trigger OnValidate();
                    var
                        CannotChangeLineNoErr: Label 'The value for line no. cannot be modified. Delete and insert the line again.';
                    begin
                        if xRec."Line No." <> Rec."Line No." then
                            Error(CannotChangeLineNoErr);
                    end;
                }
                field(type; Rec."Type") { }
                field(no; Rec."No.") { }
                field(shipmentDate; Rec."Shipment Date") { }
                field(description; Rec.Description) { }
                field(invoicableQty; InvoicableQty) { }
                field(internalQty; InternalQty) { }
                field(workTypeCode; Rec."Work Type Code") { }
                field(projectNo; Rec."TKA Project No.") { }
                field(projectDescription; TKAProject."TKA Description")
                {
                    Editable = false;
                }
                field(projectTaskNo; Rec."TKA Project Task No.") { }
                field(projectTaskDescription; TKAProjectTask."TKA Description")
                {
                    Editable = false;
                }
                field(timeFrom; Rec."TKA Time From") { }
                field(timeTo; Rec."TKA Time To") { }
                field(linkedToLineNo; Rec."TKA Linked to Line No.") { }
                field(unitPrice; Rec."Unit Price") { }
                field(closeProjectTask; CloseProjectTask) { }
                field(isEditable; LineIsEditable)
                {
                    Editable = false;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    var
        SalesLine: Record "Sales Line";

        MainLine: Boolean;
    begin
        GetProjectAndProjectTask();
        UpdateLineIsEditable();

        TotalQty := 0;
        InvoicableQty := 0;
        MainLine := false;
        SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SetRange("Document No.", Rec."Document No.");
        if Rec."TKA Linked To Line No." <> 0 then begin
            // Check whether the main record exists (it should exists, but if does not exist, work with the line as if it is main line)
            SalesLine.SetRange("Line No.", Rec."TKA Linked To Line No.");
            if SalesLine.IsEmpty() then
                MainLine := true;
        end else
            MainLine := true;

        if MainLine then begin
            TotalQty := Rec.Quantity;
            if not IsUnbilledWorkType(Rec."Work Type Code") then
                InvoicableQty := Rec.Quantity;

            if Rec."Line No." <> 0 then begin
                SalesLine.SetFilter("Line No.", '<>%1', Rec."Line No.");
                SalesLine.SetRange("TKA Linked To Line No.", Rec."Line No.");
                if SalesLine.FindSet() then
                    repeat
                        TotalQty += SalesLine.Quantity;
                        if not IsUnbilledWorkType(Rec."Work Type Code") then
                            InvoicableQty += SalesLine.Quantity;
                    until SalesLine.Next() < 1;
            end;
        end;
    end;

    trigger OnDeleteRecord(): Boolean;
    begin
        UpdateLineIsEditable();
        if not LineIsEditable then
            Error(LineIsNotEditableErr);

        DeleteAllRelatedLines();
        exit(false);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        InsertAllRelatedLines();
        exit(false);
    end;

    trigger OnModifyRecord(): Boolean;
    begin
        UpdateLineIsEditable();
        if not LineIsEditable then
            Error(LineIsNotEditableErr);

        DeleteAllRelatedLines();
        InsertAllRelatedLines();
        exit(false);
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Reopen(Rec."Document No.");
        Rec.Validate("Document Type", Rec."Document Type"::Order);
        Rec.Validate(Type, Rec.Type::Resource);
    end;

    trigger OnOpenPage();
    begin
        Rec.SetFilter(Type, '<>%1', Rec.Type::" ");
    end;

    var
        TKAProject: Record "TKA Project";
        TKAProjectTask: Record "TKA Project Task";
        TotalQty, InvoicableQty, InternalQty : Decimal;
        LineIsEditable, CloseProjectTask : Boolean;
        LineIsNotEditableErr: Label 'The line is not editable.';

    local procedure UpdateLineIsEditable()
    begin
        LineIsEditable := true;
        if Rec."Qty. Shipped (Base)" <> 0 then
            LineIsEditable := false;

        GetProjectAndProjectTask();
        if TKAProject."TKA Status" <> TKAProject."TKA Status"::Open then
            LineIsEditable := false;
        if TKAProjectTask."TKA Closed" then
            LineIsEditable := false;
    end;

    local procedure UpdateCloseProjectTask()
    begin
        GetProjectAndProjectTask();
        if Rec."TKA Project Task No." <> '' then
            if TKAProjectTask."TKA Closed" <> CloseProjectTask then begin
                TKAProjectTask.Validate("TKA Closed", CloseProjectTask);
                TKAProjectTask.Modify(true);
            end
    end;

    local procedure GetProjectAndProjectTask()
    begin
        Clear(TKAProject);
        Clear(TKAProjectTask);
        TKAProject.Init();
        TKAProjectTask.Init();
        if Rec."TKA Project No." <> '' then begin
            TKAProject.Get(Rec."TKA Project No.");

            if Rec."TKA Project Task No." <> '' then
                TKAProjectTask.Get(Rec."TKA Project No.", Rec."TKA Project Task No.");
        end;
    end;

    local procedure IsUnbilledWorkType(WorkTypeCode: Code[10]): Boolean
    var
        WorkType: Record "Work Type";
    begin
        if WorkTypeCode = '' then
            exit(false);
        WorkType.Get(WorkTypeCode);
        exit(WorkType."TKA Unbilled Works");
    end;

    local procedure Reopen(DocumentNo: Code[20])
    var
        SalesHeader: Record "Sales Header";
        ReleaseSalesDocument: Codeunit "Release Sales Document";
    begin
        SalesHeader.Get(SalesHeader."Document Type"::Order, DocumentNo);
        if SalesHeader.Status <> SalesHeader.Status::Open then
            ReleaseSalesDocument.Reopen(SalesHeader);
        Rec.SuspendStatusCheck(true);
    end;

    local procedure InsertAllRelatedLines();
    var
        SalesLine: Record "Sales Line";
        TKASWProjectEMasterSetup: Record "TKA SW Project E-Master Setup";

        AmountTemp: Decimal;
        NewLineNo, StandardLineNo : Integer;
    begin
        Reopen(Rec."Document No.");

        NewLineNo := 10000;
        StandardLineNo := 0;
        SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SetRange("Document No.", Rec."Document No.");
        if SalesLine.FindLast() then
            NewLineNo += SalesLine."Line No.";
        Clear(SalesLine);

        // Insert standard line
        if not IsUnbilledWorkType(Rec."Work Type Code") and (InvoicableQty <> 0) then begin
            AmountTemp := Rec."Unit Price";
            Rec."Line No." := NewLineNo;
            Rec.Validate(Quantity, InvoicableQty);
            Rec.Validate("Unit Price", AmountTemp);

            NewLineNo += 10000;
            Rec."TKA Linked To Line No." := 0;
            Rec.Insert(true);

            StandardLineNo := Rec."Line No.";
        end else
            InvoicableQty := 0;

        // TODO Email notification about posted/cancelled hours
        // Rec.Validate("ART CU Appointment Sent", false);
        // Rec."ART CU Appoint. Sent To Email" := '';

        // Insert overheader line
        if (TotalQty - InvoicableQty) <> 0 then begin
            TKASWProjectEMasterSetup.FindFirst();
            TKASWProjectEMasterSetup.TestField("TKA Default Unbilled Work Type");

            SalesLine.SuspendStatusCheck(true);
            SalesLine.Copy(Rec);
            SalesLine."Line No." := NewLineNo;
            SalesLine.Validate(Quantity, TotalQty - InvoicableQty);
            SalesLine.Validate("Work Type Code", TKASWProjectEMasterSetup."TKA Default Unbilled Work Type");
            SalesLine.Validate("Unit Price", 0);
            SalesLine.Validate("TKA Linked To Line No.", StandardLineNo);
            SalesLine.Insert(true);
        end;
        UpdateCloseProjectTask();
    end;

    local procedure DeleteAllRelatedLines();
    var
        SalesHeader: Record "Sales Header";

        ReleaseSalesDocument: Codeunit "Release Sales Document";
    begin
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetRange("No.", Rec."Document No.");
        SalesHeader.FindFirst();

        ReleaseSalesDocument.PerformManualReopen(SalesHeader);
        Rec.Delete(true);
    end;
}

