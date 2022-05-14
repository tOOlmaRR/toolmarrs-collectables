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
    <p>Please send us an email to the appropriate address below depending on the nature of your request. If necessary or desired, other means of contact may be discussed at that point.</p>
    <ul>
		<li>Purchase Requests and Discussions:
			<asp:Hyperlink Text="toolmarr+sales@gmail.com" NavigateUrl="mailto:toolmarr+sales@gmail.com" runat="server" />
		</li>
		<li>Trading Discussions:
			<asp:Hyperlink Text="toolmarr+trade@gmail.com" NavigateUrl="mailto:toolmarr+trade@gmail.com" runat="server" />
		</li>
		<li>Return Requests:
			<asp:Hyperlink Text="toolmarr+returns@gmail.com" NavigateUrl="mailto:toolmarr+returns@gmail.com" runat="server" />
		</li>
		<li>Anything Else:
			<asp:Hyperlink Text="toolmarr+general@gmail.com" NavigateUrl="mailto:toolmarr+general@gmail.com" runat="server" />
		</li>
    </ul>
    <p>In the future, we plan to build a request form and shopping cart system through which you can order items from our online store.</p>
    <Ad:MediumRectangleROS ID="medRect" runat="server" />
    <Nav:Footer ID="mainFooter" runat="server" />
</asp:Content>