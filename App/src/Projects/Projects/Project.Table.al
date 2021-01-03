/// <summary>
/// Table TKA Project (ID 81000).
/// Defines header of each project.
/// </summary>
table 81000 "TKA Project"
{
    Caption = 'Project';
    LookupPageId = "TKA Project List";
    DrillDownPageId = "TKA Project List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "TKA No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "TKA No." <> xRec."TKA No." then begin
                    NoSeriesManagement.TestManual(GetNoSeriesCode(false));
                    "TKA No. Series" := '';
                end;
            end;
        }
        field(2; "TKA Status"; Enum "TKA Project Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(5; "TKA Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(10; "TKA Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(11; "TKA Customer Project API No."; Text[50])
        {
            Caption = 'Customer Project API No.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Customer."TKA SWEM Project API No." where("No." = field("TKA Customer No.")));
        }
        field(20; "TKA Project Manager Code"; Code[20])
        {
            Caption = 'Project Manager Code';
            TableRelation = "Salesperson/Purchaser".Code;
            DataClassification = EndUserIdentifiableInformation;
        }
        field(30; "TKA No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series".Code;
            DataClassification = SystemMetadata;
        }
        field(50; "TKA Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = CustomerContent;
        }
        field(51; "TKA Ending Date"; Date)
        {
            Caption = 'Ending Date';
            DataClassification = CustomerContent;
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
        field(106; "TKA Calc. Unit Price (LCY)"; Decimal)
        {
            Caption = 'Calculation Unit Price (LCY)';
            DataClassification = CustomerContent;
        }
        field(110; "TKA Invoicing Currency Code"; Code[10])
        {
            Caption = 'Invoicing Currency Code';
            TableRelation = Currency.Code;
            DataClassification = CustomerContent;
        }
        field(250; "TKA Quantity Planned"; Decimal)
        {
            Caption = 'Quantity Planned';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("TKA Project Ledger Entry"."TKA Quantity Rem. To Consume" where("TKA Project No." = field("TKA No.")));
        }
        field(251; "TKA Quantity Rem. To Consume"; Decimal)
        {
            Caption = 'Quantity Remaining To Consume';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("TKA Project Ledger Entry"."TKA Quantity Rem. To Consume" where("TKA Project No." = field("TKA No.")));
        }
        field(252; "TKA Quantity Consumed"; Decimal)
        {
            Caption = 'Quantity Consumed';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("TKA Project Ledger Entry"."TKA Quantity Consumed" where("TKA Project No." = field("TKA No.")));
        }
        field(253; "TKA Int. Qty. Rem. To Consume"; Decimal)
        {
            Caption = 'Internal Quantity Remaining To Consume';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("TKA Project Ledger Entry"."TKA Int. Qty. Rem. To Consume" where("TKA Project No." = field("TKA No.")));
        }
        field(254; "TKA Internal Quantity Consumed"; Decimal)
        {
            Caption = 'Internal Quantity Consumed';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("TKA Project Ledger Entry"."TKA Internal Qty. Consumed" where("TKA Project No." = field("TKA No.")));
        }
        field(500; "TKA Allow API Create Tasks"; Boolean)
        {
            Caption = 'Allow API Create Tasks';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "TKA No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeInsert(Rec, IsHandled);
        if IsHandled then
            exit;

        if "TKA No." = '' then
            NoSeriesManagement.InitSeries(GetNoSeriesCode(false), xRec."TKA No. Series", 0D, Rec."TKA No.", Rec."TKA No. Series");
    end;

    trigger OnDelete()
    begin
        CheckExistingLinkedRecords();
    end;

    trigger OnRename()
    begin
        CheckExistingLinkedRecords();
    end;

    var
        NoSeriesManagement: Codeunit NoSeriesManagement;

    /// <summary>
    /// AssistEdit.
    /// </summary>
    /// <param name="OldTKAProject">Record "TKA Project".</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure AssistEdit(OldTKAProject: Record "TKA Project"): Boolean
    var
        TKAProject: Record "TKA Project";
    begin
        TKAProject := Rec;

        if NoSeriesManagement.SelectSeries(GetNoSeriesCode(false), OldTKAProject."TKA No. Series", TKAProject."TKA No. Series") then begin
            NoSeriesManagement.SetSeries(Rec."TKA No.");
            Rec := TKAProject;
            exit(true);
        end;
        exit(false);
    end;

    /// <summary>
    /// GetNoSeriesCode.
    /// </summary>
    /// <param name="AllowEmpty">Boolean.</param>
    /// <returns>Return value of type Code[20].</returns>
    procedure GetNoSeriesCode(AllowEmpty: Boolean): Code[20]
    var
        TKASWProjectEMasterSetup: Record "TKA SW Project E-Master Setup";
    begin
        TKASWProjectEMasterSetup.FindFirst();
        if not AllowEmpty then
            TKASWProjectEMasterSetup.TestField("TKA Project Nos.");
        exit(TKASWProjectEMasterSetup."TKA Project Nos.");
    end;

    local procedure CheckExistingLinkedRecords();
    var
        SalesLine: Record "Sales Line";
        SalesShipmentLine: Record "Sales Shipment Line";
        SalesInvoiceLine: Record "Sales Invoice Line";
        TKAProjectLedgerEntry: Record "TKA Project Ledger Entry";

        LinkedRecordsExistErr: Label 'Project can not be deleted as there are some existing records in %1 linked to this project.', Comment = '%1 - table where linked records are.';
    begin
        TKAProjectLedgerEntry.SetRange("TKA Project No.", Rec."TKA No.");
        if not TKAProjectLedgerEntry.IsEmpty() then
            Error(LinkedRecordsExistErr, TKAProjectLedgerEntry.TableCaption());

        SalesShipmentLine.SetRange("TKA Project No.", Rec."TKA No.");
        if not SalesShipmentLine.IsEmpty() then
            Error(LinkedRecordsExistErr, SalesShipmentLine.TableCaption());

        SalesInvoiceLine.SetRange("TKA Project No.", Rec."TKA No.");
        if not SalesInvoiceLine.IsEmpty() then
            Error(LinkedRecordsExistErr, SalesInvoiceLine.TableCaption());

        SalesLine.SetRange("TKA Project No.", Rec."TKA No.");
        if not SalesLine.IsEmpty() then
            Error(LinkedRecordsExistErr, SalesLine.TableCaption());
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsert(var TKAProject: Record "TKA Project"; var IsHandled: Boolean)
    begin
    end;
}