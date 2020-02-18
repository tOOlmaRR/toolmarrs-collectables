using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GeoTradingCards.classes
{
	public class GoogleDoc
	{
		private int id;
		private string season;
		private string set;
		private string url;

		public int ID
		{
			get { return id; }
		}

		public string Season
		{
			get { return season; }
			set { season = value; }
		}

		public string Set
		{
			get { return set; }
			set { set = value; }
		}

		public string Url
		{
			get { return url; }
			set { url = value; }
		}

		public GoogleDoc()
		{
			this.season = string.Empty;
			this.set = string.Empty;
			this.url = string.Empty;
		}

		public GoogleDoc(int ID)
		{
			this.id = ID;
			this.season = string.Empty;
			this.set = string.Empty;
			this.url = string.Empty;
		}

		/// <summary>
		/// Checks this object to see if it is a valid database row
		/// </summary>
		/// <returns>TRUE if valid; otherwise, FALSE</returns>
		public bool isValidDbRow()
		{
			return isValidDbRow(false);
		}

		/// <summary>
		/// Checks this object to see if it is a valid database row
		/// </summary>
		/// <returns>TRUE if valid; otherwise, FALSE</returns>
		public bool isValidDbRow(bool inserting)
		{
			if (!inserting)
			{
				if (this.ID > 0 && !string.IsNullOrEmpty(this.season) && !string.IsNullOrEmpty(this.set) && !string.IsNullOrEmpty(this.url))
					return true;
				else
					return false;
			}
			else
			{
				if (!string.IsNullOrEmpty(this.season) && !string.IsNullOrEmpty(this.set) && !string.IsNullOrEmpty(this.url))
					return true;
				else
					return false;
			}
		}

		public bool InsertIntoDB()
		{
			if (this.isValidDbRow(true))
				return GeoTradingCards.DAL.GoogleDocsManager.InsertGoogleDoc(this);
			else
				return false;
		}
	}
}
