/// <summary>
/// Page TKA Project Ledger Entries (ID 81003).
/// </summary>
page 81003 "TKA Project Ledger Entries"
{
    Caption = 'Project Ledger Entries';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "TKA Project Ledger Entry";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("TKA Entry No."; Rec."TKA Entry No.")
                {
                    ToolTip = 'Specifies no. of the entry.';
                    ApplicationArea = All;
                }
                field("TKA Posting Date"; Rec."TKA Posting Date")
                {
                    ToolTip = 'Specifies posting date of the entry.';
                    ApplicationArea = All;
                }
                field("TKA Resource No."; Rec."TKA Resource No.")
                {
                    ToolTip = 'Specifies no. of the resource which consume quantity.';
                    ApplicationArea = All;
                }
                field("TKA Quantity To Consume"; Rec."TKA Quantity To Consume")
                {
                    ToolTip = 'Specifies quantity to consume from the project task.';
                    ApplicationArea = All;
                }
                field("TKA Quantity Consumed"; Rec."TKA Quantity Consumed")
                {
                    ToolTip = 'Specifies quantity already consumed from the project task.';
                    ApplicationArea = All;
                }
                field("TKA Quantity Rem. To Consume"; Rec."TKA Quantity Rem. To Consume")
                {
                    ToolTip = 'Specifies quantity remaining that was set as to consume but is still not consumed.';
                    ApplicationArea = All;
                }
                field("TKA Internal Qty. To Consume"; Rec."TKA Internal Qty. To Consume")
                {
                    ToolTip = 'Specifies internal quantity to consume from the project task.';
                    ApplicationArea = All;
                }
                field("TKA Internal Qty.  Consumed"; Rec."TKA Internal Qty. Consumed")
                {
                    ToolTip = 'Specifies internal quantity already consumed from the project task.';
                    ApplicationArea = All;
                }
                field("TKA Int. Qty. Rem. To Consume"; Rec."TKA Int. Qty. Rem. To Consume")
                {
                    ToolTip = 'Specifies internal quantity remaining that was set as to consume but is still not consumed.';
                    ApplicationArea = All;
                }
            }
        }
    }

}
