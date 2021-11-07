package net.wg.gui.components.battleRoyale
{
   import flash.text.TextField;
   import net.wg.data.constants.ImageCacheTypes;
   import net.wg.gui.components.battleRoyale.data.IVehicleWeakZonesVO;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class VehicleWeakZonesBase extends UIComponentEx
   {
      
      private static const AMMUNITION_TF_MAX_WIDTH:int = 134;
      
      private static const AMMUNITION_TF_DEFAULT_Y:int = -18;
       
      
      public var engineTf:TextField = null;
      
      public var ammunitionTf:TextField = null;
      
      public var weakZones:Image = null;
      
      public function VehicleWeakZonesBase()
      {
         super();
         this.weakZones.cacheType = ImageCacheTypes.NOT_USE_CACHE;
      }
      
      override protected function onDispose() : void
      {
         this.engineTf = null;
         this.ammunitionTf = null;
         this.weakZones.dispose();
         this.weakZones = null;
         super.onDispose();
      }
      
      public function setData(param1:IVehicleWeakZonesVO) : void
      {
         this.engineTf.text = param1.engineLabel;
         this.ammunitionTf.text = param1.ammunitionLabel;
         this.weakZones.source = param1.weakZonesSrc;
         this.checkAmmunitionMaxWidth();
      }
      
      private function checkAmmunitionMaxWidth() : void
      {
         var _loc1_:int = this.ammunitionTf.textWidth;
         if(_loc1_ > AMMUNITION_TF_MAX_WIDTH)
         {
            this.ammunitionTf.x = AMMUNITION_TF_DEFAULT_Y + _loc1_ - AMMUNITION_TF_MAX_WIDTH;
         }
      }
   }
}
