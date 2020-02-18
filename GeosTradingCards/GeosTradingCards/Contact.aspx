<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" EnableViewState="false" Inherits="GeoTradingCards.Contact" MasterPageFile="~/Main.Master" Title="Geo Trading Cards - Contact Us" %>
<%@ Register TagPrefix="LeftMenu" TagName="Main" Src="~/Controls/LeftMenuMain.ascx" %>
<%@ Register TagPrefix="Ad" TagName="MediumRectangleROS" Src="~/Controls/Advertising/MedRectangleROS.ascx" %>
<%@ Register TagPrefix="Nav" TagName="Footer" Src="~/Controls/MainFooter.ascx" %>
<%@ MasterType VirtualPath="~/Main.Master" %>

<asp:Content ID="metaTags" ContentPlaceHolderID="metaTags" runat="server">
	<meta name="keywords" content="geo trading cards, george u marr enterprises, hockey cards, trading cards, hockey, collectables" />
	<meta name="description" content="Geo Trading Cards - Ways to get in touch with us, be it ordering items from our inventory, asking us questions about the website, or just about anything else." />
</asp:Content>

<asp:Content ID="leftMenuContent" ContentPlaceHolderID="cpleftMenu" runat="server">
	<LeftMenu:Main ID="leftMenuControl" runat="server" />
</asp:Content>

<asp:Content ID="mainContent" ContentPlaceHolderID="PageContent" runat="server">
    <h1>Contact Us</h1>
    <p>We may be contacted through several means. Please send us an email to the appropriate address below, depending on the nature of your email. If necessary or desired, other means of contact (egs. phone, Msn/Live Messenger) may be provided.</p>
    <ul>
		<li>To place or follow up on an order:
			<asp:Hyperlink Text="sales@geotradingcards.com" NavigateUrl="mailto:sales@geotradingcards.com" runat="server" />
		</li>
		<li>To request a return:
			<asp:Hyperlink Text="returns@geotradingcards.com" NavigateUrl="mailto:returns@geotradingcards.com" runat="server" />
		</li>
		<li>Anything else:
			<asp:Hyperlink Text="support@geotradingcards.com" NavigateUrl="mailto:support@geotradingcards.com" runat="server" />
		</li>
    </ul>
    <p>In the near future, we plan to build a request form and shopping cart system through which you can more easily order items from our online store.</p>
    <Ad:MediumRectangleROS ID="medRect" runat="server" />
    <Nav:Footer ID="mainFooter" runat="server" />
</asp:Content>