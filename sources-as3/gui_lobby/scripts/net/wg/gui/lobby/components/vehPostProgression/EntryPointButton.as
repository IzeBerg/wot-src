package net.wg.gui.lobby.components.vehPostProgression
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import net.wg.data.constants.SoundManagerStates;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.POSTPROGRESSION_CONSTS;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.ITutorialCustomComponent;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.IScheduler;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.gfx.MouseEventEx;
   
   public class EntryPointButton extends UIComponentEx implements ITutorialCustomComponent
   {
      
      private static const LETTER_SPACING:Number = 1.8;
      
      private static const ICON_GAP:int = -2;
      
      private static const PADDING:int = 8;
      
      private static const FRAME_LABEL_LOCKED:String = "locked";
      
      private static const FRAME_LABEL_SHOW_UNLOCK:String = "unlock";
      
      private static const FRAME_LABEL_UNLOCKED:String = "unlocked";
      
      private static const LABEL_Y_OFFSET:int = 1;
      
      private static const OFFSET_TO_FIX_LINES_BLUR:Number = 0.25;
      
      private static const MIN_WIDTH:Number = 47;
      
      private static const CLICK_LOCK_DURATION:int = 500;
       
      
      public var bg:EntryPointBg = null;
      
      public var label:TextField = null;
      
      public var icon:Sprite = null;
      
      public var lockIcon:MovieClip = null;
      
      private var _state:int = -1;
      
      private var _showUnlock:Boolean = false;
      
      private var _isSmall:Boolean = false;
      
      private var _isSoundEnabled:Boolean = false;
      
      private var _isClickLocked:Boolean = false;
      
      private var _tooltip:String = "";
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _scheduler:IScheduler;
      
      public function EntryPointButton()
      {
         this._tooltipMgr = App.toolTipMgr;
         this._scheduler = App.utils.scheduler;
         super();
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.CLICK,this.onClickHandler);
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.bg.dispose();
         this.bg = null;
         this.label = null;
         this.icon = null;
         this.lockIcon = null;
         this._tooltipMgr = null;
         this._scheduler.cancelTask(this.unlockClick);
         this._scheduler = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.label.autoSize = TextFieldAutoSize.CENTER;
         this.label.text = VEH_POST_PROGRESSION.RESEARCHENTRY_TITLE;
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.letterSpacing = LETTER_SPACING;
         this.label.setTextFormat(_loc1_);
         App.utils.commons.updateTextFieldSize(this.label);
         this.bg.x = OFFSET_TO_FIX_LINES_BLUR;
         this.bg.y = OFFSET_TO_FIX_LINES_BLUR;
         addEventListener(MouseEvent.CLICK,this.onClickHandler);
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         mouseChildren = false;
         buttonMode = true;
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._showUnlock)
            {
               this.lockIcon.gotoAndPlay(FRAME_LABEL_SHOW_UNLOCK);
               this._showUnlock = false;
            }
            else
            {
               this.lockIcon.gotoAndStop(this._state == POSTPROGRESSION_CONSTS.RESEARCH_STATE_LOCKED ? FRAME_LABEL_LOCKED : FRAME_LABEL_UNLOCKED);
            }
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            if(this._isSmall)
            {
               _loc1_ = MIN_WIDTH;
            }
            else
            {
               _loc1_ = this.icon.width + ICON_GAP + this.label.width + 2 * PADDING;
               this.icon.x = PADDING;
               this.label.x = this.icon.x + this.icon.width + ICON_GAP;
            }
            this.label.visible = !this._isSmall;
            this.icon.y = _height - this.icon.height >> 1;
            this.label.y = (_height - this.label.height >> 1) + LABEL_Y_OFFSET;
            this.bg.setSize(_loc1_,_height);
            if(this.lockIcon.visible)
            {
               this.lockIcon.x = _loc1_ >> 1;
               this.lockIcon.y = _height;
            }
         }
      }
      
      public function generatedUnstoppableEvents() : Boolean
      {
         return true;
      }
      
      public function getTutorialDescriptionName() : String
      {
         return null;
      }
      
      public function needPreventInnerEvents() : Boolean
      {
         return false;
      }
      
      public function showUnlockAnimation() : void
      {
         this._showUnlock = true;
         invalidateData();
      }
      
      private function unlockClick() : void
      {
         this._isClickLocked = false;
      }
      
      override public function get width() : Number
      {
         return this.bg.width;
      }
      
      override public function get height() : Number
      {
         return this.bg.height;
      }
      
      public function set isSmall(param1:Boolean) : void
      {
         if(this._isSmall != param1)
         {
            this._isSmall = param1;
            invalidateSize();
         }
      }
      
      public function set state(param1:int) : void
      {
         if(this._state != param1 || !this._showUnlock)
         {
            this._state = param1;
            this._showUnlock = false;
            invalidateData();
         }
      }
      
      public function set isHoverState(param1:Boolean) : void
      {
         this.bg.isHoverState = param1;
      }
      
      public function set tooltip(param1:String) : void
      {
         this._tooltip = param1;
      }
      
      public function set isSoundEnabled(param1:Boolean) : void
      {
         this._isSoundEnabled = param1;
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         if(this._isClickLocked)
         {
            return;
         }
         dispatchEvent(new ButtonEvent(ButtonEvent.CLICK,true,false,0,MouseEventEx(param1).buttonIdx));
         this._isClickLocked = true;
         this._tooltipMgr.hide();
         if(this._isSoundEnabled)
         {
            App.soundMgr.playControlsSnd(SoundManagerStates.SND_PRESS,SoundTypes.NORMAL_BTN,null);
         }
         this._scheduler.scheduleTask(this.unlockClick,CLICK_LOCK_DURATION);
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         this.isHoverState = true;
         if(this._isSoundEnabled)
         {
            App.soundMgr.playControlsSnd(SoundManagerStates.SND_OVER,SoundTypes.NORMAL_BTN,null);
         }
         if(this._tooltip != Values.EMPTY_STR)
         {
            this._tooltipMgr.showComplex(this._tooltip);
         }
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this.isHoverState = false;
         this._tooltipMgr.hide();
      }
   }
}
