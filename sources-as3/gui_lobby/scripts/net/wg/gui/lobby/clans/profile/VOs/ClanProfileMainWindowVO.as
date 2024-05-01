package net.wg.gui.lobby.clans.profile.VOs
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.clans.common.ClanTabDataProviderVO;
   import scaleform.clik.data.DataProvider;
   
   public class ClanProfileMainWindowVO extends DAAPIDataClass
   {
      
      private static const TAB_DATA_PROVIDER:String = "tabDataProvider";
       
      
      public var waitingMsg:String = "";
      
      private var _tabDataProvider:DataProvider = null;
      
      public function ClanProfileMainWindowVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(param1 == TAB_DATA_PROVIDER)
         {
            this._tabDataProvider = new DataProvider();
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,param1 + Errors.CANT_NULL);
            for each(_loc4_ in _loc3_)
            {
               this._tabDataProvider.push(new ClanTabDataProviderVO(_loc4_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:ClanTabDataProviderVO = null;
         for each(_loc1_ in this._tabDataProvider)
         {
            _loc1_.dispose();
         }
         this._tabDataProvider.cleanUp();
         this._tabDataProvider = null;
         super.onDispose();
      }
      
      public function get tabDataProvider() : DataProvider
      {
         return this._tabDataProvider;
      }
   }
}
