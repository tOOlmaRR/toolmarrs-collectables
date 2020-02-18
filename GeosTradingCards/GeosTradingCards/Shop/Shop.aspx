<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Shop.aspx.cs" EnableViewState="false" Inherits="GeoTradingCards.Shop.Shop" MasterPageFile="~/Main.Master" Title="Geo Trading Cards - The Card Shop" %>
<%@ Register TagPrefix="Nav" TagName="LeftMenu" Src="~/Controls/LeftMenuMain.ascx" %>
<%@ Register TagPrefix="Ad" TagName="MediumRectangleROS" Src="~/Controls/Advertising/MedRectangleROS.ascx" %>
<%@ Register TagPrefix="Nav" TagName="Footer" Src="~/Controls/ShopFooter.ascx" %>
<%@ MasterType VirtualPath="~/Main.Master" %>

<asp:Content ID="metaTags" ContentPlaceHolderID="metaTags" runat="server">
	<meta name="keywords" content="geo trading cards, george u marr enterprises, hockey cards, trading cards, hockey, collectables, shopping" />
	<meta name="description" content="Geo Trading Cards - The homepage of our online card shop. Keep in mind that we have much more available for sale than what is listed online." />
</asp:Content>

<asp:Content ID="leftMenuContent" ContentPlaceHolderID="cpleftMenu" runat="server">
	<Nav:LeftMenu ID="leftMenuCtrl" runat="server" />
</asp:Content>

<asp:Content ID="mainContent" ContentPlaceHolderID="PageContent" runat="server">
	<h1>The Card Shop</h1>
	<p>Within these pages, you will (eventually) be able to browse through our entire inventory of trading cards and quickly send trade or purchase requests to us. Over time, our extensive sports cards inventory will become listed here, but this process is very time-consuming and will take some time to publish, especially as we purchase more inventory. If you don't see what you're looking for, please <asp:Hyperlink NavigateUrl="~/Contact.aspx" Text="contact us" runat="server" /> with your requests. At this time, we have less than 1/25th of our inventory listed online!</p>
	<p>To navigate through our inventory, follow the links at the left.</p>
	<Ad:MediumRectangleROS ID="medRect" runat="server" />
	<Nav:Footer ID="shopFooter" runat="server" />
</asp:Content>