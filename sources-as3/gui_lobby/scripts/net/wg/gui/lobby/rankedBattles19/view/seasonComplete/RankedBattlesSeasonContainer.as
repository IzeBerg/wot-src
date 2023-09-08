package net.wg.gui.lobby.rankedBattles19.view.seasonComplete
{
   import fl.transitions.easing.Strong;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.RANKEDBATTLES_ALIASES;
   import net.wg.gui.components.controls.CloseButtonText;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.TextFieldContainer;
   import net.wg.gui.lobby.components.data.RibbonAwardsVO;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesSeasonCompleteViewVO;
   import net.wg.gui.lobby.rankedBattles19.events.SeasonCompleteEvent;
   import net.wg.gui.lobby.rankedBattles19.events.SoundEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.IScheduler;
   import net.wg.utils.IViewRestrictions;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.motion.Tween;
   
   public class RankedBattlesSeasonContainer extends UIComponentEx
   {
      
      private static const CONGRATULATIONS_TF_Y_OFFSET:int = 260;
      
      private static const OFFSET_CLOSE_BUTTON:int = 40;
      
      private static const NEXTBTN_Y_OFFSET:int = 320;
      
      private static const NEXT_BTN_TWEEN_DURATION:uint = 300;
      
      private static const TYPE_TF_Y_OFFSET:int = 10;
      
      private static const RESULT_BLOCK_Y_OFFSET:int = 20;
      
      private static const SCHEDULER_DELAY:uint = 400;
      
      private static const RESULT_BLOCK_LEAGUE_LINKAGE:String = "SeasonLeagueResultBlockUI";
      
      private static const RESULT_BLOCK_DIVISION_LINKAGE:String = "SeasonDivisionResultBlockUI";
      
      private static const INV_AWARDS_DATA:String = "invAwardsData";
       
      
      public var closeButton:CloseButtonText = null;
      
      public var title:TextFieldContainer = null;
      
      public var nextButton:SoundButtonEx = null;
      
      public var seasonType:RankedBattlesSeasonType = null;
      
      private var _resultBlock:SeasonBaseResultBlock = null;
      
      private var _tweens:Vector.<Tween> = null;
      
      private var _scheduler:IScheduler = null;
      
      private var _screenW:int = 0;
      
      private var _screenH:int = 0;
      
      private var _bgActualWidth:int = 0;
      
      private var _bgActualHeight:int = 0;
      
      private var _viewRestrictions:IViewRestrictions = null;
      
      private var _loader:Loader = null;
      
      private var _backgroundCenter:Boolean = false;
      
      private var _bgIsLoaded:Boolean = false;
      
      private var _seasonData:RankedBattlesSeasonCompleteViewVO = null;
      
      private var _awardsData:RibbonAwardsVO = null;
      
      public function RankedBattlesSeasonContainer()
      {
         super();
         this._tweens = new Vector.<Tween>(0);
         this._scheduler = App.utils.scheduler;
         this._viewRestrictions = App.utils.viewRestrictions;
         this._loader = new Loader();
         addChildAt(this._loader,0);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoaderCompleteHandler);
         this.closeButton.label = VEHICLE_CUSTOMIZATION.CUSTOMIZATIONHEADER_CLOSE;
         this.closeButton.addEventListener(ButtonEvent.CLICK,this.onCloseButtonClickHandler);
         this.closeButton.addEventListener(Event.RESIZE,this.onCloseButtonResizeHandler);
         this.closeButton.y = OFFSET_CLOSE_BUTTON;
         this.nextButton.alpha = Values.ZERO;
         this.nextButton.visible = false;
         this.nextButton.addEventListener(ButtonEvent.CLICK,this.onNextButtonClickHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._seasonData && isInvalid(InvalidationType.DATA))
         {
            this.doData();
            invalidate(INV_AWARDS_DATA);
         }
         if(this._awardsData && this._resultBlock && isInvalid(INV_AWARDS_DATA))
         {
            this._resultBlock.setAwardsData(this._awardsData);
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.doSize();
         }
      }
      
      override protected function onDispose() : void
      {
         this.disposeResultBlock();
         this._scheduler.cancelTask(this.showSeasonCompleteAnimationCallback);
         this._scheduler = null;
         this.title.dispose();
         this.title = null;
         this.nextButton.removeEventListener(ButtonEvent.CLICK,this.onNextButtonClickHandler);
         this.nextButton.dispose();
         this.nextButton = null;
         this.closeButton.removeEventListener(ButtonEvent.CLICK,this.onCloseButtonClickHandler);
         this.closeButton.removeEventListener(Event.RESIZE,this.onCloseButtonResizeHandler);
         this.closeButton.dispose();
         this.closeButton = null;
         this.seasonType.dispose();
         this.seasonType = null;
         if(this._loader != null)
         {
            if(this._bgIsLoaded)
            {
               this._loader.unload();
            }
            this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLoaderCompleteHandler);
            this._loader = null;
         }
         this._viewRestrictions = null;
         this.disposeTweens();
         this._tweens = null;
         this._seasonData = null;
         this._awardsData = null;
         super.onDispose();
      }
      
      public function setAwardsData(param1:RibbonAwardsVO) : void
      {
         if(param1 && this._awardsData != param1)
         {
            this._awardsData = param1;
            invalidate(INV_AWARDS_DATA);
         }
      }
      
      public function setData(param1:RankedBattlesSeasonCompleteViewVO) : void
      {
         if(param1 && this._seasonData != param1)
         {
            this._seasonData = param1;
            invalidateData();
         }
      }
      
      public function setPlace(param1:String) : void
      {
         if(this._resultBlock)
         {
            this._resultBlock.setPlace(param1);
         }
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         this._screenW = param1;
         this._screenH = param2;
         this.recalculateBgSize(param1,param2);
         this.updateBG();
         invalidateSize();
      }
      
      private function disposeResultBlock() : void
      {
         if(this._resultBlock)
         {
            this._resultBlock.removeEventListener(SeasonCompleteEvent.RESULT_BLOCK_READY,this.onCmpResultBlockReadyHandler);
            this._resultBlock.dispose();
            this._resultBlock = null;
         }
      }
      
      private function setBackground(param1:String, param2:Boolean = false) : void
      {
         this._bgIsLoaded = false;
         this._backgroundCenter = param2;
         var _loc3_:URLRequest = new URLRequest(param1);
         var _loc4_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
         this._loader.scaleX = 1;
         this._loader.scaleY = 1;
         this._loader.load(_loc3_,_loc4_);
      }
      
      private final function onSoundTrigger(param1:String) : void
      {
         dispatchEvent(new SoundEvent(SoundEvent.TRIGGER_SOUND,param1));
      }
      
      private function updateBG() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this._bgIsLoaded)
         {
            _loc1_ = this._loader.width / this._loader.scaleX;
            _loc2_ = this._loader.height / this._loader.scaleY;
            if(this._bgActualHeight < _loc2_ * this._bgActualWidth / _loc1_)
            {
               this._loader.width = this._bgActualWidth;
               this._loader.scaleY = this._loader.scaleX;
            }
            else
            {
               this._loader.height = this._bgActualHeight;
               this._loader.scaleX = this._loader.scaleY;
            }
            if(this._backgroundCenter)
            {
               this._loader.x = -this._loader.width >> 1;
            }
            this._loader.y = this._viewRestrictions.topOffset - y | 0;
         }
      }
      
      private function recalculateBgSize(param1:int, param2:int) : void
      {
         this._bgActualWidth = param1;
         this._bgActualHeight = param2 - this._viewRestrictions.verticalOffset;
      }
      
      private function disposeTweens() : void
      {
         var _loc1_:Tween = null;
         for each(_loc1_ in this._tweens)
         {
            _loc1_.paused = true;
            _loc1_.dispose();
         }
         this._tweens.length = 0;
      }
      
      private function doData() : void
      {
         dispatchEvent(new SeasonCompleteEvent(SeasonCompleteEvent.START_INIT_DATA));
         var _loc1_:Boolean = this._seasonData.state == RANKEDBATTLES_ALIASES.SEASON_COMPLETE_VIEW_LEAGUE_STATE;
         this.closeButton.tooltip = !!_loc1_ ? RANKED_BATTLES.TOOLTIP_CLOSEBUTTON : null;
         this.setBackground(this._seasonData.bgSource,true);
         this.seasonType.setType(this._seasonData.typeTitle,this._seasonData.typeIcon);
         this.title.label = this._seasonData.seasonTitle;
         this.nextButton.label = this._seasonData.btnLabel;
         this.disposeResultBlock();
         this._resultBlock = App.utils.classFactory.getComponent(!!_loc1_ ? RESULT_BLOCK_LEAGUE_LINKAGE : RESULT_BLOCK_DIVISION_LINKAGE,SeasonBaseResultBlock);
         addChildAt(this._resultBlock,1);
         this._resultBlock.addEventListener(SeasonCompleteEvent.RESULT_BLOCK_READY,this.onCmpResultBlockReadyHandler);
         this._resultBlock.setData(this._seasonData);
         this._scheduler.scheduleTask(this.showSeasonCompleteAnimationCallback,SCHEDULER_DELAY);
      }
      
      private function doSize() : void
      {
         var _loc1_:uint = this._screenW >> 1;
         var _loc2_:uint = this._screenH >> 1;
         this.closeButton.x = _loc1_ - this.closeButton.width - OFFSET_CLOSE_BUTTON;
         this.title.y = _loc2_ - CONGRATULATIONS_TF_Y_OFFSET - (this.title.height >> 1);
         this.seasonType.y = this.title.y - TYPE_TF_Y_OFFSET;
         this.nextButton.y = _loc2_ + NEXTBTN_Y_OFFSET;
         this._resultBlock.y = _loc2_ - RESULT_BLOCK_Y_OFFSET;
      }
      
      private function showSeasonCompleteAnimationCallback() : void
      {
         this._resultBlock.fadeIn();
         if(this._seasonData.state == RANKEDBATTLES_ALIASES.SEASON_COMPLETE_VIEW_LEAGUE_STATE)
         {
            this.onSoundTrigger(RANKEDBATTLES_ALIASES.SOUND_SEASON_COMPLETE_SHOW_LEAGUE);
         }
         else
         {
            this.onSoundTrigger(RANKEDBATTLES_ALIASES.SOUND_SEASON_COMPLETE_SHOW_DIVISION);
         }
      }
      
      private function onCloseButtonResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onNextButtonClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new SeasonCompleteEvent(SeasonCompleteEvent.NEXT_BTN_CLICK));
      }
      
      private function onCloseButtonClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new SeasonCompleteEvent(SeasonCompleteEvent.CLOSE_BTN_CLICK));
      }
      
      private function onCmpResultBlockReadyHandler(param1:Event) : void
      {
         this.nextButton.visible = true;
         this._tweens.push(new Tween(NEXT_BTN_TWEEN_DURATION,this.nextButton,{"alpha":Values.DEFAULT_ALPHA},{"ease":Strong.easeOut}));
         this.onSoundTrigger(RANKEDBATTLES_ALIASES.SOUND_SEASON_COMPLETE_SHOW_BTN);
      }
      
      private function onLoaderCompleteHandler(param1:Event) : void
      {
         this._bgIsLoaded = true;
         this.updateBG();
      }
   }
}
