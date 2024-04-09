package net.wg.gui.battle.pveBase.views.secondaryObjectives.components
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.battle.pveBase.views.secondaryObjectives.data.PveObjectVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.gfx.TextFieldEx;
   
   public class PveObject extends MovieClip implements IDisposable
   {
      
      private static const STOP_FRAME:int = 1;
      
      private static const PLAY_FRAME:int = 2;
      
      private static const DESCRIPTION_HEIGHT:int = 20;
      
      private static const DESCRIPTION_Y1:int = 28;
      
      private static const DESCRIPTION_Y2:int = 35;
      
      private static const MULTI_LINE:int = 1;
      
      private static const SINGLE_LINE:int = 2;
       
      
      public var iconContainer:PveIconContainer = null;
      
      public var titleTF:TextField = null;
      
      public var descriptionTF:TextField = null;
      
      public var progressBar:PveProgressBar = null;
      
      public var alarm:MovieClip = null;
      
      private var _disposed:Boolean = false;
      
      public function PveObject()
      {
         super();
         TextFieldEx.setNoTranslate(this.titleTF,true);
         TextFieldEx.setNoTranslate(this.descriptionTF,true);
         this.alarm.gotoAndStop(STOP_FRAME);
      }
      
      public function setData(param1:PveObjectVO) : void
      {
         this.iconContainer.setType(param1.icon,param1.isTimerEnable);
         this.progressBar.visible = param1.isVisibleProgressBar;
         this.progressBar.setProgressBarValue(param1.progressBarValue);
         this.titleTF.htmlText = param1.title;
         if(this.progressBar.visible)
         {
            gotoAndStop(SINGLE_LINE);
         }
         else
         {
            gotoAndStop(MULTI_LINE);
         }
         this.descriptionTF.htmlText = param1.description;
         this.descriptionTF.y = DESCRIPTION_Y1;
         if(!this.progressBar.visible && this.descriptionTF.textHeight < DESCRIPTION_HEIGHT)
         {
            this.descriptionTF.y = DESCRIPTION_Y2;
         }
      }
      
      public function setDone(param1:Boolean) : void
      {
         this.iconContainer.setDone(param1);
      }
      
      public function setProgressBarValue(param1:int) : void
      {
         this.progressBar.setProgressBarValue(param1);
      }
      
      public function updateTime(param1:String, param2:Boolean) : void
      {
         this.iconContainer.updateTime(param1,param2);
      }
      
      public function setAlarm(param1:Boolean) : void
      {
         if(param1)
         {
            this.alarm.gotoAndPlay(PLAY_FRAME);
         }
         else
         {
            this.alarm.gotoAndStop(STOP_FRAME);
         }
      }
      
      public function setTitle(param1:String) : void
      {
         this.titleTF.htmlText = param1;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.iconContainer.dispose();
         this.iconContainer = null;
         this.titleTF = null;
         this.descriptionTF = null;
         this.progressBar.dispose();
         this.progressBar = null;
         this.alarm = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
