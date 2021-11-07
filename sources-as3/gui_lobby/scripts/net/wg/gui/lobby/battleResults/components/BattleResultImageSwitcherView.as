package net.wg.gui.lobby.battleResults.components
{
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.ImageCacheTypes;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IImage;
   
   public class BattleResultImageSwitcherView extends UIComponentEx
   {
       
      
      public var vehicleIcon:IImage = null;
      
      public var areaIcon:IImage = null;
      
      public function BattleResultImageSwitcherView()
      {
         super();
         this.vehicleIcon.cacheType = ImageCacheTypes.NOT_USE_CACHE;
         this.areaIcon.cacheType = ImageCacheTypes.NOT_USE_CACHE;
      }
      
      override protected function onDispose() : void
      {
         this.vehicleIcon.dispose();
         this.vehicleIcon = null;
         this.areaIcon.dispose();
         this.areaIcon = null;
         super.onDispose();
      }
      
      public function setVehicleIcon(param1:Boolean, param2:String, param3:int) : void
      {
         var _loc4_:VehicleIconPreset = null;
         if(this.vehicleIcon.visible = param1)
         {
            _loc4_ = VehicleIconPreset.getPreset(param3);
            App.utils.asserter.assertNotNull(_loc4_,"Icon preset for level: " + param3 + Errors.WASNT_FOUND);
            this.vehicleIcon.source = RES_SHOP.getVehicleIcon(_loc4_.size,param2);
            this.vehicleIcon.scaleX = this.vehicleIcon.scaleY = _loc4_.scale;
            this.vehicleIcon.x = _loc4_.offset.x;
            this.vehicleIcon.y = _loc4_.offset.y;
         }
      }
   }
}

import flash.geom.Point;
import net.wg.data.constants.generated.STORE_CONSTANTS;

class VehicleIconPreset
{
   
   private static const PRESETS:Vector.<VehicleIconPreset> = new <VehicleIconPreset>[new VehicleIconPreset(new <int>[1,2,3],STORE_CONSTANTS.ICON_SIZE_MEDIUM,700,30,1),new VehicleIconPreset(new <int>[4,5,6,7],STORE_CONSTANTS.ICON_SIZE_LARGE,610,0,0.65),new VehicleIconPreset(new <int>[8,9,10],STORE_CONSTANTS.ICON_SIZE_LARGE,570,-50,0.8)];
    
   
   public var size:String = "";
   
   public var offset:Point;
   
   public var scale:Number = 1.0;
   
   public var levels:Vector.<int> = null;
   
   function VehicleIconPreset(param1:Vector.<int>, param2:String, param3:Number, param4:Number, param5:Number)
   {
      this.offset = new Point();
      super();
      this.levels = param1;
      this.size = param2;
      this.offset.x = param3;
      this.offset.y = param4;
      this.scale = param5;
   }
   
   public static function getPreset(param1:int) : VehicleIconPreset
   {
      var _loc2_:VehicleIconPreset = null;
      for each(_loc2_ in PRESETS)
      {
         if(_loc2_.levels.indexOf(param1) >= 0)
         {
            return _loc2_;
         }
      }
      return null;
   }
}
