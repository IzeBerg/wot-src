package net.wg.gui.battle.views.minimap.components.entries.personal
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class PingFlashMinimapEntry extends BattleUIComponent
   {
      
      protected static const STATE_ATTACK:String = "attack";
      
      protected static const STATE_REPLY:String = "reply";
      
      protected static const STATE_IDLE:String = "idle";
      
      protected static const START_ANIMATION_FRAME:uint = 1;
      
      protected static const IDLE_FRAME:String = "idle";
      
      private static const USE_START_FRAME:Boolean = true;
       
      
      public var animation:MovieClip = null;
      
      public var reply:MovieClip = null;
      
      private var _currentState:String = "";
      
      private var _currentReplyFrame:int = 0;
      
      private var _currentAnimationFrame:int = 0;
      
      public function PingFlashMinimapEntry()
      {
         super();
      }
      
      protected function SetAtlasPlaceholderVisible(param1:Boolean) : void
      {
      }
      
      protected function storeFrameAnimations() : void
      {
         this._currentAnimationFrame = this.animation.currentFrame;
         this._currentReplyFrame = this.reply.currentFrame;
      }
      
      public function setState(param1:String, param2:Boolean = true) : void
      {
         if(this._currentState == param1 && param2)
         {
            return;
         }
         switch(param1)
         {
            case STATE_ATTACK:
               this.setAttackState(param2);
               break;
            case STATE_REPLY:
               this.setReplyState(param2);
               break;
            case STATE_IDLE:
               this.setIdleState(param2);
               break;
            default:
               this.setDefaultState();
         }
         this._currentState = param1;
      }
      
      protected function getCurrentState() : String
      {
         return this._currentState;
      }
      
      protected function getCurrentAnimationFrame() : int
      {
         return this._currentAnimationFrame;
      }
      
      protected function getCurrentReplyFrame() : int
      {
         return this._currentReplyFrame;
      }
      
      override protected function onDispose() : void
      {
         this.reply.stop();
         this.animation.stop();
         this.animation = null;
         this.reply = null;
         super.onDispose();
      }
      
      protected function setAttackState(param1:Boolean) : void
      {
         this.animation.visible = true;
         this.animation.gotoAndPlay(!!param1 ? START_ANIMATION_FRAME : this._currentAnimationFrame);
         this.reply.visible = false;
         this.SetAtlasPlaceholderVisible(false);
      }
      
      protected function setReplyState(param1:Boolean) : void
      {
         this.reply.visible = true;
         this.animation.visible = false;
         this.reply.gotoAndPlay(!!param1 ? START_ANIMATION_FRAME : this._currentReplyFrame);
         this.SetAtlasPlaceholderVisible(false);
      }
      
      protected function setIdleState(param1:Boolean) : void
      {
         this.animation.visible = true;
         this.animation.gotoAndPlay(!!param1 ? IDLE_FRAME : this._currentAnimationFrame);
         this.reply.visible = false;
         this.SetAtlasPlaceholderVisible(false);
      }
      
      protected function setDefaultState() : void
      {
         this.animation.visible = false;
         this.reply.visible = false;
         this.SetAtlasPlaceholderVisible(true);
      }
   }
}
