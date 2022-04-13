package net.wg.gui.lobby.battleResults.components
{
   import flash.display.DisplayObject;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.ImageCacheTypes;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IImage;
   
   public class BattleResultImageSwitcherView extends UIComponentEx
   {
      
      private static const STATUS_WIN:String = "win";
      
      private static const COMMANDER_X:int = 685;
      
      private static const COMMANDER_Y:int = 0;
       
      
      public var vehicleIcon:IImage = null;
      
      public var areaIcon:IImage = null;
      
      private var _defaultChildIndex:int = 0;
      
      public function BattleResultImageSwitcherView()
      {
         super();
         this.vehicleIcon.cacheType = ImageCacheTypes.NOT_USE_CACHE;
         this.areaIcon.cacheType = ImageCacheTypes.NOT_USE_CACHE;
         this._defaultChildIndex = getChildIndex(DisplayObject(this.vehicleIcon));
      }
      
      override protected function onDispose() : void
      {
         this.vehicleIcon.dispose();
         this.vehicleIcon = null;
         this.areaIcon.dispose();
         this.areaIcon = null;
         super.onDispose();
      }
      
      public function setCommanderIcon(param1:String) : void
      {
         this.vehicleIcon.source = param1 == STATUS_WIN ? RES_ICONS.MAPS_ICONS_RTSBATTLES_POSTBATTLE_STRATEGIST_WIN : RES_ICONS.MAPS_ICONS_RTSBATTLES_POSTBATTLE_STRATEGIST;
         this.vehicleIcon.x = COMMANDER_X;
         this.vehicleIcon.y = COMMANDER_Y;
         var _loc2_:DisplayObject = DisplayObject(this.vehicleIcon);
         if(numChildren - 1 != getChildIndex(_loc2_))
         {
            setChildIndex(_loc2_,numChildren - 1);
         }
      }
      
      public function setVehicleIcon(param1:Boolean, param2:String, param3:int) : void
      {
         var _loc4_:VehicleIconPreset = null;
         var _loc5_:DisplayObject = null;
         this.vehicleIcon.visible = param1;
         if(param1)
         {
            _loc4_ = VehicleIconPreset.getPreset(param3);
            App.utils.asserter.assertNotNull(_loc4_,"Icon preset for level: " + param3 + Errors.WASNT_FOUND);
            this.vehicleIcon.source = RES_SHOP.getVehicleIcon(_loc4_.size,param2);
            this.vehicleIcon.scaleX = this.vehicleIcon.scaleY = _loc4_.scale;
            this.vehicleIcon.x = _loc4_.offset.x;
            this.vehicleIcon.y = _loc4_.offset.y;
            _loc5_ = DisplayObject(this.vehicleIcon);
            if(this._defaultChildIndex != getChildIndex(_loc5_))
            {
               setChildIndex(_loc5_,this._defaultChildIndex);
            }
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
