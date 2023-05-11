package net.wg.gui.lobby.clans.profile.VOs
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.profile.pages.statistics.header.StatisticsHeaderVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class ClanProfileGlobalMapInfoVO extends DAAPIDataClass
   {
      
      private static const HEADER_PARAMS:String = "headerParams";
      
      private static const BODY_PARAMS:String = "bodyParams";
       
      
      public var primeTimeText:String = "";
      
      private var _headerParams:DataProvider = null;
      
      private var _bodyParams:GlobalMapStatisticsBodyVO = null;
      
      public function ClanProfileGlobalMapInfoVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this._headerParams)
         {
            _loc1_.dispose();
         }
         this._headerParams.cleanUp();
         this._headerParams = null;
         this._bodyParams.dispose();
         this._bodyParams = null;
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc4_:Array = null;
         var _loc5_:Object = null;
         var _loc3_:Boolean = true;
         if(HEADER_PARAMS == param1)
         {
            _loc4_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc4_,HEADER_PARAMS + Errors.CANT_NULL);
            this._headerParams = new DataProvider();
            for each(_loc5_ in _loc4_)
            {
               this._headerParams.push(new StatisticsHeaderVO(_loc5_));
            }
            _loc3_ = false;
         }
         else if(BODY_PARAMS == param1)
         {
            this._bodyParams = new GlobalMapStatisticsBodyVO(param2);
            _loc3_ = false;
         }
         return _loc3_;
      }
      
      public function get headerParams() : DataProvider
      {
         return this._headerParams;
      }
      
      public function get bodyParams() : GlobalMapStatisticsBodyVO
      {
         return this._bodyParams;
      }
   }
}
