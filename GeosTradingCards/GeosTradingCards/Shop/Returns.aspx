<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Returns.aspx.cs" EnableViewState="false" Inherits="GeoTradingCards.Shop.Returns" MasterPageFile="~/Main.Master" Title="Geo Trading Cards - Return Policy" %>
<%@ Register TagPrefix="Nav" TagName="LeftMenu" Src="~/Controls/LeftMenuMain.ascx" %>
<%@ Register TagPrefix="Ad" TagName="MediumRectangleROS" Src="~/Controls/Advertising/MedRectangleROS.ascx" %>
<%@ Register TagPrefix="Nav" TagName="Footer" Src="~/Controls/ShopFooter.ascx" %>
<%@ MasterType VirtualPath="~/Main.Master" %>

<asp:Content ID="metaTags" ContentPlaceHolderID="metaTags" runat="server">
	<meta name="keywords" content="geo trading cards, george u marr enterprises, hockey cards, trading cards, hockey, collectables" />
	<meta name="description" content="Geo Trading Cards  Card Shop - An explanation of our return policy including under want circumstances we accept or do not accept returns, and what procedures to follow when requesting a return." />
</asp:Content>

<asp:Content ID="leftMenuContent" ContentPlaceHolderID="cpleftMenu" runat="server">
	<Nav:LeftMenu ID="leftMenuCtrl" runat="server" />
</asp:Content>

<asp:Content ID="mainContent" ContentPlaceHolderID="PageContent" runat="server">
	<h1>Return Policy</h1>
	<p>Due to the nature of this industry, we must be cautious with our return policy. We will accept returns for some legitimate reasons, but these reasons must be well-defined and we must be notified of, and accept, these reasons before authorizing the return.</p>
		<p><strong>Do not return anything without having the return authorized first!</strong></p>
		<p><strong>Do not expect a refund, exchange, or any reimbursement if you do not receive authorization from us first!</strong></p>

	<h3>Invalid Return Requests</h3>
	<ol>
		<li>"I no longer want these cards"<br />
			<p>We will not accept the return of any items for the simple reason that you no longer want it/them. There are several reasons for this policy.</p>
			<p>The main reason for this is to prevent situations where a card has decreased in perceived value since the purchase. Since collectables, and trading cards in particular, can be a volatile market, perceived value can vary significantly over time and even within certain geographic areas. Sometimes values change abruptly enough that the perceived value of the card is different between the time you order a card and when you receive it. This is the nature of collectables and a risk that we all take, and freely accepting returns without a good reason does not make sense.</p>
			<p>If you believe a price does not reflect the item's current perceived value, you are free to make us a fair offer when placing your order, which we may accept or reject for any reason. Once we have received payment however, the prices are no longer negotiable and the order cannot be returned without a valid reason.</p>
		</li>
		<li>"I have ordered the wrong item"
			<p>If you have ordered any wrong items by accident, we sympathize with you. I'm sure at least one of us has done this at some point in the past. However, we cannot accept a return on this basis. You have several opportunities to ensure that the items you have ordered are correct. Please do not send a payment (and thus commit yourself to the purchase) until you are confident that the items in your order are indeed the ones you wish to purchase. If you are not clear on exactly what an item is (ie. what set it belongs to, what it looks like, etc.), please do your research and feel free to <asp:HyperLink NavigateUrl="~/contact.aspx" Text="contact us" runat="server" /> with a request for more details. We'd be happy to assist you!</p>
		</li>
	</ol>

	<h3>Valid Return Requests</h3>
	<ol>
		<li>Incorrect Items<br />
			<p>If you receive your purchase and any of the items are not the correct items (ie. they do not match the description provided in the order details and/or the invoice that you agreed to), we apologize for the error and present you with a few options:</p>
			<ol>
				<li>an exchange for the correct item(s).</li>
				<li>a refund of the item(s) in question, upon their return.</li>
				<li>a refund of your entire purchase, upon its return.</li>
			</ol>
			<p>Please see details of these options below.</p>
		</li>
		<li>Incorrect Condition or Grading of Item(s)<br />
			<p>If the actual condition of one or more cards in your order is significantly different from what was provided in the order details or invoice that you agreed to, you may have a few options:</p>
			<ol>
				<li>a partial refund of the item in question.</li>
				<li>a refund of the item(s) in question upon their return.</li>				
				<li>a refund of your entire purchase upon its return.</li>
			</ol>
			<p>Since card grading is fairly subjective, the difference must be significant and demonstrated. We have published some general guidelines for evaluating the condition of cards on the <asp:Hyperlink ID="hlGrading" Text="card grading page" NavigateUrl="~/Shop/Grading.aspx" runat="server" />.</p>
		</li>
	</ol>

	<h3>Returns, Refunds, and Reimbursements</h3>
	<ol>
		<li>Exchanges<br />
			<p>In cases where you need to return an incorrect item and we need to send you the correct item, we will typically reimburse you for the cost of shipping the original item(s) back to us based on our standard shipping fees, and we will not charge you for the cost of shipping you the correct item(s).</p>
		</li>
		<li>Partial Refunds<br />
			<p>Typically these only apply to situations where a card's condition is significantly different from the details provided to you in the order details or invoice at the time of purchase. The difference must be significant and demonstrated. In this case, we may propose a partial reimbursement for this item and not require any return shipment. If you disagree to the proposal, you may always request a full refund for the item or your entire order upon its return.</p>
		</li>
		<li>Full Refunds<br />
			<p>In cases where you wish to return certain items or your entire order for a refund, once approved/authorized, we will refund the original purchase cost of the items. In additional we will typically refund the original shipping cost, and the cost for you to return the items to us, but only at our standard shipping rates.</p>
		</li>
	</ol>
	<p>Please note that reimbursement of shipping costs is always at our discretion.</p>

	<Ad:MediumRectangleROS ID="medRect" runat="server" />
	<Nav:Footer ID="shopFooter" runat="server" />
</asp:Content>