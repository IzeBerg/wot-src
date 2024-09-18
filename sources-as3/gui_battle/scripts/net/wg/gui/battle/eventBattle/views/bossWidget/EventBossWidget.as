package net.wg.gui.battle.eventBattle.views.bossWidget
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.SoundManagerStates;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.eventBattle.views.bossWidget.VO.DAAPIEventBossWidgetVO;
   import net.wg.gui.battle.views.stats.StatsUserProps;
   import net.wg.gui.components.controls.TextFieldContainer;
   import net.wg.infrastructure.base.meta.IEventBossWidgetMeta;
   import net.wg.infrastructure.base.meta.impl.EventBossWidgetMeta;
   import net.wg.infrastructure.managers.ISoundManager;
   import net.wg.utils.ICommons;
   
   public class EventBossWidget extends EventBossWidgetMeta implements IEventBossWidgetMeta
   {
      
      private static const TF_COLOR_WHITE:uint = 16777215;
      
      private static const FRAGS_ICON_OFFSET:int = 9;
      
      private static const INVALIDATE_BOSS_HEALTH:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      private static const INVALIDATE_BOSS_KILLS:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
      
      private static const INVALIDATE_WIDGET_STATE:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 3;
      
      private static const WIDGET_STATE_OFF:String = "stateOff";
      
      private static const WIDGET_STATE_START_SHOW:String = "stateShow";
      
      private static const WIDGET_STATE_SHOWED:String = "stateShowed";
       
      
      public var eventBossShield:EventBossShield = null;
      
      public var playerNameTF:TextFieldContainer = null;
      
      public var hpTF:TextFieldContainer = null;
      
      public var fragsTF:TextFieldContainer = null;
      
      public var fragsAnimContainer:MovieClip = null;
      
      public var fragsIcon:BattleAtlasSprite = null;
      
      public var hpProgressBg:BattleAtlasSprite = null;
      
      public var bossHpProgress:EventBossWidgetMainProgressBar = null;
      
      private var _data:DAAPIEventBossWidgetVO = null;
      
      private var _userProps:StatsUserProps = null;
      
      private var _commons:ICommons = null;
      
      private var _state:String = "stateOff";
      
      private var _soundMgr:ISoundManager;
      
      private var _isWidgetVisible:Boolean = false;
      
      private var _isEndgame:Boolean = false;
      
      public function EventBossWidget()
      {
         this._soundMgr = App.soundMgr;
         super();
         this.visible = false;
         gotoAndStop(WIDGET_STATE_OFF);
         this._commons = App.utils.commons;
      }
      
      public static function playSound(param1:String) : void
      {
         App.soundMgr.playControlsSnd(SoundManagerStates.SND_PRESS,param1,null);
      }
      
      override public function setCompVisible(param1:Boolean) : void
      {
         this._isWidgetVisible = param1;
         if(param1 && this._state == WIDGET_STATE_OFF)
         {
            this._state = WIDGET_STATE_START_SHOW;
            invalidate(INVALIDATE_WIDGET_STATE);
         }
         super.setCompVisible(param1);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.fragsIcon.imageName = BATTLEATLAS.WT_KILLS;
         this.hpProgressBg.imageName = BATTLEATLAS.WT_OUTER_PGB;
         this.hpTF.autoSize = TextFieldAutoSize.RIGHT;
         this.fragsTF.autoSize = TextFieldAutoSize.LEFT;
         this.fragsTF.mouseEnabled = false;
         this.playerNameTF.mouseEnabled = false;
         this.hpTF.mouseEnabled = false;
         this.fragsAnimContainer.addChild(this.fragsTF);
         this.fragsAnimContainer.addChild(this.fragsIcon);
         this.updateColorScheme();
         this.updateLayout();
      }
      
      override protected function onDispose() : void
      {
         this.fragsIcon = null;
         this.bossHpProgress.dispose();
         this.bossHpProgress = null;
         this.hpProgressBg = null;
         this.playerNameTF.dispose();
         this.playerNameTF = null;
         this.fragsTF.dispose();
         this.fragsTF = null;
         this.fragsAnimContainer = null;
         this.hpTF.dispose();
         this.hpTF = null;
         this.fragsIcon = null;
         this._data = null;
         this._commons = null;
         if(this._userProps)
         {
            this._userProps.dispose();
            this._userProps = null;
         }
         this._soundMgr = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.updateUserProps(this._data);
               this.updateHpData();
               this.updateKills();
               this.updateColorScheme();
               invalidateSize();
            }
            if(isInvalid(INVALIDATE_BOSS_HEALTH))
            {
               this.updateHpData();
            }
            if(isInvalid(INVALIDATE_BOSS_KILLS))
            {
               this.updateKills();
            }
            if(isInvalid(INVALIDATE_WIDGET_STATE))
            {
               this.updateState();
            }
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateLayout();
         }
      }
      
      override protected function setWidgetData(param1:DAAPIEventBossWidgetVO) : void
      {
         this._data = param1;
         invalidate(InvalidationType.DATA);
      }
      
      public function as_updateDebuff(param1:Number, param2:Number) : void
      {
         if(this._isEndgame)
         {
            return;
         }
         var _loc3_:Boolean = Math.round(param2) > 0;
         if(_loc3_)
         {
            this.eventBossShield.setShieldOffline();
            this.eventBossShield.eventGeneratorBar.setShieldOffline();
            this.eventBossShield.eventGeneratorBar.updateShieldDownTimer(param2);
         }
         else
         {
            this.eventBossShield.setShieldOnline();
            this.eventBossShield.eventGeneratorBar.setShieldOnline();
         }
         if(this._data.hpCurrent <= 0)
         {
            return;
         }
         this.showDebuffProgressBar(_loc3_);
      }
      
      public function as_resetGeneratorCaptureTimer(param1:int) : void
      {
         this.eventBossShield.eventGeneratorBar.resetGeneratorTimer(param1);
      }
      
      public function as_updateGenerators(param1:Number) : void
      {
         this._isEndgame = param1 == 0;
         if(this._isEndgame)
         {
            this.showDebuffProgressBar(this._isEndgame);
            this.eventBossShield.setShieldOffline();
            this.eventBossShield.eventGeneratorBar.setShieldEndgame();
         }
      }
      
      public function as_updateGeneratorsCharging(param1:int, param2:Number) : void
      {
         this.eventBossShield.eventGeneratorBar.updateGeneratorTimer(param1,param2);
      }
      
      public function as_updateHp(param1:Number) : void
      {
         if(this._data != null)
         {
            this._data.hpCurrent = param1;
            invalidate(INVALIDATE_BOSS_HEALTH);
         }
      }
      
      public function as_updateKills(param1:Number) : void
      {
         if(this._data != null)
         {
            this._data.kills = param1;
            invalidate(INVALIDATE_BOSS_KILLS);
         }
      }
      
      private function formatNumberWithSeparator(param1:int, param2:String = " ") : String
      {
         return param1.toString().replace(/\B(?=(\d{3})+(?!\d))/g,param2);
      }
      
      private function updateLayout() : void
      {
         this.fragsIcon.x = this.playerNameTF.x + this.playerNameTF.textField.textWidth + FRAGS_ICON_OFFSET;
         this.fragsTF.x = this.fragsIcon.x + this.fragsIcon.width;
         dispatchEvent(new Event(Event.RESIZE));
      }
      
      private function updateHpData() : void
      {
         this.hpTF.label = this.formatNumberWithSeparator(this._data.hpCurrent) + " / " + this.formatNumberWithSeparator(this._data.hpMax);
         this.bossHpProgress.value = EventProgressBar.getProgress(this._data.hpMax,this._data.hpCurrent);
      }
      
      private function updateKills() : void
      {
         this.fragsTF.label = this._data.kills.toString();
      }
      
      private function updateState() : void
      {
         if(this._state == WIDGET_STATE_START_SHOW)
         {
            playSound(SoundTypes.WT_EVENT_BOSS_PROGRESS_BAR_SHOW);
            gotoAndPlay(WIDGET_STATE_START_SHOW);
            this._state = WIDGET_STATE_SHOWED;
         }
      }
      
      private function updateColorScheme() : void
      {
         if(this._data != null)
         {
            if(this._data.isSpecial)
            {
               this.eventBossShield.eventBossTankIcon.setSpecialTank();
               this.eventBossShield.eventBossBackground.setSpecialTank();
            }
         }
         this.playerNameTF.textColor = TF_COLOR_WHITE;
         this.fragsTF.textColor = TF_COLOR_WHITE;
      }
      
      private function updateUserProps(param1:DAAPIEventBossWidgetVO) : void
      {
         if(!this._userProps)
         {
            this._userProps = new StatsUserProps(param1.playerName,param1.playerFakeName,param1.clanAbbrev,param1.region,0);
         }
         else
         {
            this._userProps.userName = param1.playerName;
            this._userProps.fakeName = param1.playerFakeName;
            this._userProps.clanAbbrev = param1.clanAbbrev;
            this._userProps.region = param1.region;
         }
         if(this._userProps.isChanged)
         {
            this._userProps.applyChanges();
            this.setPlayerNameProps();
         }
      }
      
      private function setPlayerNameProps() : void
      {
         this._commons.formatPlayerName(this.playerNameTF.textField,this._userProps,!this._data.isPlayer,this._data.isPlayer);
      }
      
      private function showDebuffProgressBar(param1:Boolean) : void
      {
         this.bossHpProgress.isDebuff = param1;
      }
      
      public function as_updateHyperionCharge(param1:Number, param2:Number) : void
      {
         this.eventBossShield.updateHyperionCharge(param1,param2);
      }
      
      public function as_lockGenerator(param1:int, param2:Boolean) : void
      {
         this.eventBossShield.eventGeneratorBar.lockGenerator(param1,param2);
      }
   }
}
