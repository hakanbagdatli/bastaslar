<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PageHeader.ascx.cs" Inherits="WebSite.Shared.PageHeader" %>
<section class="breadcumb-section bgc-f7">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="breadcumb-style1">
                    <h2 class="title">
                        <asp:Literal ID="lblTitle" runat="server" /></h2>
                    <div class="breadcumb-list">
                        <ul itemscope itemtype="http://schema.org/BreadcrumbList" class="d-flex p-0">
                            <asp:Literal ID="lblBreadcrumb" runat="server" />
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>