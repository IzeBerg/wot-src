package net.wg.gui.battle.battleRoyale.views.playersPanel
{
   import com.gskinner.motion.GTweener;
   import com.gskinner.motion.easing.Cubic;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   
   public class PlayersPanelItemRenderer extends BattleUIComponent
   {
      
      private static const PLAYER_NAME_X:int = 34;
      
      private static const VEHICLE_LEVEL_X:int = 112;
      
      private static const VEHICLE_TYPE_X:int = 161;
      
      private static const VEHICLE_NAME_X:int = 181;
      
      private static const NO_RESP_X_OFFSET:int = 24;
      
      private static const VEH_TYPE_ALPHA_NORMAL:Number = 0.6;
      
      private static const VEH_TYPE_ALPHA_SPECIAL:Number = 0.8;
      
      private static const RESP_ALPHA_NORMAL:Number = 0.8;
      
      private static const RESP_ALPHA_NONE:Number = 0;
      
      private static const PLAYER_NAME_STR_MAX_LENGTH:int = 14;
      
      private static const PLAYER_NAME_STR_POSTFIX:String = "...";
      
      private static const TWEEN_DURATION:Number = 0.3;
      
      private static const COLOR_WHITE:int = 4291746265;
      
      private static const COLOR_RED:int = 4291694080;
      
      private static const COLOR_YELLOW:int = 4294951779;
      
      private static const FRAME_SMALL:String = "small";
      
      private static const FRAME_NORMAL:String = "normal";
       
      
      public var teamColorBlock:Sprite;
      
      public var teamColorGradient:Sprite;
      
      public var playerNameTF:TextField;
      
      public var vehicleLevelTF:TextField;
      
      public var vehicleTypeIcon:ImageWrapper;
      
      public var vehicleNameTF:TextField;
      
      public var fragsCountTF:TextField;
      
      public var hover:Sprite;
      
      public var deadMC:Sprite;
      
      public var selectedMC:Sprite;
      
      public var hitMC:Sprite;
      
      private var _data:PlayerDataVO = null;
      
      private var _colorSchemeManager:IColorSchemeManager;
      
      private var _isRespawnAvailable:Boolean = true;
      
      private var _isSquadMode:Boolean = false;
      
      private var _isDead:Boolean = false;
      
      public function PlayersPanelItemRenderer()
      {
         this._colorSchemeManager = App.colorSchemeMgr;
         super();
         mouseEnabled = true;
         mouseChildren = false;
         buttonMode = true;
      }
      
      override protected function onDispose() : void
      {
         this.clearTweens();
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this._colorSchemeManager = null;
         this._data = null;
         this.hover = null;
         this.fragsCountTF = null;
         this.vehicleNameTF = null;
         this.vehicleTypeIcon.dispose();
         this.vehicleTypeIcon = null;
         this.vehicleLevelTF = null;
         this.playerNameTF = null;
         this.teamColorBlock = null;
         this.teamColorGradient = null;
         this.hitMC = null;
         this.deadMC = null;
         this.selectedMC = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.hover.visible = false;
         this.deadMC.visible = false;
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         hitArea = this.hitMC;
      }
      
      override protected function draw() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:String = null;
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            _loc1_ = COLOR_WHITE;
            if(!this._data.isAlive)
            {
               _loc1_ = COLOR_RED;
            }
            else if(this._data.isObserved)
            {
               _loc1_ = COLOR_YELLOW;
            }
            this.selectedMC.visible = this._data.isObserved;
            _loc2_ = this._data.playerName;
            if(_loc2_.length > PLAYER_NAME_STR_MAX_LENGTH)
            {
               _loc2_ = _loc2_.substr(0,PLAYER_NAME_STR_MAX_LENGTH);
               _loc2_ += PLAYER_NAME_STR_POSTFIX;
            }
            this.playerNameTF.text = _loc2_;
            this.vehicleLevelTF.text = this._data.vehicleLevel;
            this.vehicleTypeIcon.source = this._data.vehicleTypeIcon;
            this.vehicleNameTF.text = this._data.vehicleName;
            this.fragsCountTF.text = this._data.fragsCount;
            this.playerNameTF.textColor = _loc1_;
            this.vehicleLevelTF.textColor = _loc1_;
            this.vehicleNameTF.textColor = _loc1_;
            this.fragsCountTF.textColor = _loc1_;
            this.vehicleTypeIcon.setTint(_loc1_);
            this.vehicleTypeIcon.alpha = !this._data.isAlive || this._data.isObserved ? Number(VEH_TYPE_ALPHA_SPECIAL) : Number(VEH_TYPE_ALPHA_NORMAL);
            this.updateRespAlpha();
            this.deadMC.visible = this._isDead;
            this.teamColorGradient.visible = !this._isDead && !this.hover.visible && !this._data.isObserved;
         }
         if(isInvalid(InvalidationType.COLOR_SCHEME))
         {
            this.teamColorBlock.transform.colorTransform = this._colorSchemeManager.getTransform(this.colorSchemeName);
            this.teamColorGradient.transform.colorTransform = this._colorSchemeManager.getTransform(this.colorSchemeName);
         }
      }
      
      public function setIsDead(param1:Boolean) : void
      {
         if(this._isDead != param1)
         {
            this._isDead = param1;
            invalidateData();
         }
      }
      
      public function setIsRespawnAvailable(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(this._isRespawnAvailable != param1)
         {
            this.clearTweens();
            this._isRespawnAvailable = param1;
            _loc2_ = !!param1 ? int(PLAYER_NAME_X) : int(PLAYER_NAME_X - NO_RESP_X_OFFSET);
            _loc3_ = !!param1 ? int(VEHICLE_LEVEL_X) : int(VEHICLE_LEVEL_X - NO_RESP_X_OFFSET);
            _loc4_ = !!param1 ? int(VEHICLE_TYPE_X) : int(VEHICLE_TYPE_X - NO_RESP_X_OFFSET);
            _loc5_ = !!param1 ? int(VEHICLE_NAME_X) : int(VEHICLE_NAME_X - NO_RESP_X_OFFSET);
            GTweener.to(this.playerNameTF,TWEEN_DURATION,{"x":_loc2_},{"ease":Cubic.easeOut});
            GTweener.to(this.vehicleLevelTF,TWEEN_DURATION,{"x":_loc3_},{"ease":Cubic.easeOut});
            GTweener.to(this.vehicleTypeIcon,TWEEN_DURATION,{"x":_loc4_},{"ease":Cubic.easeOut});
            GTweener.to(this.vehicleNameTF,TWEEN_DURATION,{"x":_loc5_},{"ease":Cubic.easeOut});
            this.updateRespAlpha();
         }
      }
      
      public function setIsSquadMode(param1:Boolean) : void
      {
         if(this._isSquadMode != param1)
         {
            this._isSquadMode = param1;
            gotoAndStop(!!param1 ? FRAME_SMALL : FRAME_NORMAL);
            invalidateData();
            invalidate(InvalidationType.COLOR_SCHEME);
         }
      }
      
      private function updateRespAlpha() : void
      {
         var _loc1_:Number = this._data.hasRespawn && this._isRespawnAvailable ? Number(RESP_ALPHA_NORMAL) : Number(RESP_ALPHA_NONE);
         dispatchEvent(new RespawnIconEvent(RespawnIconEvent.ALPHA_CHANGE,true,false,this._data.teamIndex,_loc1_));
      }
      
      private function clearTweens() : void
      {
         GTweener.removeTweens(this.playerNameTF);
         GTweener.removeTweens(this.vehicleLevelTF);
         GTweener.removeTweens(this.vehicleTypeIcon);
         GTweener.removeTweens(this.vehicleNameTF);
      }
      
      public function set data(param1:PlayerDataVO) : void
      {
         if(param1 == this._data || param1.isEquals(this._data))
         {
            return;
         }
         this._data = param1;
         invalidateData();
         invalidate(InvalidationType.COLOR_SCHEME);
      }
      
      public function get vehicleID() : int
      {
         return Boolean(this._data) ? int(this._data.vehicleID) : int(Values.DEFAULT_INT);
      }
      
      private function get colorSchemeName() : String
      {
         return "vm_team" + this._data.teamIndex;
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         this.hover.visible = true;
         this.updateRespAlpha();
         invalidateData();
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this.hover.visible = false;
         this.updateRespAlpha();
         invalidateData();
      }
   }
}
