/// <summary>
/// PageExtension TKA SWEM Resource List (ID 81005) extends Record Resource List.
/// </summary>
pageextension 81005 "TKA SWEM Resource List" extends "Resource List"
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
            field("TKA SWEM E-Mail"; Rec."TKA SWEM E-Mail")
            {
                ToolTip = 'Specifies e-mail of the resource for using in projects.';
                ApplicationArea = All;
            }
        }
    }
}