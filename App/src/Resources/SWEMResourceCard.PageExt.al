/// <summary>
/// PageExtension TKA SWEM Resource Card (ID 81004) extends Record Resource Card.
/// </summary>
pageextension 81004 "TKA SWEM Resource Card" extends "Resource Card"
{
    layout
    {
        addafter("Resource Group No.")
        {
            field("TKA SWEM Project Mandatory"; Rec."TKA SWEM Project Mandatory")
            {
                ToolTip = 'Specifies whether all posted service order records must have link to projects.';
                ApplicationArea = All;
            }
        }

        addafter("Job Title")
        {
            field("TKA SWEM E-Mail"; Rec."TKA SWEM E-Mail")
            {
                ToolTip = 'Specifies e-mail of the resource for using in projects.';
                ApplicationArea = All;
            }
        }
    }
}