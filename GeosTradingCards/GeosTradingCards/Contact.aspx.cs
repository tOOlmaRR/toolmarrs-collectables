using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GeoTradingCards.Controls;

namespace GeoTradingCards
{
	public partial class Contact : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			try
			{
				Breadcrumbs ucBreadcrumbs = (Breadcrumbs)this.Master.FindControl("ucBreadcrumbs");
				if (ucBreadcrumbs != null)
				{
					ucBreadcrumbs.BreadcrumbCollection.Add(new Breadcrumbs.Breadcrumb("Contact Us", "~/Contact.aspx"));
				}
			}
			catch (Exception ex)
			{
				DAL.ExceptionManager.LogException(ex);
			}
		}
	}
}