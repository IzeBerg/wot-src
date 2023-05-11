package net.wg.gui.components.hintPanel
{
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import net.wg.data.constants.generated.BATTLE_SOUND;
   import net.wg.gui.battle.events.BattleSoundEvent;
   import net.wg.gui.utils.FrameHelper;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class KeyViewerContainerAnim extends MovieClip implements IDisposable
   {
      
      private static const FRAME_LABEL_SND_1:String = "playSnd1";
      
      private static const FRAME_LABEL_SND_2:String = "playSnd2";
      
      private static const FRAME_LABEL_SND_3:String = "playSnd3";
      
      private static const FRAME_LABEL_SND_4:String = "playSnd4";
       
      
      public var keyViewerContainer:KeyViewerContainer = null;
      
      private var _frameHelper:FrameHelper = null;
      
      private var _disposed:Boolean = false;
      
      public function KeyViewerContainerAnim()
      {
         super();
         cacheAsBitmap = true;
         this.initFramesScript();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         stop();
         this.keyViewerContainer.dispose();
         this.keyViewerContainer = null;
      }
      
      public function setKey(param1:String, param2:String) : void
      {
         this.keyViewerContainer.setKey(param1,param2);
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
            if(_loc3_.name == FRAME_LABEL_SND_1 || _loc3_.name == FRAME_LABEL_SND_2 || _loc3_.name == FRAME_LABEL_SND_3 || _loc3_.name == FRAME_LABEL_SND_4)
            {
               this._frameHelper.addScriptToFrame(_loc3_.frame,this.onPlaySnd);
            }
            _loc4_++;
         }
      }
      
      private function onPlaySnd() : void
      {
         dispatchEvent(new BattleSoundEvent(BattleSoundEvent.ON_SOUND_PLAY,BATTLE_SOUND.SOUND_TYPE_HINT_PANNEL_FLASH));
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
