package net.wg.gui.lobby.battleRoyale.widget.data
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.data.constants.SoundManagerStates;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.generated.HANGAR_ALIASES;
   import net.wg.gui.lobby.hangar.alertMessage.AlertMessageBlock;
   import net.wg.infrastructure.base.meta.IBattleRoyaleHangarWidgetMeta;
   import net.wg.infrastructure.base.meta.impl.BattleRoyaleHangarWidgetInjectMeta;
   import net.wg.infrastructure.base.meta.impl.BattleRoyaleHangarWidgetMeta;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.gfx.MouseEventEx;
   
   public class BattleRoyaleHangarWidget extends BattleRoyaleHangarWidgetMeta implements IBattleRoyaleHangarWidgetMeta, IStageSizeDependComponent
   {
      
      private static const BG_NORMAL_Y_OFFSET:int = -1;
      
      private static const ALERT_BG_Y_OFFSET:int = 39;
      
      private static const CONTENT_TOP_PADDING:int = -2;
      
      private static const MARGIN_LEFT:int = 12;
      
      private static const MARGIN_LEFT_SMALL:int = 7;
      
      private static const OUT_LABEL:String = "out";
      
      private static const OVER_LABEL:String = "over";
       
      
      public var calendarStatus:AlertMessageBlock = null;
      
      public var content:BattleRoyaleHangarWidgetInjectMeta = null;
      
      private var _data:BattleRoyaleHangarWidgetVO = null;
      
      private var _isCompactLayout:Boolean = false;
      
      public function BattleRoyaleHangarWidget()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         App.stageSizeMgr.register(this);
         this.content.addEventListener(Event.RESIZE,this.onContentResizeHandler);
         this.content.addEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
         this.content.addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         this.content.addEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
         this.calendarStatus.x = -this.calendarStatus.width >> 1;
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         registerFlashComponent(this.content,HANGAR_ALIASES.BATTLE_ROYALE_HANGAR_WIDGET);
      }
      
      override protected function setData(param1:BattleRoyaleHangarWidgetVO) : void
      {
         this._data = param1;
         this.content.y = !!this._data.showAlert ? Number(ALERT_BG_Y_OFFSET) : Number(BG_NORMAL_Y_OFFSET + CONTENT_TOP_PADDING);
         invalidateData();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            _loc1_ = this.calendarStatus.visible != this._data.showAlert;
            this.calendarStatus.visible = this._data.showAlert;
            this.calendarStatus.setLocalData(this._data.calendarStatus);
            this.calendarStatus.btnClickHandler = onChangeServerClickS;
            if(_loc1_)
            {
               dispatchEvent(new Event(Event.RESIZE));
            }
         }
      }
      
      override protected function onDispose() : void
      {
         stop();
         App.stageSizeMgr.unregister(this);
         this.content.removeEventListener(Event.RESIZE,this.onContentResizeHandler);
         this.content.removeEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
         this.content.removeEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         this.content.removeEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
         this.content = null;
         this.calendarStatus.dispose();
         this.calendarStatus = null;
         if(isFlashComponentRegisteredS(HANGAR_ALIASES.BATTLE_ROYALE_HANGAR_WIDGET))
         {
            unregisterFlashComponent(HANGAR_ALIASES.BATTLE_ROYALE_HANGAR_WIDGET);
         }
         this._data = null;
         super.onDispose();
      }
      
      public function hasAlert() : Boolean
      {
         return this._data && this._data.showAlert;
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         this._isCompactLayout = param2 < StageSizeBoundaries.HEIGHT_900;
         invalidateLayout();
      }
      
      public function startWidgetBlinkAnimation() : void
      {
         this.content.playBlinkAnimationS();
      }
      
      override public function get width() : Number
      {
         return this.content.width;
      }
      
      override public function get height() : Number
      {
         return this.content.height;
      }
      
      override public function get marginLeft() : int
      {
         return !!this._isCompactLayout ? int(MARGIN_LEFT_SMALL) : int(MARGIN_LEFT);
      }
      
      override public function get marginTop() : int
      {
         return this.content.y;
      }
      
      private function onMouseRollOutHandler(param1:MouseEvent) : void
      {
         gotoAndPlay(OUT_LABEL);
      }
      
      private function onMouseRollOverHandler(param1:MouseEvent) : void
      {
         App.soundMgr.playControlsSnd(SoundManagerStates.SND_OVER,SoundTypes.NORMAL_BTN,null);
         gotoAndPlay(OVER_LABEL);
      }
      
      private function onMouseClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:MouseEventEx = param1 as MouseEventEx;
         var _loc3_:uint = _loc2_ == null ? uint(0) : uint(_loc2_.buttonIdx);
         if(_loc3_ == MouseEventEx.LEFT_BUTTON)
         {
            App.soundMgr.playControlsSnd(SoundManagerStates.SND_PRESS,SoundTypes.NORMAL_BTN,null);
            onClickS();
         }
      }
      
      private function onContentResizeHandler(param1:Event) : void
      {
         this.content.x = -this.content.width >> 1;
         dispatchEvent(new Event(Event.RESIZE));
      }
   }
}
