/// <summary>
/// Page TKA Servis Order Batch List (ID 81014).
/// </summary>
page 81014 "TKA Service Batch List"
{
    Caption = 'Service Batch List';
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "TKA Service Batch";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("TKA Code"; Rec."TKA Code")
                {
                    ToolTip = 'Specifies code of the service batch.';
                    ApplicationArea = All;
                }
                field("TKA Customer No."; Rec."TKA Customer No.")
                {
                    ToolTip = 'Specifies customer number of the customer, for whom the batch was created.';
                    ApplicationArea = All;
                }
                field("TKA Outstanding Quantity"; Rec."TKA Outstanding Quantity")
                {
                    ToolTip = 'Specifies quantity filled in service orders that was not shipped yet.';
                    ApplicationArea = All;
                }
                field("TKA Qty. Shipped"; Rec."TKA Qty. Shipped")
                {
                    ToolTip = 'Specifies quantity filled in service orders that was already shipped.';
                    ApplicationArea = All;
                }
                field("TKA Qty. Shipped not Inv."; Rec."TKA Qty. Shipped not Inv.")
                {
                    ToolTip = 'Specifies quantity filled in service orders that was already shipped yet but was not invoiced yet.';
                    ApplicationArea = All;
                }
                field("TKA Qty. Invoiced"; Rec."TKA Qty. Invoiced")
                {
                    ToolTip = 'Specifies quantity filled in service orders that was already shipped and invoiced.';
                    ApplicationArea = All;
                }

            }
        }
    }
}