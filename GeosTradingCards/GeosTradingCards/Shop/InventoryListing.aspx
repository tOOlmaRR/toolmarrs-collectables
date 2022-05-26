<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InventoryListing.aspx.cs" Inherits="GeoTradingCards.Shop.InventoryListing" MasterPageFile="~/Main.Master" %>
<%@ Register TagPrefix="Nav" TagName="LeftMenu" Src="~/Controls/LeftMenuMain.ascx" %>
<%@ Register TagPrefix="Ad" TagName="MediumRectangleROS" Src="~/Controls/Advertising/MedRectangleROS.ascx" %>
<%@ Register TagPrefix="Nav" TagName="Footer" Src="~/Controls/ShopFooter.ascx" %>
<%@ MasterType VirtualPath="~/Main.Master" %>

<asp:Content ID="metaTags" ContentPlaceHolderID="metaTags" runat="server">
	<meta id="metaKeywords" name="keywords" runat="server" />
	<meta id="metaDescription" name="description" runat="server" />
</asp:Content>

<asp:Content ID="leftMenuContent" ContentPlaceHolderID="cpleftMenu" runat="server">
	<Nav:LeftMenu ID="leftMenuCtrl" runat="server" />
</asp:Content>

<asp:Content ID="mainContent" ContentPlaceHolderID="PageContent" runat="server">
	<h1><asp:Label ID="litPageTitle" runat="server" /></h1>
	
	<asp:Panel ID="pnlError" CssClass="error" Visible="false" runat="server">
		<p>This card set could not be found. Please try another search.</p>
	</asp:Panel>
	
	<asp:Panel ID="pnlCardListing" runat="server">
		<iframe id="cardListingFrame" title="Card set inventory listing" width="770" height="400" frameborder="0" runat="server"></iframe>
	</asp:Panel>
	
	<Ad:MediumRectangleROS ID="medRect" runat="server" />
	<p style="color: Black;"><span style="font-weight: bold; text-decoration: underline;">Note</span>: All prices are in <strong>Canadian dollars.</strong></p>
	<Nav:Footer ID="shopFooter" runat="server" />
</asp:Content>
