/// <summary>
/// Codeunit TKA SW Project E-Master Mgmt. (ID 81000).
/// </summary>
codeunit 81000 "TKA SW Project E-Master Mgmt."
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeInitInsert', '', false, false)]
    local procedure SalesHeaderOnBeforeInitInsert(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    var
        TKASWProjectEMasterSetup: Record "TKA SW Project E-Master Setup";

        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin
        if not SalesHeader."TKA SWEM Service Order" then
            exit;

        TKASWProjectEMasterSetup.FindFirst();
        if TKASWProjectEMasterSetup."TKA Service Order Nos." <> '' then begin
            NoSeriesManagement.InitSeries(TKASWProjectEMasterSetup."TKA Service Order Nos.", xSalesHeader."No. Series", SalesHeader."Posting Date", SalesHeader."No.", SalesHeader."No. Series");
            IsHandled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure SalesLineOnAfterInsertEvent()
    begin
        // TODO Post project ledger entries
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterDeleteEvent', '', false, false)]
    local procedure SalesLineOnAfterDeleteEvent(var Rec: Record "Sales Line")
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.SetRange("Document Type", Rec."Document Type");
        SalesLine.SetRange("Document No.", Rec."Document No.");
        SalesLine.SetRange("TKA Linked To Line No.", Rec."Line No.");
        SalesLine.DeleteAll(true);
        SalesLine.SetRange("TKA Linked To Line No.");

        if Rec."TKA Linked To Line No." <> 0 then begin
            SalesLine.SetRange("Line No.", Rec."TKA Linked To Line No.");
            SalesLine.DeleteAll(true);
        end;

        // TODO Post cancellation for Project Ledger Entries
    end;
}