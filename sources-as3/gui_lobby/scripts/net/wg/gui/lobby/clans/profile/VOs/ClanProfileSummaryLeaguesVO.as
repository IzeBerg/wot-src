package net.wg.gui.lobby.clans.profile.VOs
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class ClanProfileSummaryLeaguesVO extends DAAPIDataClass
   {
      
      private static const LEAGUES:String = "leagues";
       
      
      public var leagues:DataProvider = null;
      
      public function ClanProfileSummaryLeaguesVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:LeagueItemRendererVO = null;
         var _loc5_:Object = null;
         if(param1 == LEAGUES)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,"leagues" + Errors.CANT_NULL);
            this.leagues = new DataProvider();
            _loc4_ = null;
            for each(_loc5_ in _loc3_)
            {
               _loc4_ = new LeagueItemRendererVO(_loc5_);
               this.leagues.push(_loc4_);
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this.leagues != null)
         {
            for each(_loc1_ in this.leagues)
            {
               _loc1_.dispose();
            }
            this.leagues.cleanUp();
            this.leagues = null;
         }
         super.onDispose();
      }
   }
}
