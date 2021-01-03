/// <summary>
/// PageExtension TKA SWM Salespersons/Purch. (ID 81001) extends Record Salespersons/Purchasers.
/// </summary>
pageextension 81001 "TKA SWM Salespersons/Purch." extends "Salespersons/Purchasers"
{
    layout
    {
        addafter(Name)
        {
            field("TKA SWEM Service External ID"; Rec."TKA SWEM Service External ID")
            {
                ToolTip = 'Specifies external ID of the salesperson/purchaser how he/she can be identified withing service module.';
                ApplicationArea = All;
            }
        }
    }
}