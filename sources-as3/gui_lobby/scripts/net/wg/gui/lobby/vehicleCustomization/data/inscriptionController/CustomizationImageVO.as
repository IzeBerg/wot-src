package net.wg.gui.lobby.vehicleCustomization.data.inscriptionController
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class CustomizationImageVO extends DAAPIDataClass
   {
       
      
      public var image:String = "";
      
      public var text:String = "";
      
      public function CustomizationImageVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         this.image = null;
         this.text = null;
         super.onDispose();
      }
   }
}
