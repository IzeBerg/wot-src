package net.wg.gui.battle.views.damagePanel
{
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.RolesState;
   import net.wg.data.constants.Time;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.VehicleModules;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.views.damagePanel.VO.DamagePanelTooltipVO;
   import net.wg.gui.battle.views.damagePanel.VO.TooltipStringByItemStateVO;
   import net.wg.gui.battle.views.damagePanel.components.DamagePanelItemClickArea;
   import net.wg.gui.battle.views.damagePanel.components.FireIndicator;
   import net.wg.gui.battle.views.damagePanel.components.HealthBar;
   import net.wg.gui.battle.views.damagePanel.components.modules.ModulesCtrl;
   import net.wg.gui.battle.views.damagePanel.components.stunIndicator.StunCounter;
   import net.wg.gui.battle.views.damagePanel.components.tankIndicator.TankIndicator;
   import net.wg.gui.battle.views.damagePanel.components.tankman.TankmenCtrl;
   import net.wg.gui.battle.views.damagePanel.interfaces.IAssetCreator;
   import net.wg.gui.battle.views.damagePanel.interfaces.IDamagePanelClickableItem;
   import net.wg.gui.battle.views.damagePanel.interfaces.IDamagePanelItemsCtrl;
   import net.wg.infrastructure.base.meta.IDamagePanelMeta;
   import net.wg.infrastructure.base.meta.impl.DamagePanelMeta;
   import net.wg.infrastructure.events.LifeCycleEvent;
   import net.wg.infrastructure.managers.IAtlasManager;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.gfx.TextFieldEx;
   
   public class DamagePanel extends DamagePanelMeta implements IDamagePanelMeta
   {
      
      public static const PANEL_WIDTH:int = 230;
      
      public static const LOCK_CHASSIS_ICON_X:int = 134;
      
      public static const LOCK_CHASSIS_ICON_Y:int = 43;
      
      private static const POINTS_STR:String = "..";
      
      private static const LEFT_BRACKET:String = "[";
      
      private static const RIGHT_BRACKET:String = "]";
      
      private static const SPACE_STR:String = " ";
      
      private static const CRUISE_X_POSITION:int = 56;
      
      private static const CRUISE_Y_POSITION:int = 52;
      
      private static const INVALID_CRUISE_STATE:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      private static const OPTIMIZE_OFFSET:int = 5;
      
      private static const CRUISE_STATE_COUNT:int = 6;
      
      private static const STUN_STATUS_ID:int = 0;
      
      private static const BG_HEIGHT_COMPENSATE:int = 7;
      
      private static const LABEL_SIEGE_MODE_DISABLED:String = "disabled";
      
      private static const LABEL_SIEGE_MODE_OFF:String = "off";
      
      private static const LABEL_SIEGE_MODE_ON:String = "on";
      
      private static const YOH_POSTFIX:String = "Yoh";
       
      
      public var playerTF:TextField;
      
      public var vehicleTF:TextField;
      
      public var healthTF:TextField;
      
      public var healthBar:HealthBar;
      
      public var fireIndicator:FireIndicator;
      
      public var speedTF:TextField = null;
      
      public var speedModeIndicator:MovieClip;
      
      public var background:BattleAtlasSprite = null;
      
      public var tankIndicator:TankIndicator;
      
      public var stunCounterMc:StunCounter;
      
      public var stunHitMC:MovieClip;
      
      private var _modulesCtrl:ModulesCtrl;
      
      private var _tankmenCtrl:TankmenCtrl;
      
      private var _cruiseVector:Vector.<Shape>;
      
      private var _cruiseStateShift:int = 2;
      
      private var _speed:int = -1;
      
      private var _cruiseCurrentStateId:int;
      
      private var _cruiseNewStateId:int;
      
      private var _lockChassis:Bitmap;
      
      private var _healthInfo:String = "";
      
      private var _tooltipData:DamagePanelTooltipVO;
      
      private var _clickableAreas:Vector.<DamagePanelItemClickArea>;
      
      private var _isInited:Boolean = false;
      
      private var _isReseted:Boolean = false;
      
      private var _isDestroyed:Boolean = false;
      
      private var _hasWheel:Boolean = false;
      
      private var _playerName:String = "";
      
      private var _clanName:String = "";
      
      private var _regionName:String = "";
      
      private var _vehicleName:String = "";
      
      private var _vehicleNameIsInvalid:Boolean = false;
      
      private var _playerNameIsInvalid:Boolean = false;
      
      private var _healthIsInvalid:Boolean = false;
      
      private var _atlasManager:IAtlasManager;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function DamagePanel()
      {
         this._cruiseVector = new Vector.<Shape>();
         this._cruiseCurrentStateId = this._cruiseStateShift;
         this._cruiseNewStateId = this._cruiseCurrentStateId;
         this._atlasManager = App.atlasMgr;
         this._toolTipMgr = App.toolTipMgr;
         super();
         this._modulesCtrl = new ModulesCtrl();
         this._clickableAreas = new Vector.<DamagePanelItemClickArea>();
         this._tooltipData = new DamagePanelTooltipVO();
         TextFieldEx.setNoTranslate(this.speedTF,true);
         TextFieldEx.setNoTranslate(this.playerTF,true);
         TextFieldEx.setNoTranslate(this.vehicleTF,true);
         TextFieldEx.setNoTranslate(this.healthTF,true);
         this.speedTF.autoSize = TextFieldAutoSize.LEFT;
         initedHeight += BG_HEIGHT_COMPENSATE;
      }
      
      private static function checkTankmanName(param1:String) : Boolean
      {
         var _loc2_:String = null;
         for each(_loc2_ in RolesState.TANKMEN)
         {
            if(param1.indexOf(_loc2_) >= 0)
            {
               return true;
            }
         }
         return false;
      }
      
      override public function getRectangles() : Vector.<Rectangle>
      {
         if(!visible)
         {
            return null;
         }
         var _loc1_:Rectangle = this.background.getBounds(App.stage);
         _loc1_.y += OPTIMIZE_OFFSET;
         _loc1_.width -= OPTIMIZE_OFFSET;
         _loc1_.height -= OPTIMIZE_OFFSET;
         return new <Rectangle>[_loc1_];
      }
      
      override protected function configUI() : void
      {
         var _loc1_:Shape = null;
         super.configUI();
         _loc1_ = null;
         var _loc2_:int = 0;
         while(_loc2_ < CRUISE_STATE_COUNT)
         {
            _loc1_ = new Shape();
            this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,BATTLEATLAS.cruise(_loc2_.toString()),_loc1_.graphics,Values.EMPTY_STR,false,true);
            _loc1_.visible = false;
            _loc1_.x = CRUISE_X_POSITION;
            _loc1_.y = CRUISE_Y_POSITION;
            addChild(_loc1_);
            this._cruiseVector.push(_loc1_);
            _loc2_++;
         }
         this.fireIndicator.addEventListener(MouseEvent.CLICK,this.onFireIndicatorClickHandler);
         this.stunHitMC.addEventListener(MouseEvent.CLICK,this.onStunCounterMcClickHandler);
         TextFieldEx.setVerticalAutoSize(this.playerTF,TextFieldEx.VALIGN_BOTTOM);
         TextFieldEx.setVerticalAutoSize(this.vehicleTF,TextFieldEx.VALIGN_BOTTOM);
         TextFieldEx.setVerticalAutoSize(this.healthTF,TextFieldEx.VALIGN_TOP);
         this.speedModeIndicator.gotoAndStop(LABEL_SIEGE_MODE_DISABLED);
         this.stunHitMC.useHandCursor = this.stunHitMC.buttonMode = true;
         this.stunHitMC.visible = false;
         this.updateSpeed(0);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:Shape = null;
         this.stunHitMC.removeEventListener(MouseEvent.CLICK,this.onStunCounterMcClickHandler);
         this.stunCounterMc.dispose();
         this.stunCounterMc = null;
         this.playerTF = null;
         this.vehicleTF = null;
         this.healthTF = null;
         this.speedTF = null;
         this.speedModeIndicator = null;
         this.background = null;
         this.fireIndicator.removeEventListener(MouseEvent.CLICK,this.onFireIndicatorClickHandler);
         this.fireIndicator.dispose();
         this.fireIndicator = null;
         this.healthBar.dispose();
         this.healthBar = null;
         this.toggleClickableAreas(this._modulesCtrl.getItems(),false);
         this._modulesCtrl.dispose();
         this._modulesCtrl = null;
         this._atlasManager = null;
         this.stunHitMC = null;
         this._toolTipMgr = null;
         for each(_loc1_ in this._cruiseVector)
         {
            removeChild(_loc1_);
         }
         this._cruiseVector.splice(0,this._cruiseVector.length);
         this._cruiseVector = null;
         if(this._lockChassis)
         {
            this._lockChassis.bitmapData.dispose();
            this._lockChassis.bitmapData = null;
            this._lockChassis = null;
         }
         this.tankIndicator.dispose();
         this.tankIndicator = null;
         if(this._tankmenCtrl != null)
         {
            this.toggleClickableAreas(this._tankmenCtrl.getItems(),false);
            this._tankmenCtrl.dispose();
            this._tankmenCtrl = null;
         }
         this._clickableAreas.splice(0,this._clickableAreas.length);
         this._clickableAreas = null;
         this._tooltipData.dispose();
         this._tooltipData = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._isDestroyed)
            {
               this._modulesCtrl.showDestroyed();
               this._tankmenCtrl.showDestroyed();
               this.tankIndicator.showDestroyed();
               this.fireIndicator.state = BATTLE_ITEM_STATES.NORMAL;
            }
            if(this._healthIsInvalid)
            {
               this.healthTF.text = this._healthInfo;
               this._healthIsInvalid = false;
            }
            if(this._playerNameIsInvalid)
            {
               this.customizePlayerNameStr(this._playerName,this._clanName,this._regionName);
               this._playerNameIsInvalid = false;
            }
            if(this._vehicleNameIsInvalid)
            {
               this.vehicleTF.text = this._vehicleName;
               this._vehicleNameIsInvalid = false;
            }
            this.background.imageName = !!this._hasWheel ? BATTLEATLAS.DAMAGE_PANEL_BG_WHEELED : BATTLEATLAS.DAMAGE_PANEL_BG;
         }
         if(isInvalid(INVALID_CRUISE_STATE))
         {
            this._cruiseVector[this._cruiseCurrentStateId].visible = false;
            this._cruiseVector[this._cruiseNewStateId].visible = true;
            this._cruiseCurrentStateId = this._cruiseNewStateId;
         }
      }
      
      override protected function setup(param1:String, param2:int, param3:String, param4:Array, param5:Array, param6:Boolean, param7:Boolean, param8:Boolean, param9:Boolean) : void
      {
         this._hasWheel = param7;
         this.updateHealth(param1,param2);
         if(this._tankmenCtrl != null)
         {
            this.toggleClickableAreas(this._tankmenCtrl.getItems(),false);
            this.changeDisplayListForCtrl(this._tankmenCtrl,false);
            this._tankmenCtrl.dispose();
         }
         if(!param8)
         {
            this.initLockChassis();
            this._lockChassis.visible = !param8;
         }
         this.tankIndicator.isVehicleWithTurret = param6;
         this.tankIndicator.isVehicleWithWheel = this._hasWheel;
         this.tankIndicator.hasYoh = param9;
         this.speedModeIndicator.visible = this._hasWheel;
         this._modulesCtrl.setChassis(this._hasWheel,param9);
         this._modulesCtrl.hasTurretRotator = param6;
         this.changeDisplayListForCtrl(this._modulesCtrl,true);
         this.toggleClickableAreas(this._modulesCtrl.getItems(),true);
         this.updateModuleAssets();
         if(param9)
         {
            param3 += YOH_POSTFIX;
         }
         this.tankIndicator.setRotatorType(param3,param5);
         this._tankmenCtrl = new TankmenCtrl(param4);
         this.changeDisplayListForCtrl(this._tankmenCtrl,true);
         this.toggleClickableAreas(this._tankmenCtrl.getItems(),true);
         this._isInited = true;
         invalidateData();
      }
      
      public function as_hideStatus(param1:int, param2:Boolean) : void
      {
         if(param1 == STUN_STATUS_ID)
         {
            this.stunCounterMc.hideStun(param2);
            this.stunHitMC.visible = false;
         }
         this._tankmenCtrl.hideStatus(param1,param2);
      }
      
      public function as_reset() : void
      {
         if(this._isInited)
         {
            this.fireIndicator.state = BATTLE_ITEM_STATES.NORMAL;
            this._cruiseNewStateId = this._cruiseStateShift;
            invalidate(INVALID_CRUISE_STATE);
            this.tankIndicator.reset();
            this._modulesCtrl.reset();
            this._tankmenCtrl.reset();
            this.speedModeIndicator.gotoAndStop(LABEL_SIEGE_MODE_DISABLED);
            this.updateSpeed(0);
            this.setAutoRotation(true);
            this._isReseted = true;
         }
         this._isDestroyed = false;
      }
      
      public function as_setAutoRotation(param1:Boolean) : void
      {
         this.setAutoRotation(param1);
      }
      
      public function as_setCrewDeactivated() : void
      {
         this.setVehicleDestroyed();
      }
      
      public function as_setCruiseMode(param1:int) : void
      {
         this._cruiseNewStateId = this._cruiseStateShift + param1;
         invalidate(INVALID_CRUISE_STATE);
      }
      
      public function as_setFireInVehicle(param1:Boolean) : void
      {
         this.fireIndicator.state = !!param1 ? BATTLE_ITEM_STATES.CRITICAL : BATTLE_ITEM_STATES.REPAIRED;
      }
      
      public function as_setPlaybackSpeed(param1:Number) : void
      {
         ModulesCtrl(this._modulesCtrl).setPlaybackSpeed(param1);
      }
      
      public function as_setPlayerInfo(param1:String, param2:String, param3:String, param4:String) : void
      {
         if(this._playerName != param1 || this._clanName != param2 || this._regionName != param3)
         {
            this._playerName = param1;
            this._clanName = param2;
            this._regionName = param3;
            this._playerNameIsInvalid = true;
         }
         if(this._vehicleName != param4)
         {
            this._vehicleName = param4;
            this._vehicleNameIsInvalid = true;
         }
         invalidateData();
      }
      
      public function as_setRepairTimesVisible(param1:Boolean) : void
      {
         this._modulesCtrl.setRepairTimesVisible(param1);
      }
      
      public function as_setSpeedMode(param1:Boolean) : void
      {
         if(this.tankIndicator.isVehicleWithWheel)
         {
            this.tankIndicator.setSpeedMode(param1);
            this.speedModeIndicator.gotoAndStop(!!param1 ? LABEL_SIEGE_MODE_ON : LABEL_SIEGE_MODE_OFF);
         }
         else
         {
            this.speedModeIndicator.gotoAndStop(LABEL_SIEGE_MODE_DISABLED);
         }
      }
      
      public function as_setStaticData(param1:String) : void
      {
         this.fireIndicator.text = param1;
      }
      
      public function as_setStatusTimerSnapshot(param1:int, param2:int) : void
      {
         if(param1 == STUN_STATUS_ID)
         {
            this.stunCounterMc.updateStun(param2);
         }
      }
      
      public function as_setVehicleDestroyed() : void
      {
         this.setVehicleDestroyed();
      }
      
      public function as_setupWheeled(param1:int) : void
      {
         this._modulesCtrl.setWheelCount(param1);
         this.tankIndicator.setWheelCount(param1);
      }
      
      public function as_show(param1:Boolean) : void
      {
         this.visible = param1;
      }
      
      public function as_showStatus(param1:int, param2:int, param3:Boolean) : void
      {
         if(param1 == STUN_STATUS_ID)
         {
            this.stunCounterMc.showStun(param2,param3);
            this.stunHitMC.visible = true;
         }
         this._tankmenCtrl.showStatus(param1,param3);
      }
      
      public function as_updateDeviceState(param1:String, param2:String) : void
      {
         if(VehicleModules.checkModuleName(param1))
         {
            this.updateModuleAssets();
            this._modulesCtrl.setState(param1,param2);
            this.tankIndicator.setModuleState(param1,param2);
         }
         else if(checkTankmanName(param1))
         {
            this._tankmenCtrl.setState(param1,param2);
         }
         else
         {
            DebugUtils.LOG_ERROR(param1 + Errors.CANT_NULL);
         }
      }
      
      public function as_updateHealth(param1:String, param2:int) : void
      {
         this.updateHealth(param1,param2);
      }
      
      public function as_updateRepairingDevice(param1:String, param2:int, param3:Number, param4:int) : void
      {
         ModulesCtrl(this._modulesCtrl).setModuleRepairing(param1,param2,param3 * Time.MILLISECOND_IN_SECOND,param4);
      }
      
      public function as_updateSpeed(param1:int) : void
      {
         this.updateSpeed(param1);
      }
      
      private function updateSpeed(param1:int) : void
      {
         if(this._speed == param1)
         {
            return;
         }
         this._speed = param1;
         this.speedTF.text = String(this._speed);
      }
      
      private function customizePlayerNameStr(param1:String, param2:String, param3:String) : String
      {
         var _loc9_:int = 0;
         var _loc4_:int = 2;
         var _loc5_:int = this.playerTF.width - _loc4_;
         var _loc6_:String = param2 != Values.EMPTY_STR ? LEFT_BRACKET + param2 + RIGHT_BRACKET : Values.EMPTY_STR;
         var _loc7_:String = param3 != null ? SPACE_STR + param3 : Values.EMPTY_STR;
         var _loc8_:String = param1 + _loc6_ + _loc7_;
         this.playerTF.text = _loc8_;
         if(_loc5_ < this.playerTF.textWidth)
         {
            _loc8_ = param1 + POINTS_STR + _loc7_;
            this.playerTF.text = _loc8_;
            _loc9_ = param1.length - 1;
            while(_loc5_ < this.playerTF.textWidth && _loc9_ > 0)
            {
               _loc8_ = param1.slice(0,_loc9_) + POINTS_STR + _loc7_;
               this.playerTF.text = _loc8_;
               _loc9_--;
            }
         }
         return _loc8_;
      }
      
      private function setAutoRotation(param1:Boolean) : void
      {
         if(!param1)
         {
            this.initLockChassis();
         }
         if(this._lockChassis != null)
         {
            this._lockChassis.visible = !param1;
         }
      }
      
      private function updateHealth(param1:String, param2:int) : void
      {
         this.healthBar.progress = param2;
         this._healthInfo = param1;
         this._healthIsInvalid = true;
         invalidateData();
      }
      
      private function updateModuleAssets() : void
      {
         if(this._isReseted)
         {
            this._modulesCtrl.updateAvailableAssets();
            this._isReseted = false;
         }
      }
      
      private function getTooltipText(param1:String) : String
      {
         var _loc2_:IAssetCreator = null;
         var _loc3_:Boolean = checkTankmanName(param1);
         var _loc4_:Boolean = VehicleModules.MODULES_LIST.indexOf(param1) >= 0;
         App.utils.asserter.assert(_loc3_ || _loc4_,"Not valid itemName = " + param1);
         if(_loc3_)
         {
            _loc2_ = this._tankmenCtrl.getItemByName(param1);
         }
         else if(_loc4_)
         {
            _loc2_ = this._modulesCtrl.getItemByName(param1);
         }
         var _loc5_:String = _loc2_.state == BATTLE_ITEM_STATES.REPAIRED ? BATTLE_ITEM_STATES.CRITICAL : (_loc2_.state == BATTLE_ITEM_STATES.REPAIRED_FULL ? BATTLE_ITEM_STATES.NORMAL : _loc2_.state);
         var _loc6_:TooltipStringByItemStateVO = this._tooltipData[param1];
         if(_loc6_ == null)
         {
            this._tooltipData[param1] = new TooltipStringByItemStateVO();
            _loc6_ = this._tooltipData[param1];
         }
         var _loc7_:String = _loc6_[_loc5_];
         if(_loc7_ == Values.EMPTY_STR)
         {
            _loc6_[_loc5_] = getTooltipDataS(param1,_loc5_);
            _loc7_ = _loc6_[_loc5_];
         }
         return _loc7_;
      }
      
      private function toggleClickableAreas(param1:Vector.<IDamagePanelClickableItem>, param2:Boolean) : void
      {
         var _loc5_:IDamagePanelClickableItem = null;
         var _loc6_:DamagePanelItemClickArea = null;
         var _loc7_:int = 0;
         var _loc3_:int = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1[_loc4_];
            _loc6_ = _loc5_.mouseEventHitElement;
            if(param2)
            {
               this._clickableAreas.push(_loc6_);
               addChild(_loc6_);
               _loc6_.addEventListener(MouseEvent.CLICK,this.onItemMouseClickHandler);
               _loc6_.addEventListener(MouseEvent.MOUSE_OVER,this.onItemMouseOverHandler);
               _loc6_.addEventListener(MouseEvent.MOUSE_OUT,this.onItemMouseOutHandler);
               _loc6_.visible = true;
               _loc6_.alpha = 0;
            }
            else
            {
               _loc7_ = this._clickableAreas.indexOf(_loc6_);
               if(_loc7_ >= 0)
               {
                  removeChild(_loc6_);
                  _loc6_.removeEventListener(MouseEvent.CLICK,this.onItemMouseClickHandler);
                  _loc6_.removeEventListener(MouseEvent.MOUSE_OVER,this.onItemMouseOverHandler);
                  _loc6_.removeEventListener(MouseEvent.MOUSE_OUT,this.onItemMouseOutHandler);
                  this._clickableAreas.splice(_loc7_,1);
               }
            }
            _loc4_++;
         }
      }
      
      private function initLockChassis() : void
      {
         var _loc1_:Class = null;
         if(this._lockChassis == null)
         {
            _loc1_ = App.utils.classFactory.getClass(Linkages.LOCK_CHASSIS);
            this._lockChassis = new Bitmap(new _loc1_());
            addChild(this._lockChassis);
            this._lockChassis.x = LOCK_CHASSIS_ICON_X;
            this._lockChassis.y = LOCK_CHASSIS_ICON_Y;
         }
      }
      
      private function changeDisplayListForCtrl(param1:IDamagePanelItemsCtrl, param2:Boolean) : void
      {
         var _loc7_:IAssetCreator = null;
         var _loc3_:Vector.<IDamagePanelClickableItem> = param1.getItems();
         var _loc4_:int = _loc3_.length;
         var _loc5_:Vector.<IAssetCreator> = new Vector.<IAssetCreator>();
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_)
         {
            _loc7_ = _loc3_[_loc6_];
            _loc5_.push(_loc7_);
            _loc6_++;
         }
         this.changeItemsInDisplaceList(_loc5_,param2);
      }
      
      private function changeItemsInDisplaceList(param1:Vector.<IAssetCreator>, param2:Boolean) : void
      {
         var _loc5_:IAssetCreator = null;
         var _loc6_:Vector.<DisplayObject> = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:DisplayObject = null;
         var _loc3_:int = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1[_loc4_];
            _loc6_ = _loc5_.getDisplayItems();
            _loc7_ = _loc6_.length;
            _loc8_ = 0;
            while(_loc8_ < _loc7_)
            {
               _loc9_ = _loc6_[_loc8_];
               if(param2)
               {
                  addChild(_loc9_);
               }
               else
               {
                  removeChild(_loc9_);
               }
               _loc8_++;
            }
            _loc4_++;
         }
      }
      
      private function setVehicleDestroyed() : void
      {
         this._isDestroyed = true;
         invalidateData();
         this.updateSpeed(0);
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(super.visible == param1)
         {
            return;
         }
         super.visible = param1;
         mouseChildren = mouseEnabled = param1;
         dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_GRAPHICS_RECTANGLES_UPDATE));
      }
      
      private function onItemMouseOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onItemMouseOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:DamagePanelItemClickArea = DamagePanelItemClickArea(param1.currentTarget);
         this._toolTipMgr.show(this.getTooltipText(_loc2_.itemName));
      }
      
      private function onItemMouseClickHandler(param1:MouseEvent) : void
      {
         var _loc5_:String = null;
         var _loc6_:Boolean = false;
         var _loc2_:DamagePanelItemClickArea = DamagePanelItemClickArea(param1.currentTarget);
         var _loc3_:String = _loc2_.itemName;
         var _loc4_:Boolean = VehicleModules.MODULES_LIST.indexOf(_loc3_) >= 0;
         if(_loc4_)
         {
            if(_loc3_ == VehicleModules.CHASSIS || _loc3_ == VehicleModules.WHEEL)
            {
               _loc5_ = this._modulesCtrl.lastBrokenTrackName;
               if(_loc5_ != Values.EMPTY_STR)
               {
                  _loc3_ = _loc5_;
               }
            }
            clickToDeviceIconS(_loc3_);
         }
         else
         {
            _loc6_ = checkTankmanName(_loc3_);
            if(_loc6_)
            {
               clickToTankmanIconS(_loc3_);
            }
         }
      }
      
      private function onFireIndicatorClickHandler(param1:MouseEvent) : void
      {
         clickToFireIconS();
      }
      
      private function onStunCounterMcClickHandler(param1:MouseEvent) : void
      {
         clickToStunTimerS();
      }
   }
}
