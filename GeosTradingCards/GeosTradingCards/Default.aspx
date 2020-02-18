<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" EnableViewState="false" Inherits="GeoTradingCards._Default" MasterPageFile="~/Main.Master" Title="Geo Trading Cards - Welcome!" %>
<%@ Register TagPrefix="LeftMenu" TagName="Main" Src="~/Controls/LeftMenuMain.ascx" %>
<%@ Register TagPrefix="Ad" TagName="MediumRectangleROS" Src="~/Controls/Advertising/MedRectangleROS.ascx" %>
<%@ Register TagPrefix="Nav" TagName="Footer" Src="~/Controls/MainFooter.ascx" %>
<%@ MasterType VirtualPath="~/Main.Master" %>

<asp:Content ID="metaTags" ContentPlaceHolderID="metaTags" runat="server">
	<meta name="keywords" content="geo trading cards, george u marr enterprises, hockey cards, trading cards, hockey, collectables" />
	<meta name="description" content="Geo Trading Cards - Tens of thousands of single trading cards looking for a new home. Also, the future home of a revolutionary new community of card collectors." />
</asp:Content>

<asp:Content ID="leftMenuContent" ContentPlaceHolderID="cpleftMenu" runat="server">
	<LeftMenu:Main ID="leftMenuControl" runat="server" />
</asp:Content>

<asp:Content ID="mainContent" ContentPlaceHolderID="PageContent" runat="server">
    <h1>Geo Trading Cards &amp; Collectables</h1>
    <p>Welcome to Geo Trading Cards online! Here, you can (eventually) view my entire trading card collection and order any cards you wish to purchase. My collection is large and will grow over time, and I will be publishing every single card here. That means if you are looking for a few common cards to fill a set, or trying to assemble a team or player-based collection, you can find what you are looking for fast, without having to send checklists and wait for a response.</p>
    <p>I can also help you to publish your collection online by following in my footsteps. After all, collecting isn't quite as fun if you cannot show other collectors what you have and what you want. You might even earn a few dollars in the process (and probably run out to buy more cards!).</p>
	<Ad:MediumRectangleROS ID="MedRectAd" runat="server" />
    <Nav:Footer ID="mainFooter" runat="server" />
</asp:Content>