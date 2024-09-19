package net.wg.gui.battle.eventBattle.views.miniBossWidget
{
   import flash.events.Event;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.SoundManagerStates;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.eventBattle.views.bossWidget.EventProgressBar;
   import net.wg.gui.battle.eventBattle.views.bossWidget.VO.DAAPIEventBossWidgetVO;
   import net.wg.gui.components.controls.TextFieldContainer;
   import net.wg.infrastructure.base.meta.IEventMiniBossWidgetMeta;
   import net.wg.infrastructure.base.meta.impl.EventMiniBossWidgetMeta;
   import net.wg.infrastructure.managers.ISoundManager;
   
   public class EventMiniBossWidget extends EventMiniBossWidgetMeta implements IEventMiniBossWidgetMeta
   {
      
      private static const TF_COLOR_WHITE:uint = 16777215;
      
      private static const TF_COLOR_GREY:uint = 9211006;
      
      private static const INVALIDATE_WIDGET_STATE:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 3;
      
      private static const WIDGET_STATE_OFF:String = "stateOff";
      
      private static const WIDGET_STATE_START_SHOW:String = "stateShow";
      
      private static const WIDGET_STATE_SHOWED:String = "stateShowed";
       
      
      public var miniBossNameTF:TextFieldContainer = null;
      
      public var miniBossHpProgress:EventBossWidgetMiniBossProgressBar = null;
      
      public var miniBossHealthTF:TextFieldContainer = null;
      
      private var _data:DAAPIEventBossWidgetVO = null;
      
      private var _state:String = "stateOff";
      
      private var _hpMax:Number = 0;
      
      private var _hpCurrent:Number = 0;
      
      private var _isEnemy:Boolean = false;
      
      private var _soundMgr:ISoundManager;
      
      private var _isWidgetVisible:Boolean = false;
      
      public function EventMiniBossWidget()
      {
         this._soundMgr = App.soundMgr;
         super();
         this.visible = false;
         this.alpha = 0;
         gotoAndStop(WIDGET_STATE_OFF);
      }
      
      public static function playSound(param1:String) : void
      {
         App.soundMgr.playControlsSnd(SoundManagerStates.SND_PRESS,param1,null);
      }
      
      override public function setCompVisible(param1:Boolean) : void
      {
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
         this.miniBossNameTF.textColor = TF_COLOR_WHITE;
         this.miniBossHealthTF.textColor = TF_COLOR_WHITE;
         this.updateLayout();
      }
      
      override protected function onDispose() : void
      {
         this.miniBossHpProgress.dispose();
         this.miniBossHpProgress = null;
         this.miniBossNameTF.dispose();
         this.miniBossNameTF = null;
         this.miniBossHealthTF.dispose();
         this.miniBossHealthTF = null;
         this._data = null;
         this._soundMgr = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:uint = 0;
         super.draw();
         if(this._data != null)
         {
            if(isInvalid(INVALIDATE_WIDGET_STATE))
            {
               this.updateState();
            }
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateLayout();
         }
         if(isInvalid(InvalidationType.STATE))
         {
            this.alpha = !!this._isWidgetVisible ? Number(1) : Number(0);
         }
         if(isInvalid(InvalidationType.DATA))
         {
            this.miniBossHealthTF.textField.text = this._hpCurrent + " / " + this._hpMax;
            _loc1_ = this._hpCurrent > 0 ? uint(TF_COLOR_WHITE) : uint(TF_COLOR_GREY);
            this.miniBossHealthTF.textColor = _loc1_;
            this.miniBossNameTF.textColor = _loc1_;
            this.miniBossHealthTF.textField.filters = filters;
            this.miniBossNameTF.textField.filters = filters;
         }
      }
      
      public function as_updateMiniBossHp(param1:Number) : void
      {
         this._hpCurrent = param1;
         this.miniBossHpProgress.hpCurrent = param1;
         this.miniBossHpProgress.value = EventProgressBar.getProgress(this.miniBossHpProgress.hpMax,this.miniBossHpProgress.hpCurrent);
         this.miniBossHpProgress.updateProgressBars();
         this.invalidateData();
      }
      
      public function as_setMiniBossWidgetData(param1:String, param2:Number, param3:Number, param4:Boolean) : void
      {
         this.miniBossNameTF.textField.text = param1;
         this.miniBossHpProgress.updateData(param2,param3,param4);
         this._isWidgetVisible = true;
         this._hpCurrent = param2;
         this._hpMax = param3;
         this._isEnemy = param4;
         this.miniBossHpProgress.hpMax = param3;
         this.invalidateState();
         this.invalidateData();
      }
      
      public function as_resetMiniBossWidget() : void
      {
         this._isWidgetVisible = false;
         this._hpCurrent = Values.ZERO;
         this._hpMax = Values.ZERO;
         this._isEnemy = false;
         invalidateState();
         invalidateData();
      }
      
      private function updateLayout() : void
      {
         dispatchEvent(new Event(Event.RESIZE));
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
   }
}
