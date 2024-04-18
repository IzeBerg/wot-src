package net.wg.gui.lobby.eventInfoPanel.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class EventInfoPanelVO extends DAAPIDataClass
   {
      
      private static const ITEMS_FIELD:String = "items";
       
      
      public var bgUrl:String = "";
      
      private var _items:Vector.<EventInfoPanelItemVO> = null;
      
      public function EventInfoPanelVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1 == ITEMS_FIELD)
         {
            App.utils.asserter.assert(param2 is Array,"Field \'items\' is expected to be array");
            _loc3_ = param2 as Array;
            if(_loc3_ != null)
            {
               _loc4_ = _loc3_.length;
               this._items = new Vector.<EventInfoPanelItemVO>(_loc4_);
               _loc5_ = 0;
               while(_loc5_ < _loc4_)
               {
                  this._items[_loc5_] = new EventInfoPanelItemVO(_loc3_[_loc5_]);
                  _loc5_++;
               }
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this.bgUrl = null;
         this._items.splice(0,this._items.length);
         this._items = null;
         super.onDispose();
      }
      
      public function get items() : Vector.<EventInfoPanelItemVO>
      {
         return this._items;
      }
   }
}
