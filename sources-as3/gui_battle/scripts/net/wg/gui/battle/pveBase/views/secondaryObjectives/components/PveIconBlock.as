package net.wg.gui.battle.pveBase.views.secondaryObjectives.components
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.gfx.TextFieldEx;
   
   public class PveIconBlock extends MovieClip implements IDisposable
   {
      
      private static const TURN_TO_GREEN_LABEL:String = "turnToGreen";
      
      private static const TURN_TO_RED_LABEL:String = "turnToRed";
      
      private static const NORMAL_LABEL:String = "normal";
      
      private static const WARNING_LABEL:String = "warning";
       
      
      public var icon:BattleAtlasSprite = null;
      
      public var timer:MovieClip = null;
      
      private var _disposed:Boolean = false;
      
      public function PveIconBlock()
      {
         super();
         if(this.timer != null)
         {
            TextFieldEx.setNoTranslate(this.timer.timeTF,true);
         }
      }
      
      public function setIcon(param1:String) : void
      {
         if(param1.length != 0)
         {
            this.icon.imageName = param1;
         }
         this.icon.visible = param1.length != 0;
      }
      
      public function setDone(param1:Boolean) : void
      {
         if(param1)
         {
            gotoAndPlay(TURN_TO_GREEN_LABEL);
         }
         else
         {
            gotoAndPlay(TURN_TO_RED_LABEL);
         }
      }
      
      public function setTimer(param1:String, param2:Boolean) : void
      {
         if(this.timer == null)
         {
            return;
         }
         if(param2)
         {
            this.timer.gotoAndStop(WARNING_LABEL);
         }
         else
         {
            this.timer.gotoAndStop(NORMAL_LABEL);
         }
         this.timer.timeTF.text = param1;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.icon = null;
         this.timer = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
