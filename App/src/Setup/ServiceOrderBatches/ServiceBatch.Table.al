/// <summary>
/// Table TKA Service Order Batch (ID 81006).
/// </summary>
table 81006 "TKA Service Batch"
{
    Caption = 'Service Batch';
    LookupPageId = "TKA Service Batch List";
    DrillDownPageId = "TKA Service Batch List";
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "TKA Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = SystemMetadata;
        }

        field(2; "TKA Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";
            DataClassification = SystemMetadata;
        }

        field(3; "TKA Outstanding Quantity"; Decimal)
        {
            Caption = 'Outstanding Quantity';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Sales Line"."Outstanding Quantity" where("Outstanding Quantity" = filter('<>0'), "Sell-to Customer No." = field("TKA Customer No."), "TKA Service Batch Code" = field("TKA Code")));
        }

        field(4; "TKA Qty. Shipped"; Decimal)
        {
            Caption = 'Quantity Shipped';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Sales Line"."Quantity Shipped" where("Quantity Shipped" = filter('<>0'), "Sell-to Customer No." = field("TKA Customer No."), "TKA Service Batch Code" = field("TKA Code")));
        }

        field(5; "TKA Qty. Shipped not Inv."; Decimal)
        {
            Caption = 'Quantity Shipped not Invoiced';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Sales Line"."Qty. Shipped Not Invd. (Base)" where("Qty. Shipped Not Invd. (Base)" = filter('<>0'), "Sell-to Customer No." = field("TKA Customer No."), "TKA Service Batch Code" = field("TKA Code")));
        }

        field(6; "TKA Qty. Invoiced"; Decimal)
        {
            Caption = 'Quantity Invoiced';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Sales Line"."Quantity Invoiced" where("Quantity Invoiced" = filter('<>0'), "Sell-to Customer No." = field("TKA Customer No."), "TKA Service Batch Code" = field("TKA Code")));
        }
    }

    keys
    {
        key(PK; "TKA Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "TKA Code", "TKA Customer No.", "TKA Qty. Shipped", "TKA Qty. Shipped not Inv.", "TKA Qty. Invoiced") { }
    }

    /// <summary>
    /// GenerateNewBatchCode.
    /// </summary>
    /// <param name="CustomerNo">Code[20].</param>
    /// <returns>Return value of type Code[20].</returns>
    procedure GenerateNewBatchCode(CustomerNo: Code[20]): Code[20];
    var
        TKAServiceBatch: Record "TKA Service Batch";
        TKASWProjectEMasterSetup: Record "TKA SW Project E-Master Setup";

        NoSeriesManagement: Codeunit NoSeriesManagement;

        BatchCode: Code[10];
    begin
        TKASWProjectEMasterSetup.FindFirst();
        TKASWProjectEMasterSetup.TestField("TKA Service Order Batch Nos.");

        BatchCode := Format(NoSeriesManagement.GetNextNo(TKASWProjectEMasterSetup."TKA Service Order Batch Nos.", WorkDate(), true));

        TKAServiceBatch.Init();
        TKAServiceBatch.Validate("TKA Code", BatchCode);
        TKAServiceBatch.Validate("TKA Customer No.", CustomerNo);
        TKAServiceBatch.Insert(true);
        exit(BatchCode);
    end;
}