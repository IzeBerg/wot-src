package net.wg.gui.battle.views.directionIndicator
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class ArtyDirectionIndicator extends Sprite implements IDisposable
   {
      
      private static const ARROW_POSITION_Y:int = -100;
       
      
      public var targetMc:MovieClip = null;
      
      public var indicator:DirectionIndicatorImage = null;
      
      private var _shape:String = null;
      
      public function ArtyDirectionIndicator()
      {
         super();
         this.indicator.setArrowPositionY(ARROW_POSITION_Y);
      }
      
      public function setShape(param1:String) : void
      {
         if(!param1 || param1 == this._shape)
         {
            return;
         }
         this.indicator.setShape(param1);
         this._shape = param1;
      }
      
      public final function dispose() : void
      {
         this.indicator.dispose();
         this.indicator = null;
         this.targetMc = null;
      }
   }
}
