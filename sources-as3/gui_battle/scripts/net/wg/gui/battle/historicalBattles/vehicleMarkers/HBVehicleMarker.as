package net.wg.gui.battle.historicalBattles.vehicleMarkers
{
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.VEHICLEMARKERATLAS;
   import net.wg.gui.battle.views.vehicleMarkers.VMAtlasItemName;
   import net.wg.gui.battle.views.vehicleMarkers.VO.CrossOffset;
   import net.wg.gui.battle.views.vehicleMarkers.VO.VehicleMarkerPart;
   import net.wg.gui.battle.views.vehicleMarkers.VehicleMarker;
   import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersConstants;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.gfx.TextFieldEx;
   
   public class HBVehicleMarker extends VehicleMarker
   {
      
      private static const DEAD_COLOR:String = "black";
      
      private static const MARKER_ALLY_BOT:String = "allyBot";
      
      private static const ARROW_FLAG_Y:int = 82;
      
      private static const ARROW_FLAG_MARKER_Y:int = 26;
       
      
      public var bossFlag:MovieClip = null;
      
      public var shield:MovieClip = null;
      
      public var distanceField:TextField = null;
      
      private var _metersString:String = "";
      
      private var _distance:Number = -1;
      
      private var _markerTypeOverride:String = "";
      
      private var _isBot:Boolean = false;
      
      private var _haveShield:Boolean = false;
      
      public function HBVehicleMarker()
      {
         super();
         this.flagVisibility(false);
         this.shield.visible = false;
         TextFieldEx.setNoTranslate(this.distanceField,true);
      }
      
      override protected function setVehicleType() : void
      {
         super.setVehicleType();
         this.updateShieldIcon();
      }
      
      override protected function onDispose() : void
      {
         this.bossFlag = null;
         this.shield = null;
         this.distanceField = null;
         super.onDispose();
      }
      
      override protected function getVehicleImageId() : String
      {
         if(model.speaking && !vehicleDestroyed)
         {
            return VMAtlasItemName.SPEAKING_ICON;
         }
         if(StringUtils.isEmpty(this._markerTypeOverride))
         {
            return VMAtlasItemName.getVehicleTypeIconName(markerColor,model.vClass,model.hunt);
         }
         var _loc1_:String = !!vehicleDestroyed ? DEAD_COLOR : markerColor;
         return VMAtlasItemName.getVehicleTypeIconName(_loc1_,this._markerTypeOverride,false);
      }
      
      override protected function prepareLayout() : void
      {
         markerParts = new Vector.<VehicleMarkerPart>();
         this.addPart(hpField,-2);
         this.addPart(vehicleNameField,1,new CrossOffset(hpField,-3));
         this.addPart(playerNameField,-2,new CrossOffset(vehicleNameField,-7,hpField,-3));
         this.addPart(levelIcon,1,new CrossOffset(vehicleNameField,-4,playerNameField,-4));
         this.addPart(vehicleIcon,1,new CrossOffset(levelIcon,-12,vehicleNameField,-3,playerNameField,-3));
         this.addPart(this.distanceField,-4);
         this.addPart(this.bossFlag,-72);
         this.addPart(this.shield,-70);
         this.addPart(statusContainer,0,new CrossOffset(this.shield,10));
         this.addPart(actionMarker,0,new CrossOffset(statusContainer,-25,this.bossFlag,14,this.shield,10));
         this.addPart(vehicleMarkerHoverMC,-66,new CrossOffset(statusContainer,-86,actionMarker,-52,this.bossFlag,-48,this.shield,-50));
      }
      
      override protected function layoutParts(param1:Vector.<Boolean>) : void
      {
         super.layoutParts(param1);
         this.changeArrowPosition();
      }
      
      override protected function updatePartsVisibility() : Vector.<Boolean>
      {
         var _loc1_:Vector.<Boolean> = super.updatePartsVisibility();
         return new <Boolean>[_loc1_[0],_loc1_[2],_loc1_[1],_loc1_[3],_loc1_[4],this.distanceField.visible,this.bossFlag.visible,this.shield.visible,_loc1_[8],_loc1_[9],_loc1_[10]];
      }
      
      public function setIsBot(param1:Boolean) : void
      {
         this._isBot = param1;
      }
      
      public function showShield() : void
      {
         this._haveShield = true;
         this.shield.visible = this._haveShield && !isStickyAndOutOfScreen;
         this.updateShieldIcon();
      }
      
      public function initBossMarker(param1:Number, param2:String) : void
      {
         this._distance = !isNaN(param1) ? Number(Math.round(param1)) : Number(Values.DEFAULT_INT);
         this._metersString = param2;
         if(initialized)
         {
            this.setDistanceText();
         }
      }
      
      public function overrideTypeIcon(param1:String) : void
      {
         if(this._markerTypeOverride == param1)
         {
            return;
         }
         this._markerTypeOverride = param1;
         if(model.vClass)
         {
            this.setVehicleType();
         }
      }
      
      public function setHBDistance(param1:Number) : void
      {
         var _loc2_:Number = !isNaN(param1) ? Number(Math.round(param1)) : Number(Values.DEFAULT_INT);
         if(this._distance == _loc2_)
         {
            return;
         }
         this._distance = _loc2_;
         this.setDistanceText();
      }
      
      override public function get markerSettings() : Object
      {
         if(entityType == VehicleMarkersConstants.ENTITY_TYPE_ALLY && this._isBot && !vehicleDestroyed)
         {
            return vmManager.markerSettings[MARKER_ALLY_BOT];
         }
         return super.markerSettings;
      }
      
      private function updateShieldIcon() : void
      {
         var _loc1_:String = null;
         if(this.shield.visible)
         {
            _loc1_ = !!vehicleDestroyed ? VEHICLEMARKERATLAS.SHIELD_DEAD : VEHICLEMARKERATLAS.SHIELD;
            vmManager.drawWithCenterAlign(_loc1_,this.shield.graphics,true,true);
         }
      }
      
      private function setDistanceText() : void
      {
         var _loc1_:Boolean = this._distance > Values.DEFAULT_INT;
         this.distanceField.text = !!_loc1_ ? this._distance.toString() + this._metersString : Values.EMPTY_STR;
         this.flagVisibility(_loc1_);
      }
      
      private function addPart(param1:Object, param2:int, param3:CrossOffset = null) : void
      {
         markerParts.push(new VehicleMarkerPart(param1,param2,param3));
      }
      
      private function flagVisibility(param1:Boolean) : void
      {
         this.bossFlag.visible = param1;
         this.distanceField.visible = param1;
      }
      
      private function changeArrowPosition() : void
      {
         var _loc1_:int = 0;
         if(this.bossFlag.visible)
         {
            _loc1_ = !!actionMarker.isVisible() ? int(ARROW_FLAG_MARKER_Y) : int(ARROW_FLAG_Y);
         }
         actionMarker.updateArrowPosition(new Point(0,_loc1_));
      }
      
      override public function setIsStickyAndOutOfScreen(param1:Boolean) : void
      {
         this.shield.visible = this._haveShield && !param1;
         super.setIsStickyAndOutOfScreen(param1);
      }
   }
}
