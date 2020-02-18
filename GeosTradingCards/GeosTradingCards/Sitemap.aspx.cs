using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GeoTradingCards.Controls;

namespace GeoTradingCards
{
	public partial class Sitemap : System.Web.UI.Page
	{
		protected override void OnLoad(EventArgs e)
		{
			try
			{
				base.OnLoad(e);

				// Set Breadcrumbs
				Breadcrumbs ucBreadcrumbs = (Breadcrumbs)this.Master.FindControl("ucBreadcrumbs");
				if (ucBreadcrumbs != null)
				{
					ucBreadcrumbs.BreadcrumbCollection.Add(new Breadcrumbs.Breadcrumb("Sitemap", "~/Sitemap.aspx"));
				}
			}
			catch (Exception ex)
			{
				DAL.ExceptionManager.LogException(ex);
			}
		}
	}
}