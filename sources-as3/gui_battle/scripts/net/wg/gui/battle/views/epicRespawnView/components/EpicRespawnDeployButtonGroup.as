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
      
      private static const SINGLE_NOTIFICATION_Y:int = 60;
      
      private static const DEPLOY_NOTIFICATION_Y:int = 50;
      
      private static const RESPAWN_NOTIFICATION_Y:int = 70;
       
      
      public var deployButton:FightButton = null;
      
      public var buttonAnimation:MovieClip = null;
      
      public var deployNotification:MovieClip = null;
      
      public var respawnNotification:MovieClip = null;
      
      private var _highlightAnimationActive:Boolean = false;
      
      private var _introAnimationActive:Boolean = false;
      
      private var _isTimerVisible:Boolean = false;
      
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
         this.deployButton.dispose();
         this.deployButton = null;
         this.buttonAnimation.stop();
         this.buttonAnimation = null;
         this.deployNotification = null;
         this.respawnNotification = null;
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
      
      public function updateRespawnWarning(param1:Boolean) : void
      {
         if(param1 == this.respawnNotification.visible)
         {
            return;
         }
         this.respawnNotification.visible = param1;
         this.updateNotifyPositions();
      }
      
      private function updateNotifyPositions() : void
      {
         if(this._isTimerVisible && this.respawnNotification.visible)
         {
            this.deployNotification.y = DEPLOY_NOTIFICATION_Y;
            this.respawnNotification.y = RESPAWN_NOTIFICATION_Y;
         }
         else if(this._isTimerVisible)
         {
            this.deployNotification.y = SINGLE_NOTIFICATION_Y;
         }
         else if(this.respawnNotification.visible)
         {
            this.respawnNotification.y = SINGLE_NOTIFICATION_Y;
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
   }
}
