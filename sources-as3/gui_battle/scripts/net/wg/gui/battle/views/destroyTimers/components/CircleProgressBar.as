package net.wg.gui.battle.views.destroyTimers.components
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class CircleProgressBar extends MovieClip implements IDisposable
   {
       
      
      public var circle:MovieClip = null;
      
      public var highlight:MovieClip = null;
      
      private var _isDisposed:Boolean = false;
      
      public function CircleProgressBar()
      {
         super();
      }
      
      public function dispose() : void
      {
         this._isDisposed = true;
         this.circle = null;
         this.highlight = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._isDisposed;
      }
      
      public function setColor(param1:String) : void
      {
         if(this.circle)
         {
            this.circle.gotoAndStop(param1);
         }
         if(this.highlight)
         {
            this.highlight.gotoAndStop(param1);
         }
      }
      
      public function set isHighlighted(param1:Boolean) : void
      {
         if(this.highlight)
         {
            this.highlight.visible = param1;
            if(this.circle)
            {
               this.circle.visible = !param1;
            }
         }
      }
   }
}
