package net.wg.gui.battle.commander.views.vehiclesPanel
{
   import net.wg.data.constants.VehicleModules;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.components.controls.UILoaderAlt;
   import org.idmedia.as3commons.util.HashMap;
   
   public class VehicleDamagedModules extends BattleUIComponent
   {
       
      
      private var X_OFFSET:Number = 18;
      
      private var _moduleIcons:HashMap = null;
      
      private var TRACK_ASSET_NAME:String = "track";
      
      public function VehicleDamagedModules()
      {
         super();
         this._moduleIcons = new HashMap();
      }
      
      public function addIcon(param1:String) : void
      {
         if(this._moduleIcons.containsKey(param1) || param1 == VehicleModules.AMMO_BAY)
         {
            return;
         }
         if(VehicleModules.isTrack(param1))
         {
            param1 = this.TRACK_ASSET_NAME;
         }
         var _loc2_:String = RES_ICONS.getModuleDestroyedSmallIcon(param1);
         var _loc3_:UILoaderAlt = new UILoaderAlt();
         _loc3_.source = _loc2_;
         _loc3_.visible = true;
         _loc3_.setOriginalHeight(16);
         _loc3_.setOriginalWidth(16);
         this._moduleIcons.put(param1,_loc3_);
         this.recalculateIconsPositions();
         this.addChildAt(_loc3_,this._moduleIcons.size() - 1);
      }
      
      public function removeIcon(param1:String) : void
      {
         if(VehicleModules.isTrack(param1))
         {
            param1 = this.TRACK_ASSET_NAME;
         }
         var _loc2_:UILoaderAlt = this._moduleIcons.remove(param1);
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
            _loc3_ = this._moduleIcons.remove(_loc2_);
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
            _loc3_ = this._moduleIcons.get(_loc2_);
            _loc3_.dispose();
         }
         this._moduleIcons.clear();
      }
      
      private function recalculateIconsPositions() : void
      {
         var _loc3_:String = null;
         var _loc4_:UILoaderAlt = null;
         var _loc1_:int = 0;
         var _loc2_:Array = this._moduleIcons.keySet().toArray();
         for each(_loc3_ in _loc2_)
         {
            _loc4_ = this._moduleIcons.get(_loc3_);
            _loc4_.x = -this.X_OFFSET * _loc1_;
            _loc1_++;
         }
      }
   }
}
