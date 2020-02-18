using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GeoTradingCards.Controls
{
	public partial class Breadcrumbs : System.Web.UI.UserControl
	{
		#region Page Life Cycle
		protected override void OnInit(EventArgs e)
		{
			base.OnInit(e);
			// if the breadcrumb separator hasn't been explicitly set, set it to " > "
			if (string.IsNullOrEmpty(_crumbSeparator))
				_crumbSeparator = " > ";

			// for now, always include a breadcrumb for the homepage
			_breadcrumbCollection = new List<Breadcrumb>();
			Breadcrumb homeCrumb = new Breadcrumb("Geo's Trading Cards", "~/default.aspx");
			this.BreadcrumbCollection.Add(homeCrumb);
		}

		protected override void OnLoad(EventArgs e)
		{
			base.OnLoad(e);
			int crumbCount = _breadcrumbCollection.Count;
			foreach (Breadcrumb crumb in _breadcrumbCollection)
			{
				HyperLink hl = new HyperLink();
				hl.Text = crumb.Text;
				hl.NavigateUrl = crumb.Link;
				pnlBreadcrumbs.Controls.Add(hl);

				crumbCount--;
				if (crumbCount > 0)
				{
					Literal litSeparator = new Literal();
					litSeparator.Text = _crumbSeparator;
					pnlBreadcrumbs.Controls.Add(litSeparator);
				}
			}
		}
		#endregion

		#region Classes
		public class Breadcrumb
		{
			private string _text;
			public string Text
			{
				get { return _text; }
				set { _text = value; }
			}
			
			private string _link;
			public string Link
			{
				get { return _link; }
				set { _link = value; }
			}

			public Breadcrumb(string text, string link)
			{
				_text = text;
				_link = link;
			}
		}
		#endregion

		#region Public Properties
		private List<Breadcrumb> _breadcrumbCollection;
		public List<Breadcrumb> BreadcrumbCollection
		{
			get { return _breadcrumbCollection; }
			set { _breadcrumbCollection = value; }
		}

		private string _crumbSeparator;
		public string CrumbSeparator
		{
			get { return _crumbSeparator; }
			set { _crumbSeparator = value; }
		}
		#endregion
	}
}