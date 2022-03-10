package net.wg.gui.battle.views.directionIndicator
{
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.IRootAppMainContent;
   
   public class DirectionIndicator extends Sprite implements IRootAppMainContent
   {
       
      
      public var indicator:DirectionIndicatorImage = null;
      
      public var distance:BaseValueIndicator = null;
      
      protected var shape:String = null;
      
      private var _disposed:Boolean = false;
      
      public function DirectionIndicator()
      {
         super();
      }
      
      public function setShape(param1:String) : void
      {
         if(!param1 || param1 == this.shape)
         {
            return;
         }
         this.indicator.setShape(param1);
         this.distance.setShape(param1);
         this.shape = param1;
      }
      
      public function setDistance(param1:String) : void
      {
         this.distance.setValue(param1);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.indicator.dispose();
         this.distance.dispose();
         this.indicator = null;
         this.distance = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
