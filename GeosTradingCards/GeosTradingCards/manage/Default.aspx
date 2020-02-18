<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" EnableViewState="false" Inherits="GeoTradingCards.manage.Default" MasterPageFile="~/Main.Master" %>

<%@ Register TagPrefix="LeftMenu" TagName="Main" Src="~/Controls/LeftMenuMain.ascx" %>
<%@ Register TagPrefix="Ad" TagName="MediumRectangleROS" Src="~/Controls/Advertising/MedRectangleROS.ascx" %>
<%@ Register TagPrefix="Nav" TagName="Footer" Src="~/Controls/AdminFooter.ascx" %>
<%@ MasterType VirtualPath="~/Main.Master" %>

<asp:Content ID="metaTags" ContentPlaceHolderID="metaTags" runat="server">
	<meta name="ROBOTS" content="NOINDEX, NOFOLLOW" />
</asp:Content>

<asp:Content ID="leftMenuContent" ContentPlaceHolderID="cpleftMenu" runat="server">
	<LeftMenu:Main ID="leftMenuControl" runat="server" />
</asp:Content>

<asp:Content ID="mainContent" ContentPlaceHolderID="PageContent" runat="server">
	<h1>Website Management Tools</h1>
	<div class="admin">
		<ul>
		<li><asp:HyperLink ID="hlGoogleDocsAdmin" NavigateUrl="~/manage/GoogleDocsAdmin.aspx" Text="Google Docs Admin Tool" runat="server" /></li>
		</ul>
	</div>
</asp:Content>
