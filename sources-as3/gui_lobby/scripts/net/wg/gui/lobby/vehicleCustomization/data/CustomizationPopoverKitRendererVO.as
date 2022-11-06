package net.wg.gui.lobby.vehicleCustomization.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class CustomizationPopoverKitRendererVO extends DAAPIDataClass
   {
      
      private static const ITEM_ICONS:String = "itemIcons";
       
      
      public var name:String = "";
      
      public var itemIconsList:Vector.<CustomizationItemIconRendererVO> = null;
      
      public function CustomizationPopoverKitRendererVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         if(param1 == ITEM_ICONS)
         {
            this.itemIconsList = new Vector.<CustomizationItemIconRendererVO>();
            for each(_loc3_ in param2)
            {
               this.itemIconsList.push(new CustomizationItemIconRendererVO(_loc3_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this.itemIconsList != null)
         {
            for each(_loc1_ in this.itemIconsList)
            {
               _loc1_.dispose();
            }
            this.itemIconsList.splice(0,this.itemIconsList.length);
            this.itemIconsList = null;
         }
         super.onDispose();
      }
   }
}
