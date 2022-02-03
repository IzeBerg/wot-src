package net.wg.gui.lobby.personalMissions.components
{
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import net.wg.gui.lobby.personalMissions.events.AnimationStateEvent;
   import net.wg.gui.utils.FrameHelper;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class PersonalMissionAwardsScreenBgAnim extends MovieClip implements IDisposable
   {
      
      private static const FADE_IN_LABEL:String = "fadeIn";
      
      private static const FADE_IN_COMPLETE_LABEL:String = "fadeInComplete";
      
      private static const FADE_OUT_LABEL:String = "fadeOut";
      
      private static const FADE_OUT_COMPLETE_LABEL:String = "fadeOutComplete";
       
      
      public var bg:MovieClip = null;
      
      private var _frameHelper:FrameHelper = null;
      
      private var _disposed:Boolean = false;
      
      public function PersonalMissionAwardsScreenBgAnim()
      {
         super();
         this._frameHelper = new FrameHelper(this);
         var _loc1_:Array = currentLabels;
         var _loc2_:int = _loc1_.length;
         var _loc3_:FrameLabel = null;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _loc1_[_loc4_];
            if(_loc3_.name == FADE_IN_COMPLETE_LABEL)
            {
               this._frameHelper.addScriptToFrame(_loc3_.frame,this.onFadeInComplete);
            }
            else if(_loc3_.name == FADE_OUT_COMPLETE_LABEL)
            {
               this._frameHelper.addScriptToFrame(_loc3_.frame,this.onFadeOutComplete);
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
      }
      
      public function fadeIn() : void
      {
         gotoAndPlay(FADE_IN_LABEL);
      }
      
      public function fadeOut() : void
      {
         gotoAndPlay(FADE_OUT_LABEL);
      }
      
      public function onFadeInComplete() : void
      {
         dispatchEvent(new AnimationStateEvent(AnimationStateEvent.FADE_IN_COMPLETE));
      }
      
      public function onFadeOutComplete() : void
      {
         dispatchEvent(new AnimationStateEvent(AnimationStateEvent.FADE_OUT_COMPLETE));
      }
      
      public function setCampaignId(param1:int) : void
      {
         this.bg.gotoAndStop(param1);
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
