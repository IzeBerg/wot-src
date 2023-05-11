package net.wg.gui.lobby.clans.profile.VOs
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.NormalSortingBtnVO;
   import net.wg.gui.lobby.profile.pages.statistics.header.StatisticsHeaderVO;
   import scaleform.clik.data.DataProvider;
   
   public class ClanProfilePersonnelViewVO extends DAAPIDataClass
   {
      
      private static const TABLE_HEADERS:String = "tableHeaders";
      
      private static const STATISTICS:String = "statistics";
       
      
      public var title:String = "";
      
      public var defaultSortField:String = "";
      
      public var defaultSortDirection:String = "";
      
      private var _tableHeaders:DataProvider = null;
      
      private var _statistics:DataProvider = null;
      
      public function ClanProfilePersonnelViewVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:StatisticsHeaderVO = null;
         var _loc2_:NormalSortingBtnVO = null;
         for each(_loc1_ in this._statistics)
         {
            _loc1_.dispose();
         }
         this._statistics.cleanUp();
         this._statistics = null;
         for each(_loc2_ in this._tableHeaders)
         {
            _loc2_.dispose();
         }
         this._tableHeaders.cleanUp();
         this._tableHeaders = null;
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:Array = null;
         var _loc6_:Object = null;
         if(TABLE_HEADERS == param1)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,TABLE_HEADERS + Errors.CANT_NULL);
            this._tableHeaders = new DataProvider();
            for each(_loc4_ in _loc3_)
            {
               this._tableHeaders.push(new NormalSortingBtnVO(_loc4_));
            }
            return false;
         }
         if(STATISTICS == param1)
         {
            _loc5_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc5_,STATISTICS + Errors.CANT_NULL);
            this._statistics = new DataProvider();
            for each(_loc6_ in _loc5_)
            {
               this._statistics.push(new StatisticsHeaderVO(_loc6_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      public function get tableHeaders() : DataProvider
      {
         return this._tableHeaders;
      }
      
      public function get statistics() : DataProvider
      {
         return this._statistics;
      }
   }
}
