package net.wg.gui.battle.commander.views.vehiclesPanel
{
   import net.wg.data.constants.VehicleModules;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.components.controls.UILoaderAlt;
   import org.idmedia.as3commons.util.HashMap;
   
   public class VehicleDamagedModules extends BattleUIComponent
   {
      
      private static const SMALL_ICON_COUNT:Number = 3;
      
      private static const X_OFFSET:Number = 18;
      
      private static const TRACK_ASSET_NAME:String = "track";
       
      
      private var _moduleIcons:HashMap = null;
      
      private var _isBig:Boolean = true;
      
      public function VehicleDamagedModules()
      {
         super();
         this._moduleIcons = new HashMap();
      }
      
      private static function getModulePriority(param1:String) : int
      {
         switch(param1)
         {
            case VehicleModules.ENGINE:
            case TRACK_ASSET_NAME:
            case VehicleModules.GUN:
               return 3;
            case VehicleModules.SURVEYING_DEVICE:
            case VehicleModules.TURRET_ROTATOR:
               return 2;
            case VehicleModules.FUEL_TANK:
            case VehicleModules.RADIO:
         }
         return 1;
      }
      
      private static function sortOnPriority(param1:String, param2:String) : Number
      {
         var _loc3_:int = getModulePriority(param1);
         var _loc4_:int = getModulePriority(param2);
         if(_loc3_ < _loc4_)
         {
            return 1;
         }
         if(_loc3_ > _loc4_)
         {
            return -1;
         }
         return 0;
      }
      
      public function addIcon(param1:String) : void
      {
         if(VehicleModules.isTrack(param1))
         {
            param1 = TRACK_ASSET_NAME;
         }
         if(this._moduleIcons.containsKey(param1) || param1 == VehicleModules.AMMO_BAY)
         {
            return;
         }
         var _loc2_:String = RES_ICONS.getModuleDestroyedSmallIcon(param1);
         var _loc3_:UILoaderAlt = new UILoaderAlt();
         _loc3_.source = _loc2_;
         _loc3_.visible = true;
         _loc3_.setOriginalHeight(16);
         _loc3_.setOriginalWidth(16);
         this._moduleIcons.put(param1,{
            "loader":_loc3_,
            "priority":getModulePriority(param1)
         });
         this.recalculateIconsPositions();
         this.addChildAt(_loc3_,this._moduleIcons.size() - 1);
      }
      
      public function removeIcon(param1:String) : void
      {
         if(VehicleModules.isTrack(param1))
         {
            param1 = TRACK_ASSET_NAME;
         }
         var _loc2_:UILoaderAlt = !!this._moduleIcons.containsKey(param1) ? this._moduleIcons.remove(param1).loader : null;
         if(_loc2_)
         {
            _loc2_.dispose();
            this.recalculateIconsPositions();
         }
      }
      
      public function removeAllIcons() : void
      {
         var _loc2_:String = null;
         var _loc3_:UILoaderAlt = null;
         var _loc1_:Array = this._moduleIcons.keySet().toArray();
         for each(_loc2_ in _loc1_)
         {
            _loc3_ = !!this._moduleIcons.containsKey(name) ? this._moduleIcons.remove(name).loader : null;
            if(_loc3_)
            {
               _loc3_.dispose();
               this.recalculateIconsPositions();
            }
         }
      }
      
      public function clear() : void
      {
         var _loc2_:String = null;
         var _loc3_:UILoaderAlt = null;
         var _loc1_:Array = this._moduleIcons.keySet().toArray();
         for each(_loc2_ in _loc1_)
         {
            _loc3_ = this._moduleIcons.get(_loc2_).loader;
            _loc3_.dispose();
         }
         this._moduleIcons.clear();
      }
      
      public function get isBig() : Boolean
      {
         return this._isBig;
      }
      
      public function set isBig(param1:Boolean) : void
      {
         if(this._isBig != param1)
         {
            this._isBig = param1;
            this.recalculateIconsPositions();
         }
      }
      
      private function recalculateIconsPositions() : void
      {
         var _loc3_:String = null;
         var _loc4_:UILoaderAlt = null;
         var _loc1_:int = 0;
         var _loc2_:Array = this._moduleIcons.keySet().toArray();
         if(!this._isBig)
         {
            _loc2_.sort(sortOnPriority);
         }
         for each(_loc3_ in _loc2_)
         {
            _loc4_ = this._moduleIcons.get(_loc3_).loader;
            _loc4_.x = -X_OFFSET * _loc1_;
            _loc4_.visible = !(!this._isBig && _loc1_ > SMALL_ICON_COUNT - 1);
            _loc1_++;
         }
      }
   }
}
