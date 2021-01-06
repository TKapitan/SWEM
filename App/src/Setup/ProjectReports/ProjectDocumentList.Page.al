/// <summary>
/// Page TKA Service Document List (ID 81011).
/// </summary>
page 81011 "TKA Project Document List"
{
    Caption = 'Project Document List';
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "TKA Project Document";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("TKA Code"; Rec."TKA Code")
                {
                    ToolTip = 'Specifies code of the project document that serves as identification.';
                    ApplicationArea = All;
                }
                field("TKA Project External ID"; Rec."TKA Project External ID")
                {
                    ToolTip = 'Specifies external ID of the project document how it can be identified withing service module.';
                    ApplicationArea = All;
                }
                field("TKA Report Object No."; Rec."TKA Report Object No.")
                {
                    ToolTip = 'Specifies number of the report that should be sent to email.';
                    ApplicationArea = All;
                }
                field("TKA Email Subject"; Rec."TKA Email Subject")
                {
                    ToolTip = 'Specifies subject of emails that will be send based on this setup.';
                    ApplicationArea = All;
                }
                field("TKA Email Body"; Rec."TKA Email Body")
                {
                    ToolTip = 'Specifies body (HTML formatted) of emails that will be send based on this setup.';
                    ApplicationArea = All;
                }
            }
        }
    }

}
