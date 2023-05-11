package net.wg.gui.battle.battleRoyale.views.playersPanel
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   
   public class PlayersPanelItemRenderer extends BattleUIComponent
   {
      
      private static const ALIVE_ALPHA:Number = 1;
      
      private static const DEAD_ALPHA:Number = 0.65;
      
      private static const ALIVE_FRAME_LABEL:String = "alive";
      
      private static const DEAD_FRAME_LABEL:String = "dead";
      
      private static const OBSERVED_FRAME_LABEL:String = "selected";
      
      private static const PLAYER_NAME_STR_MAX_LENGTH:int = 14;
      
      private static const PLAYER_NAME_STR_POSTFIX:String = "...";
       
      
      public var teamColorBlock:Sprite;
      
      public var playerNameTF:TextField;
      
      public var vehicleLevelTF:TextField;
      
      public var vehicleTypeIcon:Image;
      
      public var vehicleNameTF:TextField;
      
      public var fragsCountTF:TextField;
      
      public var hover:Sprite;
      
      private var _data:PlayerDataVO = null;
      
      private var _colorSchemeManager:IColorSchemeManager;
      
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
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            if(this._data.isObserved)
            {
               gotoAndStop(OBSERVED_FRAME_LABEL);
            }
            else if(this._data.isAlive)
            {
               gotoAndStop(ALIVE_FRAME_LABEL);
            }
            else
            {
               gotoAndStop(DEAD_FRAME_LABEL);
            }
            this.teamColorBlock.transform.colorTransform = this._colorSchemeManager.getTransform(this.colorSchemeName);
            _loc1_ = this._data.playerName;
            if(_loc1_.length > PLAYER_NAME_STR_MAX_LENGTH)
            {
               _loc1_ = _loc1_.substr(0,PLAYER_NAME_STR_MAX_LENGTH);
               _loc1_ += PLAYER_NAME_STR_POSTFIX;
            }
            this.playerNameTF.text = _loc1_;
            this.vehicleLevelTF.text = this._data.vehicleLevel;
            this.vehicleTypeIcon.source = this._data.vehicleTypeIcon;
            this.vehicleNameTF.text = this._data.vehicleName;
            this.fragsCountTF.text = this._data.fragsCount;
            alpha = !!this._data.isAlive ? Number(ALIVE_ALPHA) : Number(DEAD_ALPHA);
         }
      }
      
      public function set data(param1:PlayerDataVO) : void
      {
         if(param1 == this._data)
         {
            return;
         }
         this._data = param1;
         invalidateData();
      }
      
      public function get vehicleID() : int
      {
         if(!this._data)
         {
            return -1;
         }
         return this._data.vehicleID;
      }
      
      private function get colorSchemeName() : String
      {
         return "vm_team" + this._data.teamIndex;
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         this.hover.visible = true;
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this.hover.visible = false;
      }
   }
}
