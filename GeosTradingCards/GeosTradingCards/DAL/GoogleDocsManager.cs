using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using GeoTradingCards.classes;
using System.Data.Linq;

namespace GeoTradingCards.DAL
{
	/// <summary>
	/// Provides access to the Google Docs table in th Sports Cards database
	/// </summary>
	public class GoogleDocsManager
	{
		
		/// <summary>
		/// Retrieves a list of all seasons in the Google Docs table in the database
		/// </summary>
		/// <returns>A list of seasons</returns>
		public static List<string> GetAllSeasons()
		{
			List<string> allSeasons = new List<string>();
			allSeasons = (from gDocs in Databases.GoogleDocs.GoogleDocsPages
						  select gDocs.Season).Distinct().ToList();
			return allSeasons;
		}

		/// <summary>
		/// Returns all rows in the Google Docs table in the database
		/// </summary>
		/// <returns>A list of all Google Docs</returns>
		public static List<DAL.GoogleDocsPage> GetAllGoogleDocs()
		{
			List<DAL.GoogleDocsPage> allGoogleDocs = new List<GoogleDocsPage>();
			allGoogleDocs = (from gDocs in Databases.GoogleDocs.GoogleDocsPages
							 select gDocs).ToList();
			return allGoogleDocs;
		}

		/// <summary>
		/// Retrieves a list of all Google Docs in the database from the specified season
		/// </summary>
		/// <param name="season"></param>
		/// <returns>A list of Google Docs</returns>
		public static List<DAL.GoogleDocsPage> GetDocsFromSeason(string season)
		{
			List<DAL.GoogleDocsPage> docs = new List<GoogleDocsPage>();
			docs = (from gDocs in Databases.GoogleDocs.GoogleDocsPages
					 where gDocs.Season == season
					 select gDocs).ToList();
			return docs;
		}

		/// <summary>
		/// Retrieves a specific Google Doc from a specified season and set
		/// </summary>
		/// <param name="season"></param>
		/// <param name="set"></param>
		/// <returns>A Google document</returns>
		public static GoogleDocsPage GetDocBySet(string season, string set)
		{
			GoogleDocsPage gDoc = (from gDocs in Databases.GoogleDocs.GoogleDocsPages
								   where gDocs.Season == season
								   where gDocs.Set == set
								   select gDocs).FirstOrDefault();
			return gDoc;
		}

		/// <summary>
		/// Retrieves a list of sets from a specified season from the database
		/// </summary>
		/// <param name="season"></param>
		/// <returns>A list of sets</returns>
		public static List<string> GetSetsBySeason(string season)
		{
			List<string> sets = new List<string>();
			sets = (from gDocs in Databases.GoogleDocs.GoogleDocsPages
					where gDocs.Season == season
					select gDocs.Set).ToList();
			return sets;
		}

		/// <summary>
		/// Retrieves the Url of a Google Doc with from the specified season and set from the database
		/// </summary>
		/// <param name="season"></param>
		/// <param name="set"></param>
		/// <returns>The URL of a Google Doc</returns>
		public static string GetGoogleDocUrl(string season, string set)
		{
			string url = string.Empty;
			url = (from gDocs in Databases.GoogleDocs.GoogleDocsPages
				   where gDocs.Season == season
				   where gDocs.Set == set
				   select gDocs.GoogleDocsUrl).FirstOrDefault();
			return url;
		}

		public static bool InsertGoogleDoc(GoogleDoc newDoc)
		{
			GeoTradingCards.DAL.GoogleDocsPage newPage = new GoogleDocsPage();
			newPage.Season = newDoc.Season;
			newPage.Set = newDoc.Set;
			newPage.GoogleDocsUrl = newDoc.Url;
			try
			{
				Databases.GoogleDocs.GoogleDocsPages.InsertOnSubmit(newPage);
				Databases.GoogleDocs.SubmitChanges(System.Data.Linq.ConflictMode.FailOnFirstConflict);
				return true;
			}
			catch (ChangeConflictException)
			{
				foreach (ObjectChangeConflict conflict in Databases.GoogleDocs.ChangeConflicts)
				{
					conflict.Resolve(RefreshMode.OverwriteCurrentValues);
				}
				return true;
			}
			catch (System.Exception ex)
			{
				ExceptionManager.LogException(ex);
				return false;
			}
		}
	}
}