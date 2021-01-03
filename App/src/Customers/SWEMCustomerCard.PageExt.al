/// <summary>
/// PageExtension TKA SWEM Customer Card (ID 81000) extends Record Customer Card.
/// </summary>
pageextension 81000 "TKA SWEM Customer Card" extends "Customer Card"
{
    layout
    {
        addafter("Name 2")
        {
            field("TKA SWEM Project API No."; Rec."TKA SWEM Project API No.")
            {
                ToolTip = 'Specifies No. under which the customer is found externally using APIs in projects.';
                ApplicationArea = All;
            }
        }
    }
}