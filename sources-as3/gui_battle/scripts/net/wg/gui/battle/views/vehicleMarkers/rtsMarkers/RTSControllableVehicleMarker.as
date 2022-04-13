package net.wg.gui.battle.views.vehicleMarkers.rtsMarkers
{
   import flash.events.Event;
   import flash.geom.Point;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.commander.views.common.Clips;
   import net.wg.gui.battle.commander.views.common.GroupIcon;
   import net.wg.gui.battle.commander.views.common.Reloading;
   import net.wg.gui.battle.commander.views.common.ReloadingData;
   import net.wg.gui.battle.views.vehicleMarkers.VMAtlasItemName;
   import net.wg.gui.battle.views.vehicleMarkers.VO.CrossOffset;
   import net.wg.gui.battle.views.vehicleMarkers.VO.VehicleMarkerPart;
   import net.wg.gui.battle.views.vehicleMarkers.VehicleActionMarker;
   import net.wg.utils.TextFieldUtils;
   
   public class RTSControllableVehicleMarker extends RTSVehicleMarker
   {
      
      protected static const V_NAME_STICKY_LBL:String = "VehicleNameSticky";
      
      protected static const V_GROUP_ICON_LBL:String = "Group";
      
      protected static const V_SPECIAL_ICON_LBL:String = "SpecialIcon";
      
      protected static const V_RELOADING_LBL:String = "Reloading";
      
      protected static const V_CLIP_LBL:String = "Reloading";
      
      protected static const V_HOVER_LBL:String = "Hover";
       
      
      public var specialIcon:VehicleActionMarker = null;
      
      public var vehicleNameStickyField:TextField = null;
      
      public var groupIcon:GroupIcon = null;
      
      public var reloading:Reloading = null;
      
      public var clips:Clips = null;
      
      protected var reloadingContext:ReloadingData = null;
      
      protected var currentSpecialIcon:String = "";
      
      private var _isActionMarkerShown:Boolean = false;
      
      private var _isStatusMarkerShown:Boolean = false;
      
      private var _isSpecialIconShown:Boolean = false;
      
      public function RTSControllableVehicleMarker()
      {
         super();
         this.clips.clipsType = Clips.CLIPS_RECT_TYPE;
         this.clips.clipsDirection = Clips.CLIPS_LEFT_DIRECTION;
      }
      
      override public function showActionMarker(param1:String) : void
      {
         if(this._isActionMarkerShown)
         {
            actionMarker.removeEventListener(Event.COMPLETE,this.onSpecialAnimationHiddenCompleteHandler);
            actionMarker.stopAction(false);
         }
         this._isActionMarkerShown = true;
         actionMarker.addEventListener(Event.COMPLETE,this.onActionAnimationHiddenCompleteHandler);
         super.showActionMarker(param1);
      }
      
      override public function showStatusMarker(param1:int, param2:int, param3:Boolean, param4:Number, param5:int, param6:int, param7:Boolean = true) : void
      {
         this._isStatusMarkerShown = true;
         super.showStatusMarker(param1,param2,param3,param4,param5,param6,param7);
      }
      
      override public function updateFocusedSelected(param1:Boolean, param2:Boolean) : void
      {
         super.updateFocusedSelected(param1,param2);
         this.groupIcon.isSelected = _selected;
      }
      
      override protected function onDispose() : void
      {
         this.vehicleNameStickyField = null;
         if(this.specialIcon != null)
         {
            this.specialIcon.dispose();
         }
         this.specialIcon = null;
         this.reloading.dispose();
         this.reloading = null;
         this.groupIcon.dispose();
         this.groupIcon = null;
         this.reloadingContext = null;
         this.clips.dispose();
         this.clips = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.reloadingContext = this.reloading.makeContext();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(_isManagerReady && _model != null && !_isPopulated && isInvalid(InvalidationType.DATA))
         {
            this.reloading.setContext(this.reloadingContext);
         }
      }
      
      override protected function updateMarkerSettings() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc13_:Boolean = false;
         var _loc15_:Point = null;
         _loc1_ = this.getIsPartVisible(ICON);
         _loc2_ = this.getIsPartVisible(LEVEL);
         _loc3_ = this.getIsPartVisible(P_NAME_LBL);
         _loc4_ = this.getIsPartVisible(V_NAME_LBL);
         _loc5_ = this.getIsPartVisible(V_NAME_STICKY_LBL);
         var _loc6_:Boolean = this.getIsPartVisible(HEALTH_BAR);
         var _loc7_:Boolean = this.getIsPartVisible(HEALTH_LBL);
         _loc8_ = this.getIsPartVisible(DAMAGE_PANEL);
         var _loc9_:Boolean = this.getIsPartVisible(V_GROUP_ICON_LBL);
         var _loc10_:Boolean = this.getIsPartVisible(V_RELOADING_LBL);
         var _loc11_:Boolean = this.getIsPartVisible(V_CLIP_LBL);
         var _loc12_:Boolean = this.getIsPartVisible(V_HOVER_LBL);
         _loc13_ = this.getIsPartVisible(V_SPECIAL_ICON_LBL);
         if(_loc3_ && _lastPlayerName != _model.pName)
         {
            _lastPlayerName = _model.pName;
            TextFieldUtils.instance.truncateTextFieldText(playerNameField,_lastPlayerName);
         }
         if(_loc4_)
         {
            vehicleNameField.text = _model.vType;
         }
         if(_loc5_)
         {
            this.vehicleNameStickyField.text = _model.vType;
         }
         if(_loc6_)
         {
            healthBar.currHealth = _model.currHealth;
         }
         if(_vehicleDestroyed)
         {
            setDestroyedColorForHP();
         }
         this.setHealthText();
         hitLabel.visible = _loc8_;
         hitExplosion.visible = _loc8_;
         levelIcon.visible = _loc2_;
         vehicleIcon.visible = _loc1_;
         healthBar.visible = _loc6_;
         hpField.visible = _loc7_;
         vehicleNameField.visible = _loc4_;
         this.vehicleNameStickyField.visible = _loc5_;
         playerNameField.visible = _loc3_;
         this.groupIcon.isShown = _loc9_;
         this.reloading.isShown = _loc10_;
         this.clips.visible = _loc11_;
         hover.isShown = _loc12_;
         this.specialIcon.visible = _loc13_;
         var _loc14_:int = (!!_loc3_ ? 1 : 0) + (!!_loc4_ ? 1 : 0);
         if(!_loc6_)
         {
            _loc14_ += !!_loc7_ ? 1 : 0;
            if(_loc14_ > 0)
            {
               _loc14_ += SHADOW_TYPE_HBAR_OFFSET;
            }
         }
         if(_loc14_ > 0)
         {
            _loc15_ = SHADOW_POSITIONS[_loc14_];
            _vmManager.drawGraphics(VMAtlasItemName.getShadowName(_loc14_),bgShadow.graphics,_loc15_);
            bgShadow.visible = true;
         }
         else
         {
            bgShadow.visible = false;
         }
         layoutParts(new <Boolean>[_loc6_ || _loc7_,playerNameField.visible,_loc4_,_loc2_,_loc1_,_model.squadIndex != 0,this._isSpecialIconShown,_loc9_ && this.groupIcon.groupID > 0,_isFlagShown,this.vehicleNameStickyField.visible,this._isActionMarkerShown,this._isStatusMarkerShown]);
      }
      
      override protected function setHealthText() : void
      {
         hpField.text = _model.currHealth + SLASH_STRING + _model.maxHealth;
      }
      
      override protected function prepareLayout() : void
      {
         var _loc4_:VehicleMarkerPart = null;
         _markerParts = new Vector.<VehicleMarkerPart>();
         var _loc1_:Array = [hpField,playerNameField,vehicleNameField,levelIcon,vehicleIcon,squadIcon,this.specialIcon,this.groupIcon,marker2,this.vehicleNameStickyField,actionMarker,statusContainer];
         var _loc2_:Array = [-2,-2,1,1,1,1,1,1,1,0,2,2];
         var _loc3_:Array = [null,new CrossOffset(hpField,-3),new CrossOffset(playerNameField,-7,hpField,-3),new CrossOffset(vehicleNameField,-4,playerNameField,-4),new CrossOffset(levelIcon,-12,vehicleNameField,-3,playerNameField,-3),null,new CrossOffset(vehicleNameField,-12),new CrossOffset(vehicleNameField,-3,this.specialIcon,7),null,null,new CrossOffset(this.vehicleNameStickyField,-10,vehicleNameField,-3),new CrossOffset(actionMarker,15)];
         var _loc5_:int = _loc1_.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = new VehicleMarkerPart(_loc1_[_loc6_],_loc2_[_loc6_],_loc3_[_loc6_]);
            _markerParts.push(_loc4_);
            _loc6_++;
         }
      }
      
      override protected function setMarkerState(param1:String) : void
      {
         super.setMarkerState(param1);
         if(initialized)
         {
            this.reloading.isAlive = this.groupIcon.isAlive = this.clips.isAlive = !_vehicleDestroyed;
         }
      }
      
      override protected function getIsPartVisible(param1:String) : Boolean
      {
         var _loc2_:Boolean = false;
         if(_isStickyAndOutOfScreen)
         {
            _loc2_ = param1 == V_NAME_STICKY_LBL || param1 == ACTION_MARKER;
         }
         else if(_vehicleDestroyed)
         {
            _loc2_ = param1 == V_NAME_LBL || param1 == HEALTH_BAR || param1 == HEALTH_LBL || param1 == DAMAGE_PANEL;
         }
         else
         {
            _loc2_ = param1 == V_NAME_LBL || param1 == HEALTH_BAR || param1 == HEALTH_LBL || param1 == DAMAGE_PANEL || param1 == V_GROUP_ICON_LBL || param1 == V_RELOADING_LBL || param1 == V_CLIP_LBL || param1 == V_HOVER_LBL || param1 == V_SPECIAL_ICON_LBL;
         }
         return _loc2_;
      }
      
      public function setClipData(param1:int, param2:int, param3:Boolean, param4:Boolean) : void
      {
         this.clips.maxCount = param1;
         this.clips.currentCount = param2;
         this.clips.isAutoload = param3;
         this.clips.isDualgun = param4;
         this.updateMarkerSettings();
      }
      
      public function setGroupID(param1:int) : void
      {
         this.groupIcon.groupID = param1;
         this.updateMarkerSettings();
      }
      
      public function setReloading(param1:Number, param2:Number, param3:Number) : void
      {
         if(this.reloadingContext)
         {
            this.reloading.setReloading(param1,param2,param3);
            this.updateMarkerSettings();
         }
      }
      
      public function showSpecialIcon(param1:String) : void
      {
         if(this._isSpecialIconShown)
         {
            this.specialIcon.removeEventListener(Event.COMPLETE,this.onSpecialAnimationHiddenCompleteHandler);
            this.specialIcon.stopAction(false);
         }
         if(param1 != Values.EMPTY_STR)
         {
            this._isSpecialIconShown = true;
            this.specialIcon.showAction(param1);
            this.specialIcon.addEventListener(Event.COMPLETE,this.onSpecialAnimationHiddenCompleteHandler);
            this.currentSpecialIcon = param1;
            this.updateMarkerSettings();
         }
      }
      
      public function stopSpecialIcon(param1:String) : void
      {
         if(this.currentSpecialIcon == param1)
         {
            this.specialIcon.stopAction();
         }
      }
      
      override protected function onStatusAnimationHiddenCompleteHandler(param1:Event) : void
      {
         this._isStatusMarkerShown = false;
         super.onStatusAnimationHiddenCompleteHandler(param1);
      }
      
      private function onActionAnimationHiddenCompleteHandler(param1:Event) : void
      {
         this._isActionMarkerShown = false;
         actionMarker.removeEventListener(Event.COMPLETE,this.onActionAnimationHiddenCompleteHandler);
         this.updateMarkerSettings();
      }
      
      private function onSpecialAnimationHiddenCompleteHandler(param1:Event) : void
      {
         this._isSpecialIconShown = false;
         this.specialIcon.removeEventListener(Event.COMPLETE,this.onSpecialAnimationHiddenCompleteHandler);
         this.updateMarkerSettings();
      }
   }
}
