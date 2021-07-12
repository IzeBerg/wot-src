package net.wg.gui.battle.views.battleLevelPanel
{
   import flash.display.MovieClip;
   import flash.text.TextFormat;
   import net.wg.gui.components.controls.TextFieldContainer;
   import net.wg.gui.utils.FrameHelper;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.IFramesHelper;
   
   public class TextAnimation extends MovieClip implements IDisposable
   {
      
      private static const FADE_IN_LABEL:String = "fadeInStart";
      
      private static const FADE_IN_END_LABEL:String = "fadeInEnd";
      
      private static const FADE_OUT_LABEL:String = "fadeOutStart";
      
      private static const FADE_OUT_MID_LABEL:String = "fadeOutMid";
      
      private static const FADE_OUT_END_LABEL:String = "fadeOutEnd";
       
      
      public var onFadeIndEnd:Function = null;
      
      public var onFadeOutEnd:Function = null;
      
      public var tfContainer:TextFieldContainer = null;
      
      private var _frameHelper:IFramesHelper = null;
      
      private var _isActive:Boolean = false;
      
      public function TextAnimation()
      {
         super();
         this.gotoAndStop(1);
         this._frameHelper = new FrameHelper(this);
         this._frameHelper.addScriptToFrame(this._frameHelper.getFrameByLabel(FADE_IN_END_LABEL),this.onFadeIndEndFrame);
         this._frameHelper.addScriptToFrame(this._frameHelper.getFrameByLabel(FADE_OUT_END_LABEL),this.onFadeOutEndFrame);
      }
      
      override public function gotoAndPlay(param1:Object, param2:String = null) : void
      {
         this._isActive = true;
         super.gotoAndPlay(param1,param2);
      }
      
      override public function gotoAndStop(param1:Object, param2:String = null) : void
      {
         this._isActive = false;
         super.gotoAndStop(param1,param2);
      }
      
      override public function play() : void
      {
         this._isActive = true;
         super.play();
      }
      
      override public function stop() : void
      {
         this._isActive = false;
         super.stop();
      }
      
      public function pause() : void
      {
         super.stop();
      }
      
      public function unpause() : void
      {
         if(this._isActive)
         {
            super.play();
         }
      }
      
      public final function dispose() : void
      {
         this.stop();
         this.onFadeIndEnd = null;
         this.onFadeOutEnd = null;
         this.tfContainer.dispose();
         this.tfContainer = null;
         this._frameHelper.clearFrameScripts();
         this._frameHelper.dispose();
         this._frameHelper = null;
      }
      
      public function reset() : void
      {
         this._isActive = false;
         this.gotoAndStop(1);
      }
      
      public function fadeIn(param1:Boolean = false) : void
      {
         if(param1)
         {
            this.gotoAndStop(FADE_IN_END_LABEL);
         }
         else
         {
            this.gotoAndPlay(FADE_IN_LABEL);
         }
      }
      
      public function fadeOut(param1:Boolean = false) : void
      {
         if(param1)
         {
            this.gotoAndStop(FADE_OUT_END_LABEL);
         }
         else
         {
            this.gotoAndPlay(FADE_OUT_LABEL);
         }
      }
      
      private function onFadeIndEndFrame() : void
      {
         this.stop();
         if(this.onFadeIndEnd != null)
         {
            this.onFadeIndEnd();
         }
      }
      
      private function onFadeOutEndFrame() : void
      {
         this.stop();
         if(this.onFadeOutEnd != null)
         {
            this.onFadeOutEnd();
         }
      }
      
      public function get isActive() : Boolean
      {
         return this._isActive;
      }
      
      public function set onFadeOutMid(param1:Function) : void
      {
         this._frameHelper.addScriptToFrame(this._frameHelper.getFrameByLabel(FADE_OUT_MID_LABEL),param1);
      }
      
      public function set defaultTextFormat(param1:TextFormat) : void
      {
         this.tfContainer.defaultTextFormat = param1;
      }
      
      public function set label(param1:String) : void
      {
         this.tfContainer.label = param1;
      }
      
      public function set autoSize(param1:String) : void
      {
         this.tfContainer.autoSize = param1;
      }
   }
}
