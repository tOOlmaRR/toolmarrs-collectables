using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GeoTradingCards.Controls;

namespace GeoTradingCards.Shop
{
	public partial class Shop : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			try
			{
				Breadcrumbs ucBreadcrumbs = (Breadcrumbs)this.Master.FindControl("ucBreadcrumbs");
				if (ucBreadcrumbs != null)
				{
					ucBreadcrumbs.BreadcrumbCollection.Add(new Breadcrumbs.Breadcrumb("The Card Shop", "~/Shop/shop.aspx"));
				}
			}
			catch (Exception ex)
			{
				DAL.ExceptionManager.LogException(ex);
			}
		}
	}
}