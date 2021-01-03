/// <summary>
/// Page TKA Project Task Subform (ID 81002).
/// Shows all project tasks for specific project within database.
/// </summary>
page 81002 "TKA Project Task Subform"
{
    Caption = 'Project Tasks';
    PageType = ListPart;
    UsageCategory = None;
    SourceTable = "TKA Project Task";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("TKA Task No."; Rec."TKA Task No.")
                {
                    ToolTip = 'Specifies no. of the task.';
                    ApplicationArea = All;
                }
                field("TKA Description"; Rec."TKA Description")
                {
                    ToolTip = 'Specifies description of the project task.';
                    ApplicationArea = All;
                }
                field("TKA Invoicing Work Type Code"; Rec."TKA Invoicing Work Type Code")
                {
                    ToolTip = 'Specifies work type code used for creating sales documents.';
                    ApplicationArea = All;
                }
                field("TKA Calc. Work Type Code"; Rec."TKA Calc. Work Type Code")
                {
                    ToolTip = 'Specifies work type code used for reporting.';
                    ApplicationArea = All;
                }
                field("TKA Quantity Planned"; Rec."TKA Quantity Planned")
                {
                    ToolTip = 'Specifies quantity planned for this job task.';
                    ApplicationArea = All;
                }
                field("TKA Quantity Rem. To Consume"; Rec."TKA Quantity Rem. To Consume")
                {
                    ToolTip = 'Specifies quantity that is prepared to be consumed from the project task.';
                    ApplicationArea = All;
                }
                field("TKA Quantity Consumed"; Rec."TKA Quantity Consumed")
                {
                    ToolTip = 'Specifies quantity consumed from the project task.';
                    ApplicationArea = All;
                }
                field("TKA Remaining Qty."; Rec."TKA Quantity Planned" - Rec."TKA Quantity Rem. To Consume" - Rec."TKA Quantity Consumed")
                {
                    Caption = 'Remaining Quantity';
                    ToolTip = 'Specifies quantity that remaines from planned quantity.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("TKA Int. Qty. Rem. To Consume"; Rec."TKA Int. Qty. Rem. To Consume")
                {
                    ToolTip = 'Specifies internal quantity that is not yet consumed. Internal quantity is not deducted from planned quantity.';
                    ApplicationArea = All;
                }
                field("TKA Internal Quantity Consumed"; Rec."TKA Internal Quantity Consumed")
                {
                    ToolTip = 'Specifies internal quantity consumed. Internal quantity is not deducted from planned quantity.';
                    ApplicationArea = All;
                }
                field("TKA Closed"; Rec."TKA Closed")
                {
                    ToolTip = 'Specifies whether the project task is closed. Closed project tasks are not shown in API and is not possible to post anything within the task.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
