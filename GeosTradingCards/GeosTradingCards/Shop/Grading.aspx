<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Grading.aspx.cs" EnableViewState="false" Inherits="GeoTradingCards.Shop.Grading" MasterPageFile="~/Main.Master" Title="Geo Trading Cards - Card Grading Guidelines" %>
<%@ Register TagPrefix="Nav" TagName="LeftMenu" Src="~/Controls/LeftMenuMain.ascx" %>
<%@ Register TagPrefix="Ad" TagName="MediumRectangleROS" Src="~/Controls/Advertising/MedRectangleROS.ascx" %>
<%@ Register TagPrefix="Nav" TagName="Footer" Src="~/Controls/ShopFooter.ascx" %>
<%@ MasterType VirtualPath="~/Main.Master" %>

<asp:Content ID="metaTags" ContentPlaceHolderID="metaTags" runat="server">
	<meta name="keywords" content="geo trading cards, george u marr enterprises, hockey cards, trading cards, hockey, collectables" />
	<meta name="description" content="Geo Trading Cards - A detailed examination of the guidelines we use to grade cards and how prices are typically adjusted accordingly." />
</asp:Content>

<asp:Content ID="leftMenuContent" ContentPlaceHolderID="cpleftMenu" runat="server">
	<Nav:LeftMenu ID="leftMenuCtrl" runat="server" />
</asp:Content>

<asp:Content ID="mainContent" ContentPlaceHolderID="PageContent" runat="server">
	<h1>Card Grading Guildlines</h1>
	<p>"Grading", or evaluating the condition of a card, is somewhat subjective. There are generally accepted guidelines, but everyone seems to use their own guidelines and classifications. Since Beckett is the center of the card collecting universe, what they say is generally accepted, but if you use Upper Deck's collection management features, they use slightly different classes for grading a card (Pristine, Mint, NearMint etc.) than the same features on Beckett's website (Mint, NRMT-MT, NRMT, etc.).</p>
	<p>We generally follow Beckett's grading system, but we are admittedly a little more lax on our grading. The following table summarizes the criteria by which we grade our cards. Also keep in mind that it is a <strong>very</strong> time consuming process to grade thousands of cards, and so most commons, semi-star, and even unlisted star cards have not been graded. You can be fairly confident that these cards are in near-mint condition or better, and we will always perform a full evaluation during the ordering process and provide you with those details.</p>
	<p>In the table to follow, the "value modification" column indicates the approximate adjustment we make to the sell price of a card given it's condition.</p>
	<table id="gradingTable" border="1" cellpadding="2px" cellspacing="0" rules="all">
		<tr>
			<th width="16%">Grade</th>
			<th width="64%">Description</th>
			<th width="20%">Value Modification</th>
		</tr>
		<tr>
			<td class="className">Pristine<br />(PR)</td>
			<td>This is the very top grading class possible. This grading is generally used in cases where a card has been very closely examined and, as far as we can tell, the card has no flaws or damage whatsoever. At the time of writing this, we are currently not using this class, but plan to use it in exceptional cases where we have very closely examined a card and it is found to be flawless.</td>
			<td align="center">125%+</td>
		</tr>
		<tr>
			<td class="className">Mint<br />(MINT)</td>
			<td>This grading class is used to indicate that the card has been examined and that no significant flaws or damage could be found. The difference between Mint and Pristine is that the card may not have been as meticulously examined, or a very minor flaw such as a barely detectable nick in a corner, a subtle printing flaw, or a small drop of gloss was found, but wasn't immediately obvious.</td>
			<td align="center">100-110%+</td>
		</tr>
		<tr>
			<td class="className">Near-Mint/Mint+<br />(NRMT-MT+)</td>
			<td>This is our default grading. Any cards that have not been graded will be classified as NRMT-MT+. When grading cards, this class will be used to indicate a single minor flaw that is not immediately evident. Often this class will be used in situations where the "flaw" was clearly there when the card came from it's original packaging, such as minor surface scratches or lines, or foil stamping which is slightly malformed and where it is not supposed to be. If this/these flaws are very noticable or significantly worse than normal, the card will often be graded NRMT-MT or worse, depending on the severity.</td>
			<td align="center">90-100%</td>
		</tr>
		<tr>
			<td class="className">Near-Mint/Mint (NRMT-MT)</td>
			<td>Generally, several barely noticable flaws will cause a card to be classified as NRMT-MT. An example of this is a card that has a couple of corners on the front and/or back that appear to be nicked, but only if tilted at a certain angle. If there are many of these, or if one or more of these is fairly pronounced (such as obvious centering problems, a damaged corner, wear on a card edge, etc.), the grade will be pushed below NRMT-MT. Also note here that this class used to be the default class given to common cards and those that have not been graded, and thus some cards (expecially those with IDs under 500) that are classified as NRMT-MT may in fact be NRMT-MT+.</td>
			<td align="center">75-100%</td>
		</tr>
		<tr>
			<td class="className">Near-Mint<br />(NRMT)</td>
			<td>Generally, as soon as an obvious flaw or evident damage is detected, unless everything else about the card is perfect, the card is classified as NRMT or worse. An example of this is a card that has a corner that has obviously been damaged (it is immediately evident when you look at the card). Another example is a card who's corners have all been slightly nicked, but most can only be seen upon close observation.</td>
			<td align="center">50-75%</td>
		</tr>
		<tr>
			<td class="className">Excellent/Mint<br />(EX-MT)</td>
			<td>Cards in this grading class have obvious damage or flaws. A single corner with significant damage may cause a grade of EX-MT, but more often than not an EX-MT grading results from a combination of obvious flaws or damage. Several obviously damaged corners, or one damaged corner with several printing flaws or off-centering are examples of EX-MT.</td>
			<td align="center">25%-50%</td>
		</tr>
		<tr>
			<td class="className">Excellent<br />(EX)</td>
			<td>In most cases, more than one flaw or point-of-damage is required to classify a card as EX or below, but a single corner that has been badly damaged may push a card's grading down to EX or worse. An example is a card with many nicked corners with some minor printing flaws (print lines across the front) and a worn edge. Unless something really stands out, most badly damaged cards will be graded as EX.</td>
			<td align="center">25%-50%</td>
		</tr>
		<tr>
			<td class="className">Very-Good<br />(VG)</td>
			<td>If any of the corners have been bent to the point that some layering is evident, normally that card will not be graded better than VG. This class will also be given to a card that has a significant number of minor to moderate flaws or points of damage. A minor crease in a card may also be classified as VG, but only if the card is otherwise in decent shape.</td>
			<td align="center">10%-25%</td>
		</tr>
	</table>
	
	<p>For the most part, we will not use a grade under VG since any card damaged enough to warrant using a grade of GOOD, FAIR or POOR isn't usually worth keeping around. A badly damaged rookie card or star may be kept around. We have also graded a few cards that have one corner with some nasty damage. They were pulled from a box of 2008-09 Trilogy hockey that somehow made it through Upper Deck's quality assurance team. These cards were almost perfect with the exception of that one corner, and since they are in a premium set, we decided to keep them, grade them low, but be a little generous in the price adjustment. In general however, the value of these cards will be under 25%.</p>
	
	<Ad:MediumRectangleROS ID="medRect" runat="server" />
	<Nav:Footer ID="shopFooter" runat="server" />
</asp:Content>