package net.wg.gui.battle.views.epicRespawnView.components
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.battle.views.epicRespawnView.events.EpicRespawnEvent;
   import net.wg.gui.components.controls.FightButton;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class EpicRespawnDeployButtonGroup extends MovieClip implements IDisposable
   {
      
      private static const RESET_STATE:int = 1;
      
      private static const INTRO_STATE:String = "intro";
      
      private static const HIGHLIGHT_STATE:String = "higlight";
      
      private static const SINGLE_NOTIFICATION_Y_WIDE:int = 60;
      
      private static const DEPLOY_NOTIFICATION_Y_WIDE:int = 50;
      
      private static const RESPAWN_NOTIFICATION_Y_WIDE:int = 70;
      
      private static const NOTIFICATION_X_WIDE:int = -191;
      
      private static const SINGLE_NOTIFICATION_Y_NARROW:int = 13;
      
      private static const DEPLOY_NOTIFICATION_Y_NARROW:int = -7;
      
      private static const RESPAWN_NOTIFICATION_Y_NARROW:int = 13;
      
      private static const NOTIFICATION_X_NARROW:int = -40;
      
      private static const BG_Y_NARROW:Number = -55;
      
      private static const BG_Y_WIDE:int = 0;
      
      private static const BG_Y_NARROW_SINGLE_LINE:Number = -40;
      
      private static const BG_SCALE_WIDE:int = 1;
      
      private static const BG_SCALE_NARROW:Number = 1.42;
      
      private static const BG_SCALE_NARROW_SINGLE_LINE:Number = 1.31;
       
      
      public var deployButton:FightButton = null;
      
      public var buttonAnimation:MovieClip = null;
      
      public var deployNotification:MovieClip = null;
      
      public var respawnNotification:MovieClip = null;
      
      public var bg:MovieClip = null;
      
      private var _highlightAnimationActive:Boolean = false;
      
      private var _introAnimationActive:Boolean = false;
      
      private var _isTimerVisible:Boolean = false;
      
      private var _isWide:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      public function EpicRespawnDeployButtonGroup()
      {
         super();
         mouseEnabled = false;
         this.buttonAnimation.mouseEnabled = false;
         this.buttonAnimation.mouseChildren = false;
         this.deployNotification.mouseChildren = false;
         this.deployNotification.mouseEnabled = false;
         this.respawnNotification.notificationTF.autoSize = TextFieldAutoSize.RIGHT;
         this.respawnNotification.notificationTF.text = EPIC_BATTLE.RESPAWNSCREEN_RESPAWNWARNING;
         this.respawnNotification.notificationIcon.x = this.respawnNotification.notificationTF.x | 0;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.deployButton.dispose();
         this.deployButton = null;
         this.buttonAnimation.stop();
         this.buttonAnimation = null;
         this.deployNotification = null;
         this.respawnNotification = null;
         this.bg = null;
      }
      
      public function playHighlightState() : void
      {
         if(!this._highlightAnimationActive)
         {
            this.buttonAnimation.gotoAndPlay(HIGHLIGHT_STATE);
            this._highlightAnimationActive = true;
         }
      }
      
      public function reset() : void
      {
         this._introAnimationActive = false;
         this._highlightAnimationActive = false;
         this.buttonAnimation.gotoAndStop(RESET_STATE);
      }
      
      public function updateAutoTimer(param1:Boolean, param2:String) : void
      {
         if(!param1 && !this.deployNotification.cooldownToDeployTF.visible)
         {
            this.playHighlightState();
            this.updateDeployNotification(this.deployNotification.timerToAutoDeployTF,true,param2);
            this._isTimerVisible = true;
            this.updateNotifyPositions();
         }
         else if(param1)
         {
            this.setDeployButtonState(false);
         }
         else
         {
            this.updateDeployNotification(this.deployNotification.timerToAutoDeployTF,false);
         }
      }
      
      public function updateRespawnWarning(param1:Boolean) : void
      {
         if(param1 == this.respawnNotification.visible)
         {
            return;
         }
         this.respawnNotification.visible = param1;
         this.updateNotifyPositions();
      }
      
      public function updateTimer(param1:Boolean, param2:String) : void
      {
         this.setDeployButtonState(param1);
         if(param1)
         {
            this.updateDeployNotification(this.deployNotification.cooldownToDeployTF,false);
            this._isTimerVisible = false;
            this.updateNotifyPositions();
         }
         else
         {
            this.updateDeployNotification(this.deployNotification.timerToAutoDeployTF,false);
            this.updateDeployNotification(this.deployNotification.cooldownToDeployTF,true,param2);
            this._isTimerVisible = true;
            this.updateNotifyPositions();
         }
      }
      
      private function updateNotifyPositions() : void
      {
         var _loc1_:Boolean = true;
         if(this._isTimerVisible && this.respawnNotification.visible)
         {
            this.deployNotification.y = !!this._isWide ? Number(DEPLOY_NOTIFICATION_Y_WIDE) : Number(DEPLOY_NOTIFICATION_Y_NARROW);
            this.respawnNotification.y = !!this._isWide ? Number(RESPAWN_NOTIFICATION_Y_WIDE) : Number(RESPAWN_NOTIFICATION_Y_NARROW);
            this.bg.y = !!this._isWide ? Number(BG_Y_WIDE) : Number(BG_Y_NARROW);
            this.bg.scaleY = !!this._isWide ? Number(BG_SCALE_WIDE) : Number(BG_SCALE_NARROW);
            _loc1_ = false;
         }
         else if(this._isTimerVisible)
         {
            this.deployNotification.y = !!this._isWide ? Number(SINGLE_NOTIFICATION_Y_WIDE) : Number(SINGLE_NOTIFICATION_Y_NARROW);
         }
         else if(this.respawnNotification.visible)
         {
            this.respawnNotification.y = !!this._isWide ? Number(SINGLE_NOTIFICATION_Y_WIDE) : Number(SINGLE_NOTIFICATION_Y_NARROW);
         }
         else
         {
            this.bg.y = BG_Y_WIDE;
            this.bg.scaleY = BG_SCALE_WIDE;
            _loc1_ = false;
         }
         this.deployNotification.x = this.respawnNotification.x = !!this._isWide ? Number(NOTIFICATION_X_WIDE) : Number(NOTIFICATION_X_NARROW);
         if(_loc1_)
         {
            this.bg.y = !!this._isWide ? Number(BG_Y_WIDE) : Number(BG_Y_NARROW_SINGLE_LINE);
            this.bg.scaleY = !!this._isWide ? Number(BG_SCALE_WIDE) : Number(BG_SCALE_NARROW_SINGLE_LINE);
         }
      }
      
      private function setDeployButtonState(param1:Boolean) : void
      {
         if(param1 && !this._introAnimationActive && !this.deployButton.enabled)
         {
            this.buttonAnimation.gotoAndPlay(INTRO_STATE);
            this._introAnimationActive = true;
            dispatchEvent(new EpicRespawnEvent(EpicRespawnEvent.DEPLOYMENT_BUTTON_READY));
         }
         this.deployButton.enabled = param1;
      }
      
      private function updateDeployNotification(param1:TextField, param2:Boolean, param3:String = "") : void
      {
         param1.visible = param2;
         param1.text = param3;
      }
      
      public function set isWide(param1:Boolean) : void
      {
         this._isWide = param1;
         this.updateNotifyPositions();
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
