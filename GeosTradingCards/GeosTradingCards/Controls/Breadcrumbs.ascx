<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Breadcrumbs.ascx.cs" Inherits="GeoTradingCards.Controls.Breadcrumbs" %>

<div class="breadcrumbs">
	<asp:Label ID="breadcrumbs" CssClass="breadcrumbTitle" Text="You are here : " runat="server" />
	<asp:Panel ID="pnlBreadcrumbs" CssClass="breadcrumbsContent" runat="server"></asp:Panel>
</div>