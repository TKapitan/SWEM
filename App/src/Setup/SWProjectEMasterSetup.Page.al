/// <summary>
/// Page TKA SW Project E-Master Setup (ID 81010).
/// </summary>
page 81010 "TKA SW Project E-Master Setup"
{
    Caption = 'SW Project E-Master Setup';
    PageType = Card;
    DeleteAllowed = false;
    InsertAllowed = false;
    UsageCategory = Administration;
    SourceTable = "TKA SW Project E-Master Setup";
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group("TKA General")
            {
                Caption = 'General';
                field("TKA Default Unbilled Work Type"; Rec."TKA Default Unbilled Work Type")
                {
                    ToolTip = 'Specifies default unbilled work type that will be used for creating unbilled lines when no work type is specified.';
                    ApplicationArea = All;
                }
            }
            group("TKA No. Series")
            {
                Caption = 'No. Series';
                field("TKA Service Order Nos."; Rec."TKA Service Order Nos.")
                {
                    ToolTip = 'Specifies No. series that will be used for creating sales service orders.';
                    ApplicationArea = All;
                }
                field("TKA Service Order Batch Nos."; Rec."TKA Service Order Batch Nos.")
                {
                    ToolTip = 'Specifies No. series that will be used for creating service order batches.';
                    ApplicationArea = All;
                }
                field("TKA Project Nos."; Rec."TKA Project Nos.")
                {
                    ToolTip = 'Specifies No. series that will be used for creating projects.';
                    ApplicationArea = All;
                }
            }
            group("TKA API Service Field Validation")
            {
                Caption = 'API Service Field Validation';
                field("TKA Service Valid. - Salesper."; Rec."TKA Service Valid. - Salesper.")
                {
                    ToolTip = 'Specifies ways how salesperson field should be validated when the value is changed in API';
                    ApplicationArea = All;
                }
                field("TKA Service Valid. - Status"; Rec."TKA Service Valid. - Status")
                {
                    ToolTip = 'Specifies ways how service status field should be validated when the value is changed in API';
                    ApplicationArea = All;
                }
                field("TKA Service Valid. - Type"; Rec."TKA Service Valid. - Type")
                {
                    ToolTip = 'Specifies ways how service type field should be validated when the value is changed in API';
                    ApplicationArea = All;
                }
                field("TKA Service Valid. - Depart."; Rec."TKA Service Valid. - Depart.")
                {
                    ToolTip = 'Specifies ways how service source department field should be validated when the value is changed in API';
                    ApplicationArea = All;
                }
                field("TKA Service Valid. - Report"; Rec."TKA Service Valid. - Report")
                {
                    ToolTip = 'Specifies ways how service reports should be validated when the value is changed in API';
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}