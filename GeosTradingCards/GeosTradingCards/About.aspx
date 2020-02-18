<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="About.aspx.cs" EnableViewState="false" Inherits="GeoTradingCards.About" MasterPageFile="~/Main.Master" Title="Geo Trading Cards - About Us" %>
<%@ Register TagPrefix="LeftMenu" TagName="Main" Src="~/Controls/LeftMenuMain.ascx" %>
<%@ Register TagPrefix="Ad" TagName="MediumRectangleROS" Src="~/Controls/Advertising/MedRectangleROS.ascx" %>
<%@ Register TagPrefix="Nav" TagName="Footer" Src="~/Controls/MainFooter.ascx" %>
<%@ MasterType VirtualPath="~/Main.Master" %>

<asp:Content ID="metaTags" ContentPlaceHolderID="metaTags" runat="server">
	<meta name="keywords" content="geo trading cards, george u marr enterprises, hockey cards, trading cards, hockey, collectables" />
	<meta name="description" content="Geo Trading Cards - Everything you wanted to know about us but were afraid to ask." />
</asp:Content>

<asp:Content ID="leftMenuContent" ContentPlaceHolderID="cpleftMenu" runat="server">
	<LeftMenu:Main ID="leftMenuControl" runat="server" />
</asp:Content>

<asp:Content ID="mainContent" ContentPlaceHolderID="PageContent" runat="server">
    <h1>About Geo Trading Cards</h1>
    <p>I started collecting hockey cards way back in 1991 when the card industry really began to expand and grow. I have collected cards on and off since then and have experienced the industry at it's highest and it's lowest and I am passionate about helping to revitalize this wonderful hobby.</p>
    <p>This site has been created as a foundation from which I can expand and grow. Phase one is a very simple method of marketing my own collection. Phase two will include more dynamic features and will display my collection from my own database. Phase three will involve building community features including an online forum / message board and expanding upon my personal blog posts and articles. Phase four will be the foundations of a location for anyone to organise and market their own collections online through an expanded database (an improved version of what is available through beckett.com and upperdeck.com). From there, the sky is the limit!</p>
    <p>As well as a card collector, I am also a professional web and application developer, and through this site, I will flex my muscles in both areas and try to make collecting cards just a little bit more exciting and interactive for myself and anyone interested in taking that journey with me.</p>
    <Ad:MediumRectangleROS ID="medRect" runat="server" />
    <Nav:Footer ID="mainFooter" runat="server" />
</asp:Content>