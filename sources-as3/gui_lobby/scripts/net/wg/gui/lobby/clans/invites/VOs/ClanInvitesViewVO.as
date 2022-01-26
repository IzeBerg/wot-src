package net.wg.gui.lobby.clans.invites.VOs
{
   import flash.utils.Dictionary;
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.NormalSortingBtnVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class ClanInvitesViewVO extends DAAPIDataClass
   {
      
      private static const TABLE_HEADERS:String = "tableHeaders";
      
      private static const TEXTS:String = "texts";
       
      
      private var _tableHeaders:DataProvider = null;
      
      private var _texts:Dictionary = null;
      
      public function ClanInvitesViewVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         var _loc2_:IDisposable = null;
         for each(_loc1_ in this._tableHeaders)
         {
            _loc1_.dispose();
         }
         this._tableHeaders.cleanUp();
         this._tableHeaders = null;
         for each(_loc2_ in this._texts)
         {
            _loc2_.dispose();
         }
         App.utils.data.cleanupDynamicObject(this._texts);
         this._texts = null;
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:Array = null;
         var _loc6_:Object = null;
         var _loc7_:DummyTextVO = null;
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
         if(TEXTS == param1)
         {
            _loc5_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc5_,TEXTS + Errors.CANT_NULL);
            this._texts = new Dictionary();
            for each(_loc6_ in _loc5_)
            {
               _loc7_ = new DummyTextVO(_loc6_);
               this._texts[_loc7_.alias] = _loc7_;
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      public function getDummyText(param1:String) : DummyTextVO
      {
         var _loc2_:DummyTextVO = this._texts[param1];
         App.utils.asserter.assertNotNull(_loc2_,"Dummy text with alias \'" + param1 + "\' is not found");
         return _loc2_;
      }
      
      public function get tableHeaders() : DataProvider
      {
         return this._tableHeaders;
      }
   }
}
