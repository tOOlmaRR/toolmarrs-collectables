<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Links.aspx.cs" EnableViewState="false" Inherits="GeoTradingCards.Links" MasterPageFile="~/Main.Master" Title="Geo Trading Cards - Links" %>
<%@ Register TagPrefix="LeftMenu" TagName="Main" Src="~/Controls/LeftMenuMain.ascx" %>
<%@ Register TagPrefix="Ad" TagName="MediumRectangleROS" Src="~/Controls/Advertising/MedRectangleROS.ascx" %>
<%@ Register TagPrefix="Nav" TagName="Footer" Src="~/Controls/MainFooter.ascx" %>
<%@ MasterType VirtualPath="~/Main.Master" %>

<asp:Content ID="metaTags" ContentPlaceHolderID="metaTags" runat="server">
	<meta name="keywords" content="geo trading cards, george u marr enterprises, hockey cards, trading cards, hockey, collectables" />
	<meta name="description" content="Geo Trading Cards - Links to other websites that we like, or think that you'd like, including important resources for all card collectors." />
</asp:Content>

<asp:Content ID="leftMenuContent" ContentPlaceHolderID="cpleftMenu" runat="server">
	<LeftMenu:Main ID="leftMenuControl" runat="server" />
</asp:Content>

<asp:Content ID="mainContent" ContentPlaceHolderID="PageContent" runat="server">
    <h1>Links</h1>
    <p>The following are links to websites relevant to collecting trading cards. If you are interested in having a link to your site here, feel free to <asp:Hyperlink NavigateUrl="~/Contact.aspx" Text="contact us" runat="Server" />.</p>
    <p>Please note that we are in no way responsible for the activities of these third party websites and will not be held accountable for any issues you may encounter while you are there. In addition, we do not receive any compensation from the owners of these websites, except where stated. This section is simply an attempt to build the seeds of a small community of collectors and to compile a list of resources for all of us.</p>
    
    <ul>
		<li><a href="http://www.beckett.com" target="_blank" rel="noopener">beckett.com</a>: The center of the universe when it comes to collecting all types trading cards.</li>
		<li><a href="http://www.upperdeck.com" target="_blank" rel="noopener">upperdeck.com</a>: One of the most renowned card manufacturers in the world.</li>
		<li><a href="https://www.ebay.com/b/Sports-Trading-Cards-Accessories/212/bn_1859819" target="_blank" rel="noopener">ebay.com</a>: You may be surprised by just how many people and companies still sell cards and supplies through Ebay!</li>
        <li><a href="https://www.kijiji.ca/b-art-collectibles/ontario/hockey-cards/k0c12l9004" target="_blank" rel="noopener">kijiji</a>: A lot of people buy and sell through Kijiji.</li>
    </ul>
    
    <Ad:MediumRectangleROS ID="medRect" runat="server" />
    <Nav:Footer ID="mainFooter" runat="server" />
</asp:Content>