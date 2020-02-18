<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Ordering.aspx.cs" EnableViewState="false" Inherits="GeoTradingCards.Shop.Ordering" MasterPageFile="~/Main.Master" Title="Geo Trading Cards - The Ordering Process" %>
<%@ Register TagPrefix="Nav" TagName="LeftMenu" Src="~/Controls/LeftMenuMain.ascx" %>
<%@ Register TagPrefix="Ad" TagName="MediumRectangleROS" Src="~/Controls/Advertising/MedRectangleROS.ascx" %>
<%@ Register TagPrefix="Nav" TagName="Footer" Src="~/Controls/ShopFooter.ascx" %>
<%@ MasterType VirtualPath="~/Main.Master" %>

<asp:Content ID="metaTags" ContentPlaceHolderID="metaTags" runat="server">
	<meta name="keywords" content="geo trading cards, george u marr enterprises, hockey cards, trading cards, hockey, collectables" />
	<meta name="description" content="Geo Trading Cards - Simple instructions on how to order cards from us. We accept payments through PayPal which means you can pay using major credit cards, a personal bank account, or through a PayPal account." />
</asp:Content>

<asp:Content ID="leftMenuContent" ContentPlaceHolderID="cpleftMenu" runat="server">
	<Nav:LeftMenu ID="leftMenuCtrl" runat="server" />
</asp:Content>

<asp:Content ID="mainContent" ContentPlaceHolderID="PageContent" runat="server">
	<h1>The Ordering Process</h1>

	<div class="floatingPayPal">
		<!-- PayPal Logo --><a href="#" onclick="javascript:window.open('https://www.paypal.com/cgi-bin/webscr?cmd=xpt/Marketing/popup/OLCWhatIsPayPal-outside','olcwhatispaypal','toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=yes, resizable=yes, width=400, height=350');"><img src="https://www.paypal.com/en_US/i/bnr/vertical_solution_PPeCheck.gif" border="0" alt="Solution Graphics" /></a><!-- PayPal Logo -->
	</div>
	<p>Unless you haven't guessed by now, we use Paypal as a convenient way for you to pay for your order. Through Paypal, you can use your own PayPal account, a major credit card, or even your own bank account to pay for your order. In addition, it is not necessary for you to set up a PayPal account to pay for your order. However, we do not, as of yet, have an electronic shopping cart system set up. So, in the meatime, we will try to make the ordering process as easy as possible. Please follow the instructions below:</p>
	<ol>
		<li><strong>Order</strong> : As you find items that you would like to purchase from us, simply write the ID numbers down some place. ID numbers will be in the first column of all card listings available on this website and is a quick way for us to identify and locate a particular card.</li>
		<li><strong>Confirmation and Payment</strong> : Send an email to <asp:HyperLink Text="sales@geotradingcards.com" NavigateUrl="mailto:sales@geotradingcards.com" runat="server" /> with "order request" as the subject. Expect a response from us within 1-3 days, during which time we will verify that we still have the items you have requested and that the description for them is accurate. At that point, we will provide you with additional instructions via email. If we have the items you have requested, the email will contain an invoice with descriptions of all item(s) in your order and a link that will enable you to pay for your order using PayPal. If there is anything wrong with your order (for example, any items are not what you wanted), simply respond to the email with your issues. If you encounter difficulties with the payment process, please let us know and we will work through them with you.</li>
		<li><strong>Shipping and Follow Up</strong> : Once we have received payment (through PayPal, this is virtually instantaneous), the order will be considered complete and we will ship your order. Unless otherwise specified, we shall ship the order using our basic shipping service (see the <asp:Hyperlink Text="shipping policy page" NavigateUrl="~/Shop/Shipping.aspx" runat="server" /> for details). Through Paypal, you will be given the ability to provide additional instructions to the seller. You may specifiy alternate shipping preferences there. You can also send your request to us through email, but please ensure that your invoice number (if we have sent you one) is available to us. When possible, we will follow up with you in order to ensure that the order was received and that you are happy with your investment.</li>
	</ol>
	<p>In the future, we may accept alternate forms of payment. If there is a particular form of payment you would like us to accept, feel free to send us an email and we shall consider it going forward.</p>
	<p>We also plan to provide you with a basic order form here at some point in the future. It will essentially save you a little time and somewhat standardize the ordering process.</p>
	<Ad:MediumRectangleROS ID="medRect" runat="server" />
	<Nav:Footer ID="shopFooter" runat="server" />
</asp:Content>