package net.wg.white_tiger.gui.battle.views.wtPlayersPanel
{
   import flash.display.MovieClip;
   import flash.filters.DropShadowFilter;
   import flash.geom.ColorTransform;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.constants.PlayersPanelInvalidationType;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.list.PlayersPanelListItem;
   import net.wg.gui.components.controls.VO.BadgeVisualVO;
   import net.wg.white_tiger.gui.battle.views.shared.HunterResurrectTimer;
   import net.wg.white_tiger.gui.battle.views.wtPlayersPanel.comps.BotHealthBar;
   
   public class HunterPanelListItem extends PlayersPanelListItem implements IHunterPanelListItem
   {
      
      private static const WIDTH_LEFT:int = 231;
      
      private static const WIDTH_RIGHT:int = 206;
      
      private static const ALLY_COLOR:uint = 16777215;
      
      private static const ALLY_DEAD_COLOR:uint = 8553090;
      
      private static const PLAYER_COLOR:uint = 15775583;
      
      private static const TEXT_NORMAL_ALPHA:Number = 1;
      
      private static const PLAYER_TEXT_DEAD_ALPHA:Number = 0.8;
      
      private static const ICON_NORMAL_ALPHA:Number = 1;
      
      private static const ICON_DEAD_ALPHA:Number = 0.5;
      
      public static const NORMAL_COLOR_TRANSFORM:ColorTransform = new ColorTransform(4,4,4,0.8,0,0,0,0);
      
      public static const RESURRECT_COLOR_TRANSFORM:ColorTransform = new ColorTransform(0.5,0.5,0.5,1,179,0,0,0);
      
      private static const RESURRECT_ICON_FILTERS:Array = [new DropShadowFilter(0,0,26214,1,1,1,2,1,false,false),new DropShadowFilter(0,0,65535,1,4,4,1,1,false,false),new DropShadowFilter(0,0,65535,1,8,8,1,1,false,false)];
       
      
      public var resurrectTimer:HunterResurrectTimer = null;
      
      public var healthBar:BotHealthBar = null;
      
      public var plasmaBar:MovieClip = null;
      
      private var _isResurrect:Boolean = false;
      
      private var _plasma:int = 0;
      
      public function HunterPanelListItem()
      {
         super();
         this.resurrectTimer.visible = false;
         chatCommandState.visible = false;
      }
      
      override public function setBadge(param1:BadgeVisualVO, param2:Boolean) : void
      {
      }
      
      override public function setChatCommand(param1:String, param2:uint) : void
      {
      }
      
      override public function setChatCommandVisibility(param1:Boolean) : void
      {
      }
      
      override public function setVehicleHealth(param1:int) : void
      {
         this.healthBar.showHp(param1 / 100);
      }
      
      override public function setVehicleName(param1:String) : void
      {
      }
      
      override public function triggerChatCommand(param1:String) : void
      {
      }
      
      override protected function onDispose() : void
      {
         playerNameFullTF.filters = playerNameCutTF.filters = fragsTF.filters = null;
         vehicleIcon.transform.colorTransform = null;
         vehicleIcon.filters = null;
         this.resurrectTimer.dispose();
         this.resurrectTimer = null;
         this.healthBar.dispose();
         this.healthBar = null;
         this.plasmaBar = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.resurrectTimer.mouseEnabled = this.resurrectTimer.mouseChildren = false;
         this.resurrectTimer.finishCallback = this.onRespawnTimerFinished;
         this.healthBar.mouseEnabled = this.healthBar.mouseChildren = false;
         var _loc1_:int = !!isRightAligned ? int(WIDTH_RIGHT) : int(WIDTH_LEFT);
         this.healthBar.width = bg.width = deadBg.width = _loc1_;
      }
      
      override protected function setupBackgrounds() : void
      {
         bg.imageName = BATTLEATLAS.EVENT_PLAYERS_PANEL_BG;
         deadBg.imageName = BATTLEATLAS.EVENT_PLAYERS_PANEL_DEAD_BG;
         deadBg.visible = false;
      }
      
      override protected function updateColors() : void
      {
         vehicleIcon.alpha = ICON_NORMAL_ALPHA;
         vehicleIcon.transform.colorTransform = null;
         vehicleIcon.filters = null;
         playerNameFullTF.filters = playerNameCutTF.filters = fragsTF.filters = null;
         var _loc1_:Boolean = isCurrentPlayer;
         var _loc2_:uint = !!_loc1_ ? uint(PLAYER_COLOR) : uint(ALLY_COLOR);
         var _loc3_:Number = TEXT_NORMAL_ALPHA;
         if(this._isResurrect)
         {
            vehicleIcon.transform.colorTransform = RESURRECT_COLOR_TRANSFORM;
            vehicleIcon.filters = RESURRECT_ICON_FILTERS;
         }
         else if(isAlive)
         {
            vehicleIcon.transform.colorTransform = NORMAL_COLOR_TRANSFORM;
         }
         else
         {
            _loc2_ = !!_loc1_ ? uint(PLAYER_COLOR) : uint(ALLY_DEAD_COLOR);
            _loc3_ = !!_loc1_ ? Number(PLAYER_TEXT_DEAD_ALPHA) : Number(TEXT_NORMAL_ALPHA);
            vehicleIcon.alpha = ICON_DEAD_ALPHA;
         }
         playerNameFullTF.textColor = playerNameCutTF.textColor = fragsTF.textColor = _loc2_;
         playerNameFullTF.alpha = playerNameCutTF.alpha = fragsTF.alpha = _loc3_;
      }
      
      override protected function updatePositions() : void
      {
      }
      
      override protected function updatePositionsRight() : void
      {
      }
      
      override protected function updatePositionsLeft() : void
      {
      }
      
      override protected function updateSelfState() : void
      {
      }
      
      override protected function updateBgState() : void
      {
         bg.visible = true;
         deadBg.visible = !isAlive;
         this.healthBar.visible = isAlive;
      }
      
      public function setPlasma(param1:int) : void
      {
         if(this.plasmaBar == null || this._plasma == param1)
         {
            return;
         }
         this._plasma = param1;
         this.plasmaBar.gotoAndStop(param1 + 1);
      }
      
      public function setResurrect(param1:Number, param2:Number, param3:Number) : void
      {
         if(param1 > 0)
         {
            this.resurrectTimer.updateTime(param1,param2,param3);
            this.isResurrect = true;
         }
         else
         {
            this.isResurrect = false;
         }
         invalidate(PlayersPanelInvalidationType.ALIVE | PlayersPanelInvalidationType.PLAYER_SCHEME);
      }
      
      private function onRespawnTimerFinished() : void
      {
         this.isResurrect = false;
      }
      
      private function set isResurrect(param1:Boolean) : void
      {
         if(this._isResurrect != param1)
         {
            this._isResurrect = param1;
            this.resurrectTimer.visible = param1;
            this.plasmaBar.visible = !param1;
            invalidate(PlayersPanelInvalidationType.PLAYER_SCHEME);
         }
      }
   }
}
