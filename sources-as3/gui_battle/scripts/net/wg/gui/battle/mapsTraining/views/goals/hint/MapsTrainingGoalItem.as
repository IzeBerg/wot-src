package net.wg.gui.battle.mapsTraining.views.goals.hint
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class MapsTrainingGoalItem extends MovieClip implements IDisposable
   {
      
      private static const COLOR_RED:int = 1;
      
      private static const COLOR_PURPLE:int = 2;
       
      
      public var icon:MovieClip = null;
      
      public var iconDestroyed:MovieClip = null;
      
      private var _disposed:Boolean = false;
      
      public function MapsTrainingGoalItem()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.icon = null;
         this.iconDestroyed = null;
      }
      
      public function setColorBlind(param1:Boolean) : void
      {
         this.icon.gotoAndStop(!!param1 ? COLOR_PURPLE : COLOR_RED);
         this.iconDestroyed.gotoAndStop(!!param1 ? COLOR_PURPLE : COLOR_RED);
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
