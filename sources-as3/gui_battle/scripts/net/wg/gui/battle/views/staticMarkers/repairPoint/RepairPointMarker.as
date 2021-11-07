package net.wg.gui.battle.views.staticMarkers.repairPoint
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersManager;
   import net.wg.gui.battle.views.vehicleMarkers.events.VehicleMarkersManagerEvent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class RepairPointMarker extends Sprite implements IDisposable
   {
      
      private static const STATE_COOLDOWN:String = "cooldown";
       
      
      public var labelTF:TextField = null;
      
      public var labelBg:MovieClip = null;
      
      public var marker:RepairPointIcon = null;
      
      private var _vmManager:VehicleMarkersManager = null;
      
      private var _labelText:String = null;
      
      private var _isCooldown:Boolean = false;
      
      private var _isAlly:Boolean = false;
      
      private var _isColorBlind:Boolean = false;
      
      private var _isIconShown:Boolean = false;
      
      public function RepairPointMarker()
      {
         super();
         this._vmManager = VehicleMarkersManager.getInstance();
         this._vmManager.addEventListener(VehicleMarkersManagerEvent.UPDATE_COLORS,this.onUpdateColorsHandler);
         this.labelTF.visible = false;
         this.labelBg.visible = false;
      }
      
      public function setIcon(param1:String, param2:Boolean) : void
      {
         var _loc3_:Boolean = false;
         _loc3_ = param1 == STATE_COOLDOWN;
         if(this._isIconShown && this._isCooldown == _loc3_)
         {
            return;
         }
         this.labelTF.visible = _loc3_;
         this.labelBg.visible = _loc3_;
         this.marker.showMarker(_loc3_,param2,this._isColorBlind);
         if(!_loc3_)
         {
            if(this._labelText != null)
            {
               this.labelTF.text = this._labelText;
            }
         }
         this._isCooldown = _loc3_;
         this._isAlly = param2;
         this._isIconShown = true;
      }
      
      public function setLabel(param1:String) : void
      {
         this._labelText = param1;
         if(this._isCooldown)
         {
            this.labelTF.text = param1;
         }
      }
      
      public function dispose() : void
      {
         this._vmManager.removeEventListener(VehicleMarkersManagerEvent.UPDATE_COLORS,this.onUpdateColorsHandler);
         this.marker.dispose();
         this.labelTF = null;
         this.labelBg = null;
         this.marker = null;
         this._vmManager = null;
      }
      
      private function onUpdateColorsHandler(param1:VehicleMarkersManagerEvent) : void
      {
         this._isColorBlind = this._vmManager.isColorBlind;
         if(this._isIconShown)
         {
            this.marker.showMarker(this._isCooldown,this._isAlly,this._isColorBlind);
         }
      }
   }
}
