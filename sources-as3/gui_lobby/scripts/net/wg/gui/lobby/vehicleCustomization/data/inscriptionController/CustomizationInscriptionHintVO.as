package net.wg.gui.lobby.vehicleCustomization.data.inscriptionController
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class CustomizationInscriptionHintVO extends DAAPIDataClass
   {
      
      private static const ICONS_FILED:String = "icons";
       
      
      public var hintMessage:String = "";
      
      public var icons:Array = null;
      
      public var duration:int = 0;
      
      public var delay:int = 0;
      
      public function CustomizationInscriptionHintVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:CustomizationImageVO = null;
         var _loc4_:Object = null;
         if(param1 == ICONS_FILED && param2 != null)
         {
            this.icons = [];
            for each(_loc4_ in param2)
            {
               _loc3_ = new CustomizationImageVO(_loc4_);
               this.icons.push(_loc3_);
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:CustomizationImageVO = null;
         if(this.icons)
         {
            for each(_loc1_ in this.icons)
            {
               _loc1_.dispose();
            }
            this.icons.splice(0,this.icons.length);
            this.icons = null;
         }
         super.onDispose();
      }
   }
}
