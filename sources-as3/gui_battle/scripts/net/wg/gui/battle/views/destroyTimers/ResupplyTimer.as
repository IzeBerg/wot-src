package net.wg.gui.battle.views.destroyTimers
{
   import flash.display.MovieClip;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.generated.EPIC_CONSTS;
   import net.wg.gui.battle.components.BattleUIComponent;
   import scaleform.gfx.TextFieldEx;
   
   public class ResupplyTimer extends BattleUIComponent
   {
      
      private static const PERCENT_TEXT:String = " %";
      
      private static const SHOW_FRAME_LABEL:String = "show";
      
      private static const HIDE_FRAME_LABEL:String = "hide";
      
      private static const ICON_ACTIVE_FRAME_LABEL:String = "active";
      
      private static const ICON_UNAVAILABLE_FRAME_LABEL:String = "unavailable";
       
      
      public var cooldownTime:MovieClip = null;
      
      public var progressAnimation:MovieClip = null;
      
      public var description:MovieClip = null;
      
      public var icon:MovieClip = null;
      
      private var _isActive:Boolean = false;
      
      private var _isSmallSize:Boolean = false;
      
      public function ResupplyTimer()
      {
         super();
         TextFieldEx.setNoTranslate(this.cooldownTime.cooldownTF,true);
         this.description.titleTF.autoSize = TextFieldAutoSize.LEFT;
         this.description.descriptionTF.autoSize = TextFieldAutoSize.LEFT;
         this.description.titleTF.text = EPIC_BATTLE.PROGRESS_TIMERS_RESUPPLY;
      }
      
      override protected function onDispose() : void
      {
         stop();
         this.cooldownTime = null;
         this.progressAnimation.stop();
         this.progressAnimation = null;
         this.description = null;
         this.icon = null;
         super.onDispose();
      }
      
      public function cropSize() : void
      {
         this.description.visible = false;
      }
      
      public function fullSize() : void
      {
         this.description.visible = true;
      }
      
      public function hideTimer() : void
      {
         gotoAndPlay(HIDE_FRAME_LABEL);
      }
      
      public function resetTimer() : void
      {
         this.hideTimer();
      }
      
      public function setCooldownTime(param1:String) : void
      {
         this.cooldownTime.cooldownTF.text = param1;
      }
      
      public function setProgressValue(param1:int) : void
      {
         this.description.descriptionTF.text = param1.toString() + PERCENT_TEXT;
      }
      
      public function setState(param1:int) : void
      {
         switch(param1)
         {
            case EPIC_CONSTS.RESUPPLY_READY:
               this.progressAnimation.play();
               this.description.descriptionTF.text = EPIC_BATTLE.PROGRESS_TIMERS_ACTIVE;
               this.icon.gotoAndStop(ICON_ACTIVE_FRAME_LABEL);
               this.cooldownTime.visible = false;
               this.progressAnimation.visible = true;
               break;
            case EPIC_CONSTS.RESUPPLY_BLOCKED:
               this.description.descriptionTF.text = EPIC_BATTLE.PROGRESS_TIMERS_UNAVAILABLE;
               this.icon.gotoAndStop(ICON_UNAVAILABLE_FRAME_LABEL);
               this.cooldownTime.visible = true;
               this.progressAnimation.visible = false;
               break;
            case EPIC_CONSTS.RESUPPLY_FULL:
               this.description.descriptionTF.text = EPIC_BATTLE.PROGRESS_TIMERS_FULLY_EQUIPPED;
               this.icon.gotoAndStop(ICON_ACTIVE_FRAME_LABEL);
               this.cooldownTime.visible = false;
               this.progressAnimation.visible = true;
               this.progressAnimation.gotoAndStop(1);
         }
      }
      
      public function showTimer() : void
      {
         gotoAndPlay(SHOW_FRAME_LABEL);
      }
      
      public function get isActive() : Boolean
      {
         return this._isActive;
      }
      
      public function set isActive(param1:Boolean) : void
      {
         this._isActive = param1;
      }
      
      public function get isSmallSize() : Boolean
      {
         return this._isSmallSize;
      }
      
      public function set isSmallSize(param1:Boolean) : void
      {
         this._isSmallSize = param1;
      }
   }
}
