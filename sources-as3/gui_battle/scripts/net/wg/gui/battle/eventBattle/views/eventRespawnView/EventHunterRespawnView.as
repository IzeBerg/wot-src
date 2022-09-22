package net.wg.gui.battle.eventBattle.views.eventRespawnView
{
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.Time;
   import net.wg.gui.battle.components.preBattleTimer.TimerAnim;
   import net.wg.gui.battle.eventBattle.views.eventPlayersPanel.comps.EventTimerAnimHelper;
   import net.wg.gui.battle.eventBattle.views.eventPlayersPanel.comps.IEventTimerAnimation;
   import net.wg.infrastructure.base.meta.IEventHunterRespawnViewMeta;
   import net.wg.infrastructure.base.meta.impl.EventHunterRespawnViewMeta;
   import net.wg.infrastructure.events.LifeCycleEvent;
   import net.wg.infrastructure.interfaces.IImage;
   
   public class EventHunterRespawnView extends EventHunterRespawnViewMeta implements IEventHunterRespawnViewMeta, IEventTimerAnimation
   {
      
      private static const CONTENT_HEIGHT_BIG:int = 995;
      
      private static const CONTENT_HEIGHT_SMALL:int = 690;
      
      private static const TITLE_FONT_SIZE_BIG:int = 28;
      
      private static const TITLE_FONT_SIZE_SMALL:int = 20;
      
      private static const TIMER_TOP_OFFSET_BIG:int = -80;
      
      private static const TITLE_TOP_OFFSET_BIG:int = 70;
      
      private static const LIFE_TOP_OFFSET_BIG:int = 120;
      
      private static const ICON_TOP_OFFSET_BIG:int = 135;
      
      private static const HINT_TOP_OFFSET_BIG:int = 940;
      
      private static const MINIMAP_OFFSET_X_BIG:int = -12;
      
      private static const MINIMAP_OFFSET_Y_BIG:int = 290;
      
      private static const TIMER_TOP_OFFSET_SMALL:int = -60;
      
      private static const TITLE_TOP_OFFSET_SMALL:int = 38;
      
      private static const ICON_TOP_OFFSET_SMALL:int = 102;
      
      private static const HINT_TOP_OFFSET_SMALL:int = 630;
      
      private static const MINIMAP_OFFSET_X_SMALL:int = -10;
      
      private static const MINIMAP_OFFSET_Y_SMALL:int = 210;
      
      private static const TIMER_LARGE_SCALE:Number = 0.92;
      
      private static const TIMER_SMALL_SCALE:Number = 0.65;
      
      private static const ICON_BG_WIDTH_BIG:int = 642;
      
      private static const ICON_BG_HEIGHT_BIG:int = 142;
      
      private static const ICON_BG_WIDTH_SMALL:int = 420;
      
      private static const ICON_BG_HEIGHT_SMALL:int = 93;
      
      private static const SOUND_STATE:String = "timer_tick";
       
      
      public var timerAnim:TimerAnim = null;
      
      public var titleTF:TextField = null;
      
      public var tankIcon:IImage = null;
      
      public var hint:EventHunterRespawnHint = null;
      
      private var _titleTextFormatBig:TextFormat;
      
      private var _titleTextFormatSmall:TextFormat;
      
      private var _animHelper:EventTimerAnimHelper = null;
      
      private var _lastTimeSecondsLeft:int = -1;
      
      public function EventHunterRespawnView()
      {
         this._titleTextFormatBig = new TextFormat();
         this._titleTextFormatSmall = new TextFormat();
         super();
         this._animHelper = new EventTimerAnimHelper(this);
      }
      
      override protected function onDispose() : void
      {
         this.tankIcon.removeEventListener(Event.CHANGE,this.onTankIconChangeHandler);
         this.tankIcon.dispose();
         this.tankIcon = null;
         this.titleTF = null;
         this.timerAnim.dispose();
         this.timerAnim = null;
         this.hint.dispose();
         this.hint = null;
         this._animHelper.dispose();
         this._animHelper = null;
         this._titleTextFormatBig = null;
         this._titleTextFormatSmall = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.tankIcon.addEventListener(Event.CHANGE,this.onTankIconChangeHandler);
         this._titleTextFormatBig.size = TITLE_FONT_SIZE_BIG;
         this._titleTextFormatSmall.size = TITLE_FONT_SIZE_SMALL;
         this.titleTF.autoSize = TextFieldAutoSize.CENTER;
         this.titleTF.text = EVENT.HUNTERRESPAWN_TIMERTEXT;
         this.mouseEnabled = false;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Rectangle = null;
         var _loc5_:Point = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         super.draw();
         if(minimap && isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = isSmallScreen;
            this.titleTF.setTextFormat(!!_loc1_ ? this._titleTextFormatSmall : this._titleTextFormatBig);
            this.hint.isSmall = _loc1_;
            this.tankIcon.width = !!_loc1_ ? Number(ICON_BG_WIDTH_SMALL) : Number(ICON_BG_WIDTH_BIG);
            this.tankIcon.height = !!_loc1_ ? Number(ICON_BG_HEIGHT_SMALL) : Number(ICON_BG_HEIGHT_BIG);
            this.timerAnim.scaleX = this.timerAnim.scaleY = !!_loc1_ ? Number(TIMER_SMALL_SCALE) : Number(TIMER_LARGE_SCALE);
            this.timerAnim.x = stageWidth >> 1;
            this.titleTF.x = stageWidth - this.titleTF.width >> 1;
            this.tankIcon.x = stageWidth - this.tankIcon.width >> 1;
            this.hint.x = stageWidth - this.hint.width >> 1;
            _loc2_ = !!_loc1_ ? int(CONTENT_HEIGHT_SMALL) : int(CONTENT_HEIGHT_BIG);
            _loc3_ = stageHeight - _loc2_ >> 1;
            this.timerAnim.y = (!!_loc1_ ? TIMER_TOP_OFFSET_SMALL : TIMER_TOP_OFFSET_BIG) + _loc3_;
            this.titleTF.y = (!!_loc1_ ? TITLE_TOP_OFFSET_SMALL : TITLE_TOP_OFFSET_BIG) + _loc3_;
            this.tankIcon.y = (!!_loc1_ ? ICON_TOP_OFFSET_SMALL : ICON_TOP_OFFSET_BIG) + _loc3_;
            this.hint.y = (!!_loc1_ ? HINT_TOP_OFFSET_SMALL : HINT_TOP_OFFSET_BIG) + _loc3_;
            _loc4_ = minimap.getMinimapRectBySizeIndex(minimap.currentSizeIndex);
            _loc5_ = minimap.currentTopLeftPoint;
            _loc6_ = !!_loc1_ ? int(MINIMAP_OFFSET_X_SMALL) : int(MINIMAP_OFFSET_X_BIG);
            _loc7_ = (!!_loc1_ ? MINIMAP_OFFSET_Y_SMALL : MINIMAP_OFFSET_Y_BIG) + _loc3_;
            minimap.x = (stageWidth - _loc4_.width >> 1) - _loc5_.x + _loc6_;
            minimap.y = -_loc5_.y + _loc7_;
            minimap.dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_GRAPHICS_RECTANGLES_UPDATE));
         }
      }
      
      public function as_updateTimer(param1:Number, param2:Number, param3:Number) : void
      {
         this._animHelper.setTime(param1,param2,param3);
         this.timerAnim.ownerVisibleChange(true);
      }
      
      public function as_setIcon(param1:String) : void
      {
         this.tankIcon.source = param1;
      }
      
      public function updateProgress(param1:Number, param2:int) : void
      {
         var _loc3_:int = param2 / Time.MILLISECOND_IN_SECOND;
         this.timerAnim.setTime(_loc3_,false);
         if(this._lastTimeSecondsLeft != _loc3_)
         {
            this._lastTimeSecondsLeft = _loc3_;
            App.soundMgr.playControlsSnd(SOUND_STATE,SoundTypes.WT_EVENT_HUNTER_RESPAWN,null);
         }
      }
      
      override protected function onMinimapDeploymentPointSelect(param1:String) : void
      {
         onRespawnPointClickS(param1);
      }
      
      private function onTankIconChangeHandler(param1:Event) : void
      {
         invalidateSize();
      }
   }
}
