<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SubHeader.ascx.cs" Inherits="WebSite.Raven.Shared.SubHeader" %>

<div class="subheader py-2 py-lg-4 subheader-transparent" id="kt_subheader">
    <div class="container-fluid d-flex align-items-center justify-content-between flex-wrap flex-sm-nowrap">
        <div class="d-flex align-items-center flex-wrap mr-1">
            <div class="d-flex align-items-baseline flex-wrap mr-5">
                <ul class="breadcrumb breadcrumb-transparent breadcrumb-dot font-weight-bold p-0 my-2 font-size-sm">
                    <asp:Literal ID="ltrTree" runat="server" />
                </ul>
            </div>
        </div>
    </div>
</div>