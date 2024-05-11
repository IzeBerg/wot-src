package net.wg.gui.lobby.components.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ButtonFiltersVO extends DAAPIDataClass
   {
      
      private static const ITEMS_FIELD_NAME:String = "items";
       
      
      public var items:Vector.<ButtonFiltersItemVO>;
      
      public var minSelectedItems:int = -1;
      
      public var filterTypeName:String = "";
      
      public function ButtonFiltersVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == ITEMS_FIELD_NAME)
         {
            this.items = Vector.<ButtonFiltersItemVO>(App.utils.data.convertVOArrayToVector(param1,param2,ButtonFiltersItemVO));
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:ButtonFiltersItemVO = null;
         if(this.items != null)
         {
            for each(_loc1_ in this.items)
            {
               _loc1_.dispose();
            }
            this.items.fixed = false;
            this.items.splice(0,this.items.length);
            this.items = null;
         }
         super.onDispose();
      }
   }
}
