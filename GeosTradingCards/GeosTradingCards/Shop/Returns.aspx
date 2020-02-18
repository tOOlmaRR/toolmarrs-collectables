<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Returns.aspx.cs" EnableViewState="false" Inherits="GeoTradingCards.Shop.Returns" MasterPageFile="~/Main.Master" Title="Geo Trading Cards - Return Policy" %>
<%@ Register TagPrefix="Nav" TagName="LeftMenu" Src="~/Controls/LeftMenuMain.ascx" %>
<%@ Register TagPrefix="Ad" TagName="MediumRectangleROS" Src="~/Controls/Advertising/MedRectangleROS.ascx" %>
<%@ Register TagPrefix="Nav" TagName="Footer" Src="~/Controls/ShopFooter.ascx" %>
<%@ MasterType VirtualPath="~/Main.Master" %>

<asp:Content ID="metaTags" ContentPlaceHolderID="metaTags" runat="server">
	<meta name="keywords" content="geo trading cards, george u marr enterprises, hockey cards, trading cards, hockey, collectables" />
	<meta name="description" content="Geo Trading Cards - An explanation our return policy including under want circumstances we accept or do not accept returns, and what procedures to follow when requesting a return." />
</asp:Content>

<asp:Content ID="leftMenuContent" ContentPlaceHolderID="cpleftMenu" runat="server">
	<Nav:LeftMenu ID="leftMenuCtrl" runat="server" />
</asp:Content>

<asp:Content ID="mainContent" ContentPlaceHolderID="PageContent" runat="server">
	<h1>Return Policy</h1>
	<p>Due to the nature of this industry, we must be cautious with our return policy. We will accept returns for some reasons, but these reasons must be well defined and <strong>we must be notified of these reasons before authorizing the return</strong>. Postage and handling will be reimbursed as per our standard shipping fees.</p>
	<h3>Valid Returns</h3>
	<ol>
		<li>Incorrect Items<br />
			<p>If any of the items that were ordered are not the correct items, you may return the incorrect items and we will gladly ship you the correct items. You may also return the entire order and request a full refund.</p>
		</li>
		<li>Incorrect Condition or Grading of Item(s)<br />
			<p>If the actual condition of one or more cards in the order are significantly different from that advertised, you may request a return. Since card grading is fairly subjective, the difference must be significant and demonstrated. We have published some general guidelines for evaluating the condition of cards on the <asp:Hyperlink ID="hlGrading" Text="card grading page" NavigateUrl="~/Shop/Grading.aspx" runat="server" />.</p>
		</li>
	</ol>
	<h3>Invalid Return Requests</h3>
	<ol>
		<li>"I no longer want these cards"<br />
			<p>We will not accept the return of any items for the simple reason that you no longer want the item. There are several reasons for this policy.</p>
			<p>The main reason for this is to prevent situations where a card has decreased in perceived value since the purchase and may be purchased for a cheaper price. Since trading cards can be a volatile market, perceived value of cards can vary significantly over time and even within certain geographic areas. Sometimes values change abruptly enough that the perceived value of the card is different between the time you order a card and when you receive it. This is the nature of collectables and a risk that we all take, and by freely accepting returns without a good reason does not make sense.</p>
			<p>If you believe a price does not reflect the item's current perceived value, you are free to make us a fair offer, which we may accept or reject for any reason. Once a sale has been made however, the prices are no longer negotiable and the order cannot be returned without a good reason.</p>
		</li>
		<li>"I ordered the wrong item"
			<p>If you have ordered the wrong item by accident, we sympathize with you (I'm sure at least one of us has done this at some point), but we cannot accept a return on this basis. You have several opportunities to ensure that the items you have ordered are indeed the ones you want. Please do not send a payment (and thus committ yourself to the order) until you are confident that the items in your order are indeed the ones you wish to purchase. If you are not clear on exactly what an item is (ie. what set it belongs to, what it looks like, etc.), please do your research and feel free to <asp:HyperLink NavigateUrl="~/contact.aspx" Text="contact us" runat="server" /> with a request for more details. We'd be happy to assist you!</p>
		</li>
	</ol>
	<Ad:MediumRectangleROS ID="medRect" runat="server" />
	<Nav:Footer ID="shopFooter" runat="server" />
</asp:Content>