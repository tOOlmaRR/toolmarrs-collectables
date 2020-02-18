<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ShopFooter.ascx.cs" Inherits="GeoTradingCards.Controls.ShopFooter" %>

<div class="footer">
	<hr />
	<asp:HyperLink ID="hlPurchasing" Text="How To Order" NavigateUrl="~/Shop/Ordering.aspx" runat="server" />
	&nbsp;|&nbsp;
	<asp:HyperLink ID="hlShipPolicy" Text="Shipping Policy" NavigateUrl="~/Shop/Shipping.aspx" runat="server" />
	&nbsp;|&nbsp;
	<asp:HyperLink ID="hlReturnPolicy" Text="Return Policy" NavigateUrl="~/Shop/Returns.aspx" runat="server" />
	&nbsp;|&nbsp;
	<asp:HyperLink ID="hlGrading" Text="Grading Guidelines" NavigateUrl="~/Shop/Grading.aspx" runat="server" />
</div>