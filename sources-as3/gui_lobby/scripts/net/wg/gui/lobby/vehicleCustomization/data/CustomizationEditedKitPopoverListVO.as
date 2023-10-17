package net.wg.gui.lobby.vehicleCustomization.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class CustomizationEditedKitPopoverListVO extends DAAPIDataClass
   {
      
      private static const ITEMS_FIELD_NAME:String = "items";
       
      
      public var items:DataProvider = null;
      
      public function CustomizationEditedKitPopoverListVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         if(param1 == ITEMS_FIELD_NAME)
         {
            this.items = new DataProvider();
            for each(_loc3_ in param2)
            {
               this.items.push(new CustomizationPopoverEditedItemRendererVO(_loc3_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this.items)
         {
            for each(_loc1_ in this.items)
            {
               _loc1_.dispose();
            }
            this.items.cleanUp();
            this.items = null;
         }
         super.onDispose();
      }
   }
}
