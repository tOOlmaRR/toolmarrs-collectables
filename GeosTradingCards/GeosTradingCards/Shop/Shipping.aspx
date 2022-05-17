<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Shipping.aspx.cs" EnableViewState="false" Inherits="GeoTradingCards.Shop.Shipping" MasterPageFile="~/Main.Master" Title="Geo Trading Cards - Shipping Policy" %>
<%@ Register TagPrefix="Nav" TagName="LeftMenu" Src="~/Controls/LeftMenuMain.ascx" %>
<%@ Register TagPrefix="Ad" TagName="MediumRectangleROS" Src="~/Controls/Advertising/MedRectangleROS.ascx" %>
<%@ Register TagPrefix="Nav" TagName="Footer" Src="~/Controls/ShopFooter.ascx" %>
<%@ MasterType VirtualPath="~/Main.Master" %>

<asp:Content ID="metaTags" ContentPlaceHolderID="metaTags" runat="server">
	<meta name="keywords" content="geo trading cards, george u marr enterprises, hockey cards, trading cards, hockey, collectables" />
	<meta name="description" content="Geo Trading Cards - Our shipping policy, including what shipping options we offer, where we are willing to ship to, how much it'll cost you, and what kind of packaging you should expect your order to be shipped in." />
</asp:Content>

<asp:Content ID="leftMenuContent" ContentPlaceHolderID="cpleftMenu" runat="server">
	<Nav:LeftMenu ID="leftMenuCtrl" runat="server" />
</asp:Content>

<asp:Content ID="mainContent" ContentPlaceHolderID="PageContent" runat="server">
	<h1>Shipping Policy</h1>
	<p>Once payment has been received, we will ship your order. Normally, all cards will be shipped in standard sleeves. If only a small number of items have been ordered, they will usually be shipped in top loaders as well. Whenever possible, items will be shipped in padded or bubble envelopes. For a larger number of items, a standard size card box may be used along with appropriate packing materials to prevent movement during shipping and handling.</p>
	<p>For now, <strong>we only sell and ship to Canada</strong>. We have plans to expand to the United States in the near future and may do so sooner if there is a lot of demand (please let us know if you are outside of Canada and wish to place an order). Feel free to <asp:Hyperlink NavigateUrl="~/Contact.aspx" Text="contact us" runat="server" /> if you have any additional questions that are not answered here.</p>
	<table id="shippingTable" border="1" cellpadding="2px" cellspacing="0" rules="all">
		<caption>Standard Shipping Costs</caption>
		<tr>
			<th class="postageServiceHeader" scope="col">Postage Service</th>
			<th class="cardQuantityHeader" scope="col">Quantity</th>
			<th class="postageChargeHeader" scope="col">Charge</th>
		</tr>
		<tr>
			<td>Canada Post Lettermail</td>
			<td>1-25 (up to 50g weight)</td>
			<td class="postageCharge">$1.50</td>
		</tr>
		<tr>
			<td>Canada Post Lettermail</td>
			<td>26-50 (up to 100g weight)</td>
			<td class="postageCharge">$2.00</td>
		</tr>
		<tr>
			<td>Canada Post Lettermail</td>
			<td>50-100 (up to 200g weight)</td>
			<td class="postageCharge">$3.00</td>
		</tr>
	</table>
	
	<p>We can also deliver items through Xpresspost and Priority Next A.M. if desired. Please request this either when placing, confirming, or paying for your order. Any larger orders will be dealt with on a case-bay-case basis (the charge will often be dependent upon the weight) and will normally be discounted to some extent.</p>

	<Ad:MediumRectangleROS ID="medRect" runat="server" />
	<Nav:Footer ID="shopFooter" runat="server" />
</asp:Content>