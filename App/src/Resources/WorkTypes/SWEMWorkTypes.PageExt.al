pageextension 81003 "TKA SWEM Work Types" extends "Work Types"
{
    layout
    {
        addafter(Description)
        {
            field("TKA Unbilled Works"; Rec."TKA Unbilled Works")
            {
                ToolTip = 'Specifies whether quantity posted with this work type codes are posted to the project ledger entries as unbilled (internal) quantity.';
                ApplicationArea = All;
            }
        }
    }
}