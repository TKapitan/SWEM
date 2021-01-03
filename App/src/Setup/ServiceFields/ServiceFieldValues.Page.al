/// <summary>
/// Page TKA Service Field Values (ID 81012).
/// </summary>
page 81012 "TKA Service Field Values"
{
    Caption = 'Service Field Values';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "TKA Service Field Value";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("TKA Type"; Rec."TKA Type")
                {
                    ToolTip = 'Specifies type of field value.';
                    ApplicationArea = All;
                }
                field("TKA Code"; Rec."TKA Code")
                {
                    ToolTip = 'Specifies code of the field value that serves as identification.';
                    ApplicationArea = All;
                }
                field("TKA Description"; Rec."TKA Description")
                {
                    ToolTip = 'Specifies description of the field value.';
                    ApplicationArea = All;
                }
                field("TKA Service External ID"; Rec."TKA Service External ID")
                {
                    ToolTip = 'Specifies external ID of the field value how it can be identified withing service module.';
                    ApplicationArea = All;
                }
            }
        }
    }

}
