package net.wg.gui.battle.views.battleLevelPanel
{
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.base.meta.IBattleLevelPanelMeta;
   import net.wg.infrastructure.base.meta.impl.BattleLevelPanelMeta;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.motion.Tween;
   
   public class BattleLevelPanel extends BattleLevelPanelMeta implements IBattleLevelPanelMeta
   {
      
      private static const TF_OFFSET:uint = 10;
      
      private static const SMALL_FONTS_TF_Y:int = -9;
      
      private static const SMALL_FONT_TEXT_FORMAT:TextFormat = new TextFormat(null,14,15327935);
      
      private static const MID_TEXT_RUN_TWEEN_DURATION:int = 350;
      
      private static const BR_LEVEL_PROGRESSION_ON:String = "BR_level_progression_on";
      
      private static const BR_LEVEL_PROGRESSION_OFF:String = "BR_level_progression_off";
       
      
      public var newLvlTextAnimation:TextAnimation = null;
      
      public var maxLvlTF:TextAnimation = null;
      
      public var midTF:TextAnimation = null;
      
      public var rightTF:TextAnimation = null;
      
      public var leftTF:TextAnimation = null;
      
      public var progressBar:ProgressIndicator = null;
      
      public var progressDeltaAnimation:ProgressDeltaAnimation = null;
      
      public var experienceDiffAnimation:ExperienceDiffAnimation = null;
      
      private var _data:Vector.<BattleLevelPanelData> = null;
      
      private var _currentData:BattleLevelPanelData = null;
      
      private var _midTextRunTween:Tween = null;
      
      private var _currentExperience:Object = null;
      
      private var _isInitiated:Boolean = false;
      
      private var _useAnimatedTransitions:Boolean = false;
      
      private var _soundOnEventInProgress:Boolean = false;
      
      public function BattleLevelPanel()
      {
         super();
         this.progressBar.minimum = 0;
         this.progressBar.maximum = 100;
         this._data = new Vector.<BattleLevelPanelData>();
         this._currentExperience = {};
         this._currentExperience.value = Values.ZERO;
         this._currentExperience.target = Values.ZERO;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.experienceDiffAnimation.onFadeOutComplete = this.playProgressDeltaFadeInWidthAnimation;
         this.progressDeltaAnimation.onFadeInWidthComplete = this.onProgressDeltaAnimationFadeInWidthComplete;
         this.progressDeltaAnimation.onFadeOutComplete = this.onProgressDeltaAnimationFadeOutComplete;
         this.newLvlTextAnimation.onFadeIndEnd = this.newLvlTextAnimation.play;
         this.newLvlTextAnimation.onFadeOutMid = this.onNewLvlTextAnimationFadeOutMid;
         this.newLvlTextAnimation.onFadeOutEnd = this.onNewLvlTextAnimationFadeOutEnd;
         mouseChildren = mouseEnabled = false;
         this.midTF.fadeIn(true);
         this.rightTF.fadeIn(true);
         this.leftTF.fadeIn(true);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.midTF.autoSize = TextFieldAutoSize.CENTER;
         this.newLvlTextAnimation.autoSize = TextFieldAutoSize.CENTER;
         this.maxLvlTF.autoSize = TextFieldAutoSize.CENTER;
         this.maxLvlTF.label = INGAME_GUI.LEVELPROGRESS_MAXLEVEL;
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = this.progressBar.width;
            _loc2_ = -_loc1_ >> 1 | 0;
            this.progressBar.x = _loc2_;
            this.progressDeltaAnimation.x = _loc2_;
            this.leftTF.x = _loc2_ - this.leftTF.width + TF_OFFSET | 0;
            this.rightTF.x = _loc2_ + _loc1_ - TF_OFFSET | 0;
         }
      }
      
      override protected function onDispose() : void
      {
         if(this._soundOnEventInProgress)
         {
            onPlaySoundS(BR_LEVEL_PROGRESSION_OFF);
         }
         this.newLvlTextAnimation.dispose();
         this.newLvlTextAnimation = null;
         this.maxLvlTF.dispose();
         this.maxLvlTF = null;
         this.midTF.dispose();
         this.midTF = null;
         this.rightTF.dispose();
         this.rightTF = null;
         this.leftTF.dispose();
         this.leftTF = null;
         this._data.length = 0;
         this._data = null;
         this._currentData = null;
         this._currentExperience = null;
         this.clearMidTextRunTween();
         this._midTextRunTween = null;
         this.progressBar.dispose();
         this.progressBar = null;
         this.progressDeltaAnimation.dispose();
         this.progressDeltaAnimation = null;
         this.experienceDiffAnimation.dispose();
         this.experienceDiffAnimation = null;
         super.onDispose();
      }
      
      public function as_reset() : void
      {
         this.clearMidTextRunTween();
         this._data.length = 0;
         this._currentData = null;
         this.progressDeltaAnimation.reset();
         this.experienceDiffAnimation.reset();
         this.newLvlTextAnimation.reset();
         this.progressBar.value = Values.ZERO;
         this.progressBar.visible = true;
         this.newLvlTextAnimation.visible = true;
         this.midTF.visible = true;
         this.rightTF.visible = true;
         this.leftTF.visible = true;
         this.progressBar.visible = true;
         this.progressDeltaAnimation.visible = true;
         this.experienceDiffAnimation.visible = true;
         this.maxLvlTF.visible = false;
         this._currentExperience.value = this._currentExperience.target = Values.ZERO;
      }
      
      public function as_setAnimation(param1:Boolean) : void
      {
         this._useAnimatedTransitions = param1;
         if(!this._useAnimatedTransitions)
         {
            this.clearMidTextRunTween();
            this.progressDeltaAnimation.reset();
            this.experienceDiffAnimation.reset();
            this.newLvlTextAnimation.reset();
            this.maxLvlTF.reset();
            this.midTF.reset();
            this.rightTF.reset();
            this.leftTF.reset();
         }
      }
      
      public function as_setExperience(param1:int, param2:String, param3:int, param4:int, param5:Boolean) : void
      {
         var _loc6_:BattleLevelPanelData = null;
         if(this._useAnimatedTransitions)
         {
            if(param4 <= Values.ZERO && param1 <= Values.ZERO)
            {
               return;
            }
            _loc6_ = new BattleLevelPanelData(BattleLevelPanelData.SET_EXPERIENCE_STATE);
            _loc6_.setExperience(param1,param2,param3,param4,param5);
            this._data.push(_loc6_);
            this.processData();
         }
         else
         {
            if(param4 >= 100)
            {
               param4 = 0;
            }
            this.midTF.label = param1 + param2;
            this.midTF.fadeIn(true);
            this.progressBar.value = param4;
         }
      }
      
      public function as_setIsPaused(param1:Boolean) : void
      {
         if(param1)
         {
            this.pause();
         }
         else
         {
            this.unPause();
         }
      }
      
      public function as_setLevel(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:BattleLevelPanelData = null;
         if(this._isInitiated && this._useAnimatedTransitions)
         {
            _loc4_ = new BattleLevelPanelData(BattleLevelPanelData.SET_LEVEL_STATE);
            _loc4_.setLevel(param1,param2,param3);
            this._data.push(_loc4_);
            this.processData();
         }
         else
         {
            this.leftTF.label = param1;
            this.leftTF.fadeIn(true);
            this.rightTF.label = param2;
            this.rightTF.fadeIn(true);
            this.midTF.label = param3;
            this.midTF.fadeIn(true);
            this._isInitiated = true;
         }
      }
      
      public function as_setMaxLevelReached(param1:String) : void
      {
         var _loc2_:BattleLevelPanelData = null;
         this.maxLvlTF.visible = true;
         if(this._isInitiated && this._useAnimatedTransitions)
         {
            _loc2_ = new BattleLevelPanelData(BattleLevelPanelData.SET_IS_MAX_LEVEL_STATE);
            _loc2_.currentLevel = param1;
            this._data.push(_loc2_);
            this.processData();
         }
         else
         {
            this.newLvlTextAnimation.visible = false;
            this.midTF.visible = false;
            this.rightTF.visible = false;
            this.leftTF.visible = false;
            this.progressBar.visible = false;
            this.progressDeltaAnimation.visible = false;
            this.experienceDiffAnimation.visible = false;
            this.maxLvlTF.fadeIn(true);
         }
      }
      
      public function setProgressBarWidth(param1:Number) : void
      {
         this.progressBar.width = param1;
         invalidateSize();
      }
      
      public function useSmallFont() : void
      {
         this.maxLvlTF.defaultTextFormat = SMALL_FONT_TEXT_FORMAT;
         this.midTF.defaultTextFormat = SMALL_FONT_TEXT_FORMAT;
         this.rightTF.defaultTextFormat = SMALL_FONT_TEXT_FORMAT;
         this.leftTF.defaultTextFormat = SMALL_FONT_TEXT_FORMAT;
         this.maxLvlTF.y = SMALL_FONTS_TF_Y;
         this.rightTF.y = SMALL_FONTS_TF_Y;
         this.leftTF.y = SMALL_FONTS_TF_Y;
      }
      
      private function clearMidTextRunTween() : void
      {
         if(this._midTextRunTween)
         {
            this._midTextRunTween.dispose();
            this._midTextRunTween = null;
         }
      }
      
      private function processData() : void
      {
         var _loc1_:Boolean = this.progressDeltaAnimation.isActive || this.experienceDiffAnimation.isActive || this.newLvlTextAnimation.isActive;
         if(_loc1_)
         {
            return;
         }
         this._currentData = this._data.shift();
         if(!this._currentData)
         {
            return;
         }
         var _loc2_:uint = this._currentData.state;
         if(_loc2_ == BattleLevelPanelData.SET_EXPERIENCE_STATE)
         {
            if(this._currentData.percent > Values.ZERO)
            {
               this.experienceDiffAnimation.fadeIn(this._currentData.expDiff);
            }
            else
            {
               this.processData();
            }
         }
         else if(_loc2_ == BattleLevelPanelData.SET_LEVEL_STATE)
         {
            if(StringUtils.isNotEmpty(this._currentData.currentLevel))
            {
               this.playProgressDeltaFadeOutAnimation();
            }
            else
            {
               this.updateLevelText();
            }
         }
         else if(_loc2_ == BattleLevelPanelData.SET_IS_MAX_LEVEL_STATE)
         {
            this.playProgressDeltaFadeOutAnimation();
         }
      }
      
      private function playProgressDeltaFadeInWidthAnimation() : void
      {
         this.clearMidTextRunTween();
         this._currentExperience.target = this._currentData.targetExperience;
         this._midTextRunTween = new Tween(MID_TEXT_RUN_TWEEN_DURATION,this._currentExperience,{"value":this._currentData.currentExperience},{"onChange":this.onUpdateCounter});
         if(this._currentData.playSound)
         {
            onPlaySoundS(BR_LEVEL_PROGRESSION_ON);
            this._soundOnEventInProgress = true;
         }
         this.progressDeltaAnimation.x = this.progressBar.x + this.progressBar.trackWidth;
         this.progressDeltaAnimation.fadeInWidth(this.progressBar.calculateTrackWidthDelta(this._currentData.percent));
      }
      
      private function onProgressDeltaAnimationFadeInWidthComplete() : void
      {
         if(this._currentData.state == BattleLevelPanelData.SET_EXPERIENCE_STATE)
         {
            this.progressBar.value = this._currentData.percent;
            this.progressBar.validateNow();
            if(this._soundOnEventInProgress)
            {
               onPlaySoundS(BR_LEVEL_PROGRESSION_OFF);
               this._soundOnEventInProgress = false;
            }
         }
      }
      
      private function playProgressDeltaFadeOutAnimation() : void
      {
         this._currentExperience.value = Values.ZERO;
         this._currentExperience.target = Values.ZERO;
         this.midTF.fadeOut();
         this.rightTF.fadeOut();
         this.leftTF.fadeOut();
         this.progressBar.value = Values.ZERO;
         this.progressBar.validateNow();
         this.progressDeltaAnimation.x = this.progressBar.x;
         this.progressDeltaAnimation.width = this.progressBar.width;
         this.progressDeltaAnimation.fadeOut();
      }
      
      private function onProgressDeltaAnimationFadeOutComplete() : void
      {
         var _loc1_:uint = this._currentData.state;
         if(_loc1_ == BattleLevelPanelData.SET_LEVEL_STATE || _loc1_ == BattleLevelPanelData.SET_IS_MAX_LEVEL_STATE)
         {
            this.progressBar.visible = false;
            this.newLvlTextAnimation.label = this._currentData.currentLevel;
            this.newLvlTextAnimation.fadeIn();
         }
         else
         {
            this.processData();
         }
      }
      
      private function onNewLvlTextAnimationFadeOutMid() : void
      {
         this.updateLevelText();
         if(this._currentData.state != BattleLevelPanelData.SET_IS_MAX_LEVEL_STATE)
         {
            this.progressBar.visible = true;
            this.midTF.fadeIn();
            this.rightTF.fadeIn();
            this.leftTF.fadeIn();
         }
         else
         {
            this.maxLvlTF.fadeIn();
         }
      }
      
      private function updateLevelText() : void
      {
         if(StringUtils.isNotEmpty(this._currentData.currentLevel))
         {
            this.leftTF.label = this._currentData.currentLevel;
         }
         if(StringUtils.isNotEmpty(this._currentData.nextLevel))
         {
            this.rightTF.label = this._currentData.nextLevel;
         }
         if(StringUtils.isNotEmpty(this._currentData.experience))
         {
            this.midTF.label = this._currentData.experience;
         }
      }
      
      private function onNewLvlTextAnimationFadeOutEnd() : void
      {
         this.newLvlTextAnimation.stop();
         this.processData();
      }
      
      private function onUpdateCounter() : void
      {
         this.midTF.label = (this._currentExperience.value | 0) + this._currentExperience.target;
      }
      
      private function pause() : void
      {
         this.newLvlTextAnimation.pause();
         this.maxLvlTF.pause();
         this.midTF.pause();
         this.rightTF.pause();
         this.leftTF.pause();
         this.progressDeltaAnimation.pause();
         this.experienceDiffAnimation.pause();
         if(this._midTextRunTween)
         {
            this._midTextRunTween.paused = true;
         }
      }
      
      private function unPause() : void
      {
         this.newLvlTextAnimation.unpause();
         this.maxLvlTF.unpause();
         this.midTF.unpause();
         this.rightTF.unpause();
         this.leftTF.unpause();
         this.progressDeltaAnimation.unpause();
         this.experienceDiffAnimation.unpause();
         if(this._midTextRunTween)
         {
            this._midTextRunTween.paused = false;
         }
      }
      
      override public function get height() : Number
      {
         return this.midTF.y + this.midTF.height;
      }
      
      public function set useAnimatedTransitions(param1:Boolean) : void
      {
         this._useAnimatedTransitions = param1;
      }
   }
}
