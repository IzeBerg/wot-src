package net.wg.gui.battle.views.piercingDebugPanel.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class DebugPanelVO extends DAAPIDataClass
   {
      
      private static const PIERCING_ITEMS_FIELD_NAME:String = "piercingItems";
       
      
      public var shellType:String = "";
      
      public var piercingPower:String = "";
      
      public var dispersion:String = "";
      
      public var minPPValue:String = "";
      
      public var maxPPValue:String = "";
      
      private var _piercingItems:Vector.<PiercingItemVO> = null;
      
      public function DebugPanelVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == PIERCING_ITEMS_FIELD_NAME)
         {
            if(param2 is Array)
            {
               this._piercingItems = Vector.<PiercingItemVO>(App.utils.data.convertVOArrayToVector(param1,param2,PiercingItemVO));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this._piercingItems != null)
         {
            for each(_loc1_ in this._piercingItems)
            {
               _loc1_.dispose();
            }
            this._piercingItems.splice(0,this._piercingItems.length);
            this._piercingItems = null;
         }
         super.onDispose();
      }
      
      public function get piercingItems() : Vector.<PiercingItemVO>
      {
         return this._piercingItems;
      }
   }
}
