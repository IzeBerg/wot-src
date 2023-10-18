package net.wg.gui.lobby.personalMissions.components
{
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import net.wg.gui.components.containers.SoundButtonContainer;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.personalMissions.events.AnimationStateEvent;
   import net.wg.gui.utils.FrameHelper;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class PersonalMissionAwardBtnAnim extends MovieClip implements IDisposable
   {
      
      private static const FADE_IN_LABEL:String = "fadeIn";
      
      private static const FADE_OUT_LABEL:String = "fadeOut";
      
      private static const FADE_IN_COMPLETE_LABEL:String = "fadeInComplete";
      
      private static const FADE_OUT_COMPLETE_LABEL:String = "fadeOutComplete";
       
      
      public var awardBtn:SoundButtonContainer = null;
      
      public var reflect:PersonalMissionAwardBtnReflect = null;
      
      private var _btnEnabled:Boolean = true;
      
      private var _frameHelper:FrameHelper = null;
      
      private var _disposed:Boolean = false;
      
      public function PersonalMissionAwardBtnAnim()
      {
         super();
         this.awardBtn.text = PERSONAL_MISSIONS.AWARDSSCREEN_ACCEPTBTN_LABEL;
         mouseEnabled = mouseChildren = false;
         this._frameHelper = new FrameHelper(this);
         var _loc1_:Array = this.currentLabels;
         var _loc2_:int = _loc1_.length;
         var _loc3_:FrameLabel = null;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _loc1_[_loc4_];
            if(_loc3_.name == FADE_IN_COMPLETE_LABEL)
            {
               this._frameHelper.addScriptToFrame(_loc3_.frame,this.onFadeInCompleted);
            }
            if(_loc3_.name == FADE_OUT_COMPLETE_LABEL)
            {
               this._frameHelper.addScriptToFrame(_loc3_.frame,this.onFadeOutCompleted);
            }
            _loc4_++;
         }
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         stop();
         this._frameHelper.dispose();
         this._frameHelper = null;
         this.awardBtn.dispose();
         this.awardBtn = null;
         this.reflect.dispose();
         this.reflect = null;
      }
      
      public function fadeIn() : void
      {
         gotoAndPlay(FADE_IN_LABEL);
      }
      
      public function fadeOut() : void
      {
         this.setBtnEnabled(false);
         mouseEnabled = mouseChildren = false;
         gotoAndPlay(FADE_OUT_LABEL);
      }
      
      public function getBtn() : ISoundButtonEx
      {
         return this.awardBtn.button;
      }
      
      public function setBtnEnabled(param1:Boolean) : void
      {
         if(this._btnEnabled != param1)
         {
            this._btnEnabled = param1;
            this.awardBtn.button.enabled = this._btnEnabled;
         }
      }
      
      private function onFadeInCompleted() : void
      {
         mouseEnabled = mouseChildren = true;
         this.setBtnEnabled(true);
         this.reflect.playAnim();
         dispatchEvent(new AnimationStateEvent(AnimationStateEvent.FADE_IN_COMPLETE));
      }
      
      private function onFadeOutCompleted() : void
      {
         this.reflect.replayAnim();
         dispatchEvent(new AnimationStateEvent(AnimationStateEvent.FADE_OUT_COMPLETE));
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
