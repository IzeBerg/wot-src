package net.wg.gui.lobby.clans.profile.VOs
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.NormalSortingBtnVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class ClanProfileTableStatisticsDataVO extends DAAPIDataClass
   {
      
      private static const HEADERS:String = "headers";
       
      
      public var rendererLinkage:String = "";
      
      public var defaultSortField:String = "";
      
      public var defaultSortDirection:String = "";
      
      public var noDataText:String = "";
      
      public var isListVisible:Boolean = false;
      
      public var isNoDataTextVisible:Boolean = false;
      
      private var _headers:DataProvider = null;
      
      public function ClanProfileTableStatisticsDataVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(HEADERS == param1)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,HEADERS + Errors.CANT_NULL);
            this._headers = new DataProvider();
            for each(_loc4_ in _loc3_)
            {
               this._headers.push(new NormalSortingBtnVO(_loc4_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this._headers)
         {
            _loc1_.dispose();
         }
         this._headers.cleanUp();
         this._headers = null;
         super.onDispose();
      }
      
      public function get headers() : DataProvider
      {
         return this._headers;
      }
   }
}
