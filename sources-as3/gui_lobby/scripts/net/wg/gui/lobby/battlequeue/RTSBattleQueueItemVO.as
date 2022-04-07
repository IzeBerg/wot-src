package net.wg.gui.lobby.battlequeue
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class RTSBattleQueueItemVO extends BattleQueueItemVO
   {
      
      public static const ITEMS_DATA_FIELD:String = "subItems";
       
      
      private var _subItems:DataProvider = null;
      
      public function RTSBattleQueueItemVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(param1 == ITEMS_DATA_FIELD)
         {
            this._subItems = new DataProvider();
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,Errors.INVALID_TYPE + Array);
            for each(_loc4_ in _loc3_)
            {
               this._subItems.push(new BattleQueueItemVO(_loc4_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this._subItems)
         {
            _loc1_.dispose();
         }
         this._subItems.cleanUp();
         this._subItems = null;
         super.onDispose();
      }
      
      public function get subItems() : DataProvider
      {
         return this._subItems;
      }
   }
}
