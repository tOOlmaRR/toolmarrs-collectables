using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Linq;

namespace GeoTradingCards.DAL
{
	public static class ExceptionManager
	{
		public static void LogException(System.Exception ex)
		{
			LogException(ex, string.Empty);
		}
		
		public static void LogException(System.Exception ex, string customMsg)
		{
			GeoTradingCards.DAL.Exception newException = new Exception();
			newException.Description = ex.Message;
			newException.Source = ex.Source;
			newException.StackTrace = ex.StackTrace;
			newException.CustomMessage = customMsg;
			newException.Timestamp = DateTime.Now;
			if (ex.InnerException != null)
				newException.InnerException = ex.InnerException.Message;
			try
			{
				Databases.Exceptions.Exceptions.InsertOnSubmit(newException);
				Databases.Exceptions.SubmitChanges(System.Data.Linq.ConflictMode.FailOnFirstConflict);
			}
			// may not be necessary here, but good practice
			catch (ChangeConflictException)
			{
				foreach (ObjectChangeConflict conflict in Databases.Exceptions.ChangeConflicts)
				{
					conflict.Resolve(RefreshMode.OverwriteCurrentValues);
				}
			}
		}
	}
}