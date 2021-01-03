/// <summary>
/// PageExtension TKA SWEM Salesp./Purch. Card (ID 81002) extends Record Salesperson/Purchaser Card.
/// </summary>
pageextension 81002 "TKA SWEM Salesp./Purch. Card" extends "Salesperson/Purchaser Card"
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