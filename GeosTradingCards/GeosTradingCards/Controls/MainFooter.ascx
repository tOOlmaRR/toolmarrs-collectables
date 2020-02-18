<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MainFooter.ascx.cs" EnableViewState="false" Inherits="GeoTradingCards.Controls.MainFooter" %>

<div class="footer">
	<hr />
	<asp:HyperLink ID="hlShop" Text="The Card Shop" NavigateUrl="~/Shop/Shop.aspx" runat="server" />
	&nbsp;|&nbsp;
	<asp:HyperLink ID="hlAbout" Text="About Us" NavigateUrl="~/About.aspx" runat="server" />
	&nbsp;|&nbsp;
	<asp:HyperLink ID="hlContact" Text="Contact Us" NavigateUrl="~/Contact.aspx" runat="server" />
	&nbsp;|&nbsp;
	<asp:HyperLink ID="hlLinks" Text="Useful Links" NavigateUrl="~/Links.aspx" runat="server" />
	&nbsp;|&nbsp;
	<asp:HyperLink ID="hlSitemap" Text="Sitemap" NavigateUrl="~/Sitemap.aspx" runat="server" />
</div>