/// <summary>
/// Table TKA Project Task (ID 81001).
/// Defines lines (tasks) for specific project.
/// </summary>
table 81001 "TKA Project Task"
{
    Caption = 'Project Task';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "TKA Project No."; Code[20])
        {
            Caption = 'Project No.';
            NotBlank = true;
            TableRelation = "TKA Project"."TKA No.";
            DataClassification = CustomerContent;
        }
        field(2; "TKA Task No."; Code[20])
        {
            Caption = 'Task No.';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(10; "TKA Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(50; "TKA Closed"; Boolean)
        {
            Caption = 'Closed';
            DataClassification = SystemMetadata;
        }
        field(100; "TKA Invoicing Work Type Code"; Code[10])
        {
            Caption = 'Invoicing Work Type Code';
            TableRelation = "Work Type".Code;
            DataClassification = CustomerContent;
        }
        field(101; "TKA Calc. Work Type Code"; Code[10])
        {
            Caption = 'Calculation Work Type Code';
            TableRelation = "Work Type".Code;
            DataClassification = CustomerContent;
        }
        field(105; "TKA Invoicing Unit Price"; Decimal)
        {
            Caption = 'Invoicing Unit Price';
            DataClassification = CustomerContent;
        }
        field(106; "TKA Invoicing Total Price"; Decimal)
        {
            Caption = 'Invoicing Total Price';
            DataClassification = CustomerContent;
        }
        field(110; "TKA Calc. Unit Price (LCY)"; Decimal)
        {
            Caption = 'Calculation Unit Price (LCY)';
            DataClassification = CustomerContent;
        }
        field(111; "TKA Calc. Total Price"; Decimal)
        {
            Caption = 'Calculation Total Price (LCY)';
            DataClassification = CustomerContent;
        }
        field(250; "TKA Quantity Planned"; Decimal)
        {
            Caption = 'Quantity Planned';
            DataClassification = CustomerContent;
        }
        field(251; "TKA Quantity Rem. To Consume"; Decimal)
        {
            Caption = 'Quantity Remaining To Consume';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("TKA Project Ledger Entry"."TKA Quantity Rem. To Consume" where("TKA Project No." = field("TKA Project No."), "TKA Project Task No." = field("TKA Task No.")));
        }
        field(252; "TKA Quantity Consumed"; Decimal)
        {
            Caption = 'Quantity Consumed';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("TKA Project Ledger Entry"."TKA Quantity Consumed" where("TKA Project No." = field("TKA Project No."), "TKA Project Task No." = field("TKA Task No.")));
        }
        field(253; "TKA Int. Qty. Rem. To Consume"; Decimal)
        {
            Caption = 'Internal Quantity Remaining To Consume';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("TKA Project Ledger Entry"."TKA Int. Qty. Rem. To Consume" where("TKA Project No." = field("TKA Project No."), "TKA Project Task No." = field("TKA Task No.")));
        }
        field(254; "TKA Internal Quantity Consumed"; Decimal)
        {
            Caption = 'Internal Quantity Consumed';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("TKA Project Ledger Entry"."TKA Internal Qty. Consumed" where("TKA Project No." = field("TKA Project No."), "TKA Project Task No." = field("TKA Task No.")));
        }
    }

    keys
    {
        key(PK; "TKA Project No.", "TKA Task No.")
        {
            Clustered = true;
        }
    }

    trigger OnDelete();
    begin
        CheckExistingLinkedRecords();
    end;

    trigger OnRename()
    begin
        CheckExistingLinkedRecords()
    end;

    local procedure CheckExistingLinkedRecords();
    var
        SalesLine: Record "Sales Line";
        SalesShipmentLine: Record "Sales Shipment Line";
        SalesInvoiceLine: Record "Sales Invoice Line";
        TKAProjectLedgerEntry: Record "TKA Project Ledger Entry";

        LinkedRecordsExistErr: Label 'Project task can not be deleted as there are some existing records in %1 linked to this task.', Comment = '%1 - table where linked records are.';
    begin
        TKAProjectLedgerEntry.SetRange("TKA Project No.", Rec."TKA Project No.");
        TKAProjectLedgerEntry.SetRange("TKA Project Task No.", Rec."TKA Task No.");
        if not TKAProjectLedgerEntry.IsEmpty() then
            Error(LinkedRecordsExistErr, TKAProjectLedgerEntry.TableCaption());

        SalesShipmentLine.SetRange("TKA Project No.", Rec."TKA Project No.");
        SalesShipmentLine.SetRange("TKA Project Task No.", Rec."TKA Task No.");
        if not SalesShipmentLine.IsEmpty() then
            Error(LinkedRecordsExistErr, SalesShipmentLine.TableCaption());

        SalesInvoiceLine.SetRange("TKA Project No.", Rec."TKA Project No.");
        SalesInvoiceLine.SetRange("TKA Project Task No.", Rec."TKA Task No.");
        if not SalesInvoiceLine.IsEmpty() then
            Error(LinkedRecordsExistErr, SalesInvoiceLine.TableCaption());

        SalesLine.SetRange("TKA Project No.", Rec."TKA Project No.");
        SalesLine.SetRange("TKA Project Task No.", Rec."TKA Task No.");
        if not SalesLine.IsEmpty() then
            Error(LinkedRecordsExistErr, SalesLine.TableCaption());
    end;
}