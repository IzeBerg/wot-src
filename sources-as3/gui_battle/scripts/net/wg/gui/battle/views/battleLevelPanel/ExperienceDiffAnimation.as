package net.wg.gui.battle.views.battleLevelPanel
{
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.TextFieldContainer;
   import net.wg.gui.utils.FrameHelper;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.IFramesHelper;
   
   public class ExperienceDiffAnimation extends MovieClip implements IDisposable
   {
      
      private static const FADE_OUT_START_LABEL:String = "fadeOutStart";
      
      private static const FADE_OUT_END_LABEL:String = "fadeOutEnd";
       
      
      public var onFadeOutComplete:Function = null;
      
      public var textContainer:TextFieldContainer = null;
      
      private var _frameHelper:IFramesHelper = null;
      
      private var _isActive:Boolean = false;
      
      public function ExperienceDiffAnimation()
      {
         super();
         gotoAndStop(FADE_OUT_START_LABEL);
         this.initFramesScript();
      }
      
      public final function dispose() : void
      {
         stop();
         this.onFadeOutComplete = null;
         this.textContainer.dispose();
         this.textContainer = null;
         this._frameHelper.dispose();
         this._frameHelper = null;
      }
      
      public function reset() : void
      {
         gotoAndStop(FADE_OUT_START_LABEL);
         this._isActive = false;
      }
      
      public function pause() : void
      {
         stop();
      }
      
      public function unpause() : void
      {
         if(this._isActive)
         {
            play();
         }
      }
      
      public function fadeIn(param1:int) : void
      {
         this._isActive = true;
         if(param1 > 0)
         {
            this.textContainer.label = "+" + param1.toString();
            gotoAndPlay(FADE_OUT_START_LABEL);
         }
         else
         {
            this.onFadeOutEnd();
         }
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
            if(_loc3_.name == FADE_OUT_END_LABEL)
            {
               this._frameHelper.addScriptToFrame(_loc3_.frame,this.onFadeOutEnd);
               break;
            }
            _loc4_++;
         }
      }
      
      private function onFadeOutEnd() : void
      {
         gotoAndStop(FADE_OUT_START_LABEL);
         this._isActive = false;
         if(this.onFadeOutComplete != null)
         {
            this.onFadeOutComplete();
         }
      }
      
      public function get isActive() : Boolean
      {
         return this._isActive;
      }
   }
}
