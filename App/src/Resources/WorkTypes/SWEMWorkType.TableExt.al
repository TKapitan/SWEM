/// <summary>
/// TableExtension TKA SWEM Work Type (ID 81009) extends Record Work Type.
/// </summary>
tableextension 81009 "TKA SWEM Work Type" extends "Work Type"
{
    fields
    {
        field(81014; "TKA Unbilled Works"; Boolean)
        {
            Caption = 'Unbilled Works';
            DataClassification = CustomerContent;
        }
    }
}