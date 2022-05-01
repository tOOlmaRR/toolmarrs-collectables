<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Ordering.aspx.cs" EnableViewState="false" Inherits="GeoTradingCards.Shop.Ordering" MasterPageFile="~/Main.Master" Title="Geo Trading Cards - The Ordering Process" %>
<%@ Register TagPrefix="Nav" TagName="LeftMenu" Src="~/Controls/LeftMenuMain.ascx" %>
<%@ Register TagPrefix="Ad" TagName="MediumRectangleROS" Src="~/Controls/Advertising/MedRectangleROS.ascx" %>
<%@ Register TagPrefix="Nav" TagName="Footer" Src="~/Controls/ShopFooter.ascx" %>
<%@ MasterType VirtualPath="~/Main.Master" %>

<asp:Content ID="metaTags" ContentPlaceHolderID="metaTags" runat="server">
	<meta name="keywords" content="geo trading cards, george u marr enterprises, hockey cards, trading cards, hockey, collectables" />
	<meta name="description" content="Geo Trading Cards - Simple instructions on how to order cards from us." />
</asp:Content>

<asp:Content ID="leftMenuContent" ContentPlaceHolderID="cpleftMenu" runat="server">
	<Nav:LeftMenu ID="leftMenuCtrl" runat="server" />
</asp:Content>

<asp:Content ID="mainContent" ContentPlaceHolderID="PageContent" runat="server">
	<h1>The Ordering Process</h1>
	<ol>
		<li><strong>Order</strong> : As you find items that you would like to purchase from us, simply note the ID numbers of the items you are interested in purchasing. ID numbers will be in the first column of all card listings available on this website. This is a quick way for us to identify and locate a particular card for you and our response times will be faster accordingly.</li>
		<li><strong>Confirmation and Payment</strong> : <asp:HyperLink Text="Send an email" NavigateUrl="~/Contact.aspx" runat="server" /> to us and include "order request" as the subject. Feel free to introduce yourself, and include the list of IDs that you made note of above. Expect a response from us within 1-3 days, during which time we will verify that we still have the items you have requested and that the descriptions for them are accurate. At that point, we will provide you with additional instructions. If we have the items that you have requested, the email will contain descriptions/details of all items in the order. If there is anything wrong with your order (for example, if any of the items are not what you intended), simply respond to the email with your issues and we will address them. Once you are happy with the details, respond to the email to confirm your order and we can arrange payment at that time. If you encounter difficulties with the payment process, we can work through it with you.</li>
		<li><strong>Shipping and Follow Up</strong> : Once we have received payment, the order will be considered complete and we will ship your order. Unless otherwise specified, we shall ship the order using our basic shipping service (see the <asp:Hyperlink Text="shipping policy page" NavigateUrl="~/Shop/Shipping.aspx" runat="server" /> for details). You may specifiy alternate shipping preferences via email during the purchase request, but please ensure that your invoice number (if we have sent you one) is available to us in those emails so that we can ensure that the instructions are associated to the correct purchase. When possible, we will follow up with you in order to ensure that the order was received and that you are happy with your investment.</li>
	</ol>
	<p>In the future, we may accept various forms of payment. If there is a particular form of payment you would like us to accept, feel free to contact us and we shall consider it going forward.</p>
	<p>We also plan to provide you with a basic order form here at some point in the future. This will save you time, standardize the ordering process, and speed things up on our end as well, allowing us to respond and complete your order faster.</p>
	<Ad:MediumRectangleROS ID="medRect" runat="server" />
	<Nav:Footer ID="shopFooter" runat="server" />
</asp:Content>