package net.wg.gui.lobby.vehiclePreview.buyingPanel
{
   import flash.display.MovieClip;
   import flash.display.Stage;
   import flash.text.TextField;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.events.LobbyEvent;
   import net.wg.gui.lobby.vehiclePreview.data.VPEventKingRewardVO;
   import net.wg.infrastructure.base.meta.IEventKingRewardMeta;
   import net.wg.infrastructure.base.meta.impl.EventKingRewardMeta;
   import net.wg.infrastructure.managers.IStageSizeManager;
   import net.wg.utils.ICommons;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.motion.Tween;
   
   public class VPEventKingReward extends EventKingRewardMeta implements IEventKingRewardMeta, IVPBottomPanel, IStageSizeDependComponent
   {
      
      private static const DIVIDER:String = "/";
      
      private static const PLAY_GAP:int = -6;
      
      private static const PLAY_GAP_SMALL:int = -1;
      
      private static const TAKEN_PADDING:int = -6;
      
      private static const PANEL_WIDTH:int = 576;
      
      private static const PANEL_HEIGHT_FULL:int = 382;
      
      private static const PANEL_HEIGHT:int = 382 - 23;
      
      private static const PANEL_HEIGHT_SMALL:int = 382 - 23 - 19;
      
      private static const FRAME_SMALL:String = "Small";
      
      private static const FRAME_NORMAL:String = "Normal";
      
      private static const TOTAL_HEIGHT_PADDING:int = 15;
      
      private static const SMALL_TAKEN_Y:int = 260;
      
      private static const NORMAL_TAKEN_Y:int = 189;
      
      private static const FADE_ANIMATION_DURATION:int = 200;
      
      private static const FADE_ANIMATION_DELAY:int = 150;
      
      private static const SHOW_SLOTS_ALPHA:Number = 1;
      
      private static const HIDE_SLOTS_ALPHA:Number = 0;
       
      
      public var currentField:TextField = null;
      
      public var totalField:TextField = null;
      
      public var btnPlay:MovieClip = null;
      
      public var btnToRewards:SoundButtonEx = null;
      
      public var progress:MovieClip = null;
      
      public var takenMC:MovieClip = null;
      
      public var wind:MovieClip = null;
      
      public var takenField:TextField = null;
      
      public var descriptionField:TextField = null;
      
      public var buttonSmokeMC:MovieClip = null;
      
      public var hitMC:MovieClip = null;
      
      private var _data:VPEventKingRewardVO = null;
      
      private var _isSmall:Boolean = false;
      
      private var _isFull:Boolean = false;
      
      private var _commons:ICommons;
      
      private var _stageSizeMgr:IStageSizeManager;
      
      private var _stage:Stage;
      
      private var _tween:Tween = null;
      
      public function VPEventKingReward()
      {
         this._commons = App.utils.commons;
         this._stageSizeMgr = App.stageSizeMgr;
         this._stage = App.stage;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.btnToRewards.addEventListener(ButtonEvent.CLICK,this.onBtnToRewardsClickHandler);
         this._stageSizeMgr.register(this);
         this._stage.addEventListener(LobbyEvent.DRAGGING_START,this.onDraggingStartHandler);
         this._stage.addEventListener(LobbyEvent.DRAGGING_END,this.onDraggingEndHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.currentField.text = this._data.current.toString();
            this.totalField.text = DIVIDER + this._data.total.toString();
            this.progress.gotoAndStop(this._data.current / this._data.total * this.progress.totalFrames);
            this.btnToRewards.label = !!this._data.taken ? EVENT.KINGREWARD_TOQUESTIONING : EVENT.KINGREWARD_TOREWARDS;
            this.takenMC.visible = this.takenField.visible = this._data.taken;
            this.descriptionField.visible = this.wind.visible = this.btnPlay.visible = this.currentField.visible = this.totalField.visible = this.progress.visible = !this._data.taken;
            this.descriptionField.text = EVENT.KINGREWARD_DESCRIPTION;
            this.takenField.text = EVENT.KINGREWARD_TAKEN;
            this._commons.updateTextFieldSize(this.takenField,true,false);
            this._commons.updateTextFieldSize(this.currentField,true,false);
            this._commons.updateTextFieldSize(this.totalField,true,false);
            _loc1_ = this.currentField.width + this.totalField.width;
            this.currentField.x = this.btnPlay.x - _loc1_ - (!!this._isSmall ? PLAY_GAP_SMALL : PLAY_GAP);
            this.totalField.x = this.currentField.x + this.currentField.width | 0;
            _loc2_ = this.takenField.width + this.takenMC.width + TAKEN_PADDING;
            this.takenMC.x = this.width - _loc2_ >> 1;
            this.takenMC.y = !!this._isSmall ? Number(SMALL_TAKEN_Y) : Number(NORMAL_TAKEN_Y);
            this.takenField.x = this.takenMC.x + this.takenMC.width + TAKEN_PADDING | 0;
            this.wind.mouseEnabled = this.currentField.mouseEnabled = this.totalField.mouseEnabled = this.btnPlay.mouseEnabled = this.takenField.mouseEnabled = this.descriptionField.mouseEnabled = this.takenMC.mouseEnabled = this.buttonSmokeMC.mouseEnabled = false;
            this.progress.mouseEnabled = this.progress.mouseChildren = false;
            hitArea = this.hitMC;
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         this._stage.removeEventListener(LobbyEvent.DRAGGING_START,this.onDraggingStartHandler);
         this._stage.removeEventListener(LobbyEvent.DRAGGING_END,this.onDraggingEndHandler);
      }
      
      override protected function onDispose() : void
      {
         this.btnToRewards.removeEventListener(ButtonEvent.CLICK,this.onBtnToRewardsClickHandler);
         this.btnPlay = null;
         this.btnToRewards.dispose();
         this.btnToRewards = null;
         this.progress = null;
         this.takenMC = null;
         this.wind = null;
         this.takenField = null;
         this.descriptionField = null;
         this.currentField = null;
         this.totalField = null;
         this.buttonSmokeMC = null;
         this.hitMC = null;
         hitArea = null;
         this._data = null;
         this._commons = null;
         this._stageSizeMgr.unregister(this);
         this._stageSizeMgr = null;
         this._stage = null;
         this.disposeTween();
         super.onDispose();
      }
      
      override protected function setData(param1:VPEventKingRewardVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      public function getBtn() : SoundButtonEx
      {
         return this.btnToRewards;
      }
      
      public function getTotalHeight() : Number
      {
         return this.height - this.progress.y - TOTAL_HEIGHT_PADDING;
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         this._isSmall = param2 < StageSizeBoundaries.HEIGHT_900;
         this._isFull = param2 >= StageSizeBoundaries.HEIGHT_1080;
         var _loc3_:String = !!this._isSmall ? FRAME_SMALL : FRAME_NORMAL;
         if(currentFrameLabel != _loc3_)
         {
            gotoAndStop(_loc3_);
            invalidateData();
         }
      }
      
      override public function get width() : Number
      {
         return PANEL_WIDTH;
      }
      
      override public function get height() : Number
      {
         if(this._isFull)
         {
            return PANEL_HEIGHT_FULL;
         }
         return !!this._isSmall ? Number(PANEL_HEIGHT_SMALL) : Number(PANEL_HEIGHT);
      }
      
      private function onBtnToRewardsClickHandler(param1:ButtonEvent) : void
      {
         onExitToRewardsClickS();
      }
      
      private function disposeTween() : void
      {
         if(this._tween)
         {
            this._tween.paused = true;
            this._tween.dispose();
            this._tween = null;
         }
      }
      
      private function onDraggingStartHandler(param1:LobbyEvent) : void
      {
         this.disposeTween();
         this._tween = new Tween(FADE_ANIMATION_DURATION,this,{"alpha":HIDE_SLOTS_ALPHA},{
            "delay":FADE_ANIMATION_DELAY,
            "fastTransform":false
         });
      }
      
      private function onDraggingEndHandler(param1:LobbyEvent) : void
      {
         this.disposeTween();
         this._tween = new Tween(FADE_ANIMATION_DURATION,this,{"alpha":SHOW_SLOTS_ALPHA},{"fastTransform":false});
      }
   }
}
