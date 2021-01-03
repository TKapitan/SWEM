/// <summary>
/// Enum TKA Project Status (ID 81000).
/// Specifies possible statuses of each project.
/// </summary>
enum 81000 "TKA Project Status"
{
    Extensible = true;

    value(10; "Quote")
    {
        Caption = 'Quote';
    }
    value(15; "Open")
    {
        Caption = 'Open';
    }
    value(90; "Completed")
    {
        Caption = 'Completed';
    }
}