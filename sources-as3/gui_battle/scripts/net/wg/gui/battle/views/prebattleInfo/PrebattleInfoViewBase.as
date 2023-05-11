package net.wg.gui.battle.views.prebattleInfo
{
   import flash.display.FrameLabel;
   import flash.display.Sprite;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.interfaces.IBattleInfo;
   import net.wg.gui.components.controls.TextFieldContainer;
   import net.wg.gui.utils.FrameHelper;
   import net.wg.utils.StageSizeBoundaries;
   
   public class PrebattleInfoViewBase extends BattleUIComponent implements IBattleInfo
   {
      
      private static const FRAME_LABEL_TIMER_INIT:String = "initByTimer";
      
      private static const FRAME_LABEL_TIMER_HIDE:String = "hideByTimer";
      
      private static const FRAME_LABEL_SHOW_INFO:String = "showInfo";
      
      private static const FRAME_LABEL_HIDE_INFO:String = "hideInfo";
      
      private static const FRAME_LABEL_TIMER_HIDE_COMPLETED:String = "hideByTimerCompleted";
      
      private static const SMALL_STATE:String = "smallState";
      
      private static const LARGE_STATE:String = "largeState";
       
      
      public var hintContainer:TextFieldContainer = null;
      
      public var bg:Sprite = null;
      
      private var _frameHelper:FrameHelper = null;
      
      private var _hasData:Boolean = false;
      
      private var _stageHeight:int = 0;
      
      private var _currentState:String = null;
      
      private var _isSmallState:Boolean = false;
      
      public function PrebattleInfoViewBase()
      {
         super();
         this.initFramesScript();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._stageHeight = App.appHeight;
         App.utils.commons.addEmptyHitArea(this.bg);
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         super.draw();
         if(this._hasData)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.updateData(this._isSmallState);
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               this._isSmallState = this.isSmallState();
               _loc1_ = !!this._isSmallState ? SMALL_STATE : LARGE_STATE;
               if(_loc1_ != this._currentState)
               {
                  this._currentState = _loc1_;
                  this.doLayout(this._isSmallState);
               }
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.bg.hitArea = null;
         this.bg = null;
         this.hintContainer.dispose();
         this.hintContainer = null;
         this._frameHelper.dispose();
         this._frameHelper = null;
         super.onDispose();
      }
      
      public function hideByTimer() : void
      {
         gotoAndPlay(FRAME_LABEL_TIMER_HIDE);
      }
      
      public function hideInfo() : void
      {
         gotoAndPlay(FRAME_LABEL_HIDE_INFO);
      }
      
      public function resetByTimer() : void
      {
         gotoAndStop(FRAME_LABEL_TIMER_INIT);
      }
      
      public function setData(param1:Object) : void
      {
         this.prepareData(param1);
         this._hasData = true;
         invalidateData();
      }
      
      public function setHint(param1:String) : void
      {
         this.hintContainer.label = param1;
         invalidateSize();
      }
      
      public function showInfo() : void
      {
         gotoAndPlay(FRAME_LABEL_SHOW_INFO);
      }
      
      public function updateStage(param1:int, param2:int) : void
      {
         this._stageHeight = param2;
         invalidateSize();
      }
      
      protected function updateData(param1:Boolean) : void
      {
      }
      
      protected function doLayout(param1:Boolean) : void
      {
      }
      
      protected function prepareData(param1:Object) : void
      {
      }
      
      protected function onAnimationTimerInit() : void
      {
      }
      
      protected function onAnimationShowInfo() : void
      {
      }
      
      protected function onAnimationHideInfo() : void
      {
      }
      
      protected function onAnimationInfoBgHide() : void
      {
      }
      
      protected function onAnimationTimerHideComplete() : void
      {
         stop();
      }
      
      protected function isSmallState() : Boolean
      {
         return this._stageHeight <= StageSizeBoundaries.HEIGHT_800;
      }
      
      private function initFramesScript() : void
      {
         var _loc3_:FrameLabel = null;
         this._frameHelper = new FrameHelper(this);
         var _loc1_:Array = this.currentLabels;
         var _loc2_:int = _loc1_.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _loc1_[_loc4_];
            if(_loc3_.name == FRAME_LABEL_TIMER_INIT)
            {
               this._frameHelper.addScriptToFrame(_loc3_.frame,this.onAnimationTimerInit);
            }
            else if(_loc3_.name == FRAME_LABEL_SHOW_INFO)
            {
               this._frameHelper.addScriptToFrame(_loc3_.frame,this.onAnimationShowInfo);
            }
            else if(_loc3_.name == FRAME_LABEL_HIDE_INFO)
            {
               this._frameHelper.addScriptToFrame(_loc3_.frame,this.onAnimationHideInfo);
            }
            else if(_loc3_.name == FRAME_LABEL_TIMER_HIDE)
            {
               this._frameHelper.addScriptToFrame(_loc3_.frame,this.onAnimationInfoBgHide);
            }
            else if(_loc3_.name == FRAME_LABEL_TIMER_HIDE_COMPLETED)
            {
               this._frameHelper.addScriptToFrame(_loc3_.frame,this.onAnimationTimerHideComplete);
            }
            _loc4_++;
         }
      }
      
      public function get hasAnimation() : Boolean
      {
         return false;
      }
   }
}
