<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Hockey.aspx.cs" Inherits="GeoTradingCards.Shop.Hockey" EnableViewState="true" 
MasterPageFile="~/Main.Master" Title="Geo Trading Cards - Hockey Cards" %>
<%@ Register TagPrefix="Nav" TagName="LeftMenu" Src="~/Controls/LeftMenuMain.ascx" %>
<%@ Register TagPrefix="Ad" TagName="MediumRectangleROS" Src="~/Controls/Advertising/MedRectangleROS.ascx" %>
<%@ Register TagPrefix="Nav" TagName="Footer" Src="~/Controls/ShopFooter.ascx" %>
<%@ MasterType VirtualPath="~/Main.Master" %>

<asp:Content ID="metaTags" ContentPlaceHolderID="metaTags" runat="server">
	<meta name="keywords" content="geo trading cards, george u marr enterprises, hockey cards, trading cards, hockey, collectables" />
	<meta name="description" content="Geo Trading Cards Card Shop - Our online hockey card shop. By far the largest collection of trading cards we have to offer for sale or trade, numbering at well over 30,000!" />
</asp:Content>

<asp:Content ID="leftMenuContent" ContentPlaceHolderID="cpleftMenu" runat="server">
	<Nav:LeftMenu ID="leftMenuCtrl" runat="server" />
</asp:Content>

<asp:Content ID="mainContent" ContentPlaceHolderID="PageContent" runat="server">
	<h1 id="h1PageTitle" runat="server">Hockey Cards</h1>
	<asp:Panel ID="pnlBrowseHockey" class="browse" runat="server">
		<table cellpadding="0" cellspacing="0">
			<caption class="browseCaption">Browse Our Inventory</caption>
			<tr class="browseRow">
				<td class="browseLabel"><asp:Label ID="lbSeason" Text="Season: " runat="server" /></td>
				<td class="browseSelection">
					<asp:DropDownList ID="ddlSeason" AutoPostBack="true" Font-Size="12pt" Width="250px" runat="server"
					OnSelectedIndexChanged="ddlSeason_SelectedIndexChanged" />
				</td>
			</tr>
			<tr class="browseRow">
				<td class="browseLabel"><asp:Label ID="lbCardSet" Text="Card Set: " runat="server" /></td>
				<td class="browseSelection">
					<asp:DropDownList ID="ddlCardSet" Font-Size="12pt" Enabled="false" Width="250px" runat="server" />
				</td>
			</tr>
			<tr id="trErrorRow" runat="server" visible="false">
				<td colspan="2" class="error" >Don't forget to select both a season and a set from the drodown boxes above...</td>
			</tr>
			<tr class="browseBtnRow">
				<td colspan="2" style="padding-right: 9px;">
					<asp:Button ID="btnBrowse" CssClass="btnBrowse" Text="GO!" OnClick="btnBrowse_OnClick" runat="server" />
				</td>
			</tr>
		</table>
	</asp:Panel>
	<asp:Panel ID="pnlPreamble" runat="server">
		<p>By far, hockey is our specialty. We have a large assortment of cards from the 1990-91 season up to the most recent releases, but we also have some vintage cards, though not very numerous, from seasons prior to 1990-91. Going forward, we would like to expand into other sports and non-sports cards, but for now, we concentrate on hockey cards.</p>
		<p>Begin by selecting a season from the drop-down box to the right. From there, you will be able to navigate to individual sets that we have electronic inventory listings for. Expect to see new sets listed rather frequently.</p>
		<p>Remember, not everything we own may be published here due to the sheer number of cards in our inventory, so if you do not see it here, it doesn't necessarily mean that we do not have that item available. Feel free to <asp:Hyperlink NavigateUrl="~/contact.aspx" Text="contact us" runat="server" /> at any time.</p>
	</asp:Panel>
	<br clear="all" />

	<Ad:MediumRectangleROS ID="medRect" runat="server" />
	<Nav:Footer ID="shopFooter" runat="server" />
</asp:Content>