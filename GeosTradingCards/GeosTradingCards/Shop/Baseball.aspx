<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Baseball.aspx.cs" Inherits="GeoTradingCards.Shop.Baseball" MasterPageFile="~/Main.Master" Title="Geo Trading Cards - Baseball Cards" %>
<%@ Register TagPrefix="Nav" TagName="LeftMenu" Src="~/Controls/LeftMenuMain.ascx" %>
<%@ Register TagPrefix="Ad" TagName="MediumRectangleROS" Src="~/Controls/Advertising/MedRectangleROS.ascx" %>
<%@ Register TagPrefix="Nav" TagName="Footer" Src="~/Controls/ShopFooter.ascx" %>
<%@ MasterType VirtualPath="~/Main.Master" %>

<asp:Content ID="metaTags" ContentPlaceHolderID="metaTags" runat="server">
	<meta name="keywords" content="geo trading cards, george u marr enterprises, baseball cards, trading cards, baseball, collectables" />
	<meta name="description" content="Geo Trading Cards Card Shop - Our online baseball card shop. The cards we have available for sale or trade are primarily between 1987 and 1993. This is one area in which we hope to grow our inventory in the future" />
</asp:Content>

<asp:Content ID="leftMenuContent" ContentPlaceHolderID="cpleftMenu" runat="server">
	<Nav:LeftMenu ID="leftMenuCtrl" runat="server" />
</asp:Content>

<asp:Content ID="mainContent" ContentPlaceHolderID="PageContent" runat="server">
	<h1>Baseball Cards</h1>
	<p>Our inventory of baseball cards is signficantly smaller than hockey, but this is the sport that we would like to expand on in the future. Most of the cards in our inventory are from the 1990's, particularly from 1990-1993. We also have a fairly large number of cards between 1980 and 1990, but they are primarily commons and minor stars.</p>
	<p>It may be some time before we are able to get any inventory listed here. Please feel free to <asp:HyperLink NavigateUrl="~/Contact.aspx" Text="contact us" runat="server" /> to find out if we have what you are looking for. Below is a list of sets that we have a significant number of cards from:</p>
	<ul>
		<li>1987 Topps</li>
		<li>1988 Donruss</li>
		<li>1989 Topps</li>
		<li>1990 Donruss</li>
		<li>1991 Donruss</li>
		<li>1991 Score</li>
		<li>1991 Upper Deck</li>
		<li>1992 Donruss</li>
		<li>1992 Fleer Ultra</li>
		<li>1992 Score Pinnacle</li>
		<li>1992 Upper Deck</li>
		<li>1993 Bowman</li>
		<li>1993 Upper Deck</li>
	</ul>
	<Ad:MediumRectangleROS ID="medRect" runat="server" />
	<Nav:Footer ID="shopFooter" runat="server" />
</asp:Content>