package net.wg.gui.lobby.vehicleCustomization.data.propertiesSheet
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class CustomizationPropertiesSheetStyleRendererVO extends DAAPIDataClass
   {
       
      
      public var image:String = "";
      
      public var isWide:Boolean = false;
      
      public var intCD:int = -1;
      
      public var specialArgs:Array = null;
      
      public function CustomizationPropertiesSheetStyleRendererVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         if(this.specialArgs != null)
         {
            this.specialArgs.splice(0,this.specialArgs.length);
            this.specialArgs = null;
         }
         super.onDispose();
      }
   }
}
