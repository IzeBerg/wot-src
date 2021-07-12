package net.wg.gui.battle.battleRoyale.views
{
   import flash.geom.ColorTransform;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.interfaces.IColorScheme;
   import scaleform.clik.controls.StatusIndicator;
   import scaleform.gfx.TextFieldEx;
   
   public class BattleRoyaleTeamPanelListItem extends BattleUIComponent
   {
      
      private static const PROGRESS_BAR_MAX_VAL:uint = 100;
      
      private static const CLAN_NAME_TF_OFFSET:uint = 1;
      
      private static const PLAYER_AND_CLAN_NAME_TF_MAX_WIDTH:uint = 160;
      
      private static const BR_SQUAD_DEAD_COLOR_SCHEME_NAME:String = "br_squad_dead";
      
      private static const NOT_READY_STATUS_ALPHA:Number = 0.5;
       
      
      public var fragsTF:TextField = null;
      
      public var playerNameTF:TextField = null;
      
      public var clanNameTF:TextField = null;
      
      public var vehicleLevelTF:TextField = null;
      
      public var vehicleIcon:Image = null;
      
      public var progressBar:StatusIndicator = null;
      
      private var _playerName:String = "";
      
      private var _clanName:String = "";
      
      private var _isAlive:Boolean = true;
      
      private var _isReady:Boolean = true;
      
      public function BattleRoyaleTeamPanelListItem()
      {
         super();
         this.fragsTF.selectable = this.fragsTF.mouseWheelEnabled = this.fragsTF.mouseEnabled = false;
         this.playerNameTF.selectable = this.playerNameTF.mouseWheelEnabled = this.playerNameTF.mouseEnabled = false;
         this.clanNameTF.selectable = this.clanNameTF.mouseWheelEnabled = this.clanNameTF.mouseEnabled = false;
         this.vehicleLevelTF.selectable = this.vehicleLevelTF.mouseWheelEnabled = this.vehicleLevelTF.mouseEnabled = false;
         this.progressBar.minimum = Values.ZERO;
         this.progressBar.maximum = PROGRESS_BAR_MAX_VAL;
         this.clanNameTF.autoSize = TextFieldAutoSize.LEFT;
         TextFieldEx.setNoTranslate(this.playerNameTF,true);
         TextFieldEx.setNoTranslate(this.clanNameTF,true);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.POSITION))
         {
            if(this.playerNameTF.textWidth + this.clanNameTF.textWidth > PLAYER_AND_CLAN_NAME_TF_MAX_WIDTH)
            {
               this.playerNameTF.width = PLAYER_AND_CLAN_NAME_TF_MAX_WIDTH - this.clanNameTF.textWidth;
               App.utils.commons.truncateTextFieldText(this.playerNameTF,this._playerName,true);
            }
            else
            {
               App.utils.commons.updateTextFieldSize(this.playerNameTF,true,false);
            }
            this.clanNameTF.x = this.playerNameTF.textWidth + CLAN_NAME_TF_OFFSET | 0;
         }
         if(isInvalid(InvalidationType.STATE))
         {
            this.applyState();
         }
      }
      
      override protected function onDispose() : void
      {
         this.fragsTF = null;
         this.playerNameTF = null;
         this.clanNameTF = null;
         this.vehicleLevelTF = null;
         this.vehicleIcon = null;
         this.progressBar.dispose();
         this.progressBar = null;
         super.onDispose();
      }
      
      public function setAlive(param1:Boolean) : void
      {
         if(this._isAlive == param1)
         {
            return;
         }
         this._isAlive = param1;
         invalidateState();
      }
      
      public function setClanName(param1:String) : void
      {
         if(this._clanName == param1)
         {
            return;
         }
         this._clanName = param1;
         this.clanNameTF.text = param1;
         invalidatePosition();
      }
      
      public function setFrags(param1:String) : void
      {
         this.fragsTF.text = param1;
      }
      
      public function setPlayerName(param1:String) : void
      {
         if(this._playerName == param1)
         {
            return;
         }
         this._playerName = param1;
         this.playerNameTF.text = param1;
         invalidatePosition();
      }
      
      public function setProgress(param1:int) : void
      {
         this.progressBar.value = param1;
      }
      
      public function setReady(param1:Boolean) : void
      {
         if(this._isReady == param1)
         {
            return;
         }
         this._isReady = param1;
         invalidateState();
      }
      
      public function setVehicleIcon(param1:String) : void
      {
         this.vehicleIcon.source = param1;
      }
      
      public function setVehicleLevel(param1:String) : void
      {
         this.vehicleLevelTF.text = param1;
      }
      
      private function applyState() : void
      {
         var _loc3_:IColorScheme = null;
         var _loc1_:ColorTransform = null;
         if(!this._isAlive)
         {
            _loc3_ = App.colorSchemeMgr.getScheme(BR_SQUAD_DEAD_COLOR_SCHEME_NAME);
            if(_loc3_)
            {
               _loc1_ = _loc3_.colorTransform;
            }
         }
         this.fragsTF.transform.colorTransform = _loc1_;
         this.playerNameTF.transform.colorTransform = _loc1_;
         this.clanNameTF.transform.colorTransform = _loc1_;
         this.vehicleLevelTF.transform.colorTransform = _loc1_;
         this.vehicleIcon.transform.colorTransform = _loc1_;
         var _loc2_:Number = !this._isReady || !this._isAlive ? Number(NOT_READY_STATUS_ALPHA) : Number(Values.DEFAULT_ALPHA);
         alpha = _loc2_;
      }
   }
}
