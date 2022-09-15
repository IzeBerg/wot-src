package net.wg.gui.battle.comp7.views.consumablesPanel
{
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class Comp7Counter extends Sprite implements IDisposable
   {
      
      private static const TEXT_COLOR:uint = 16767886;
      
      private static const TEXT_COLOR_ZERO:uint = 15327935;
      
      private static const SHADOW_FILTER:DropShadowFilter = new DropShadowFilter(0,0,16711680,1,4,4);
      
      private static const COUNTER_TF_FILTERS:Array = [SHADOW_FILTER];
       
      
      public var counterTf:TextField = null;
      
      private var _disposed:Boolean = false;
      
      public function Comp7Counter()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.counterTf = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function set count(param1:int) : void
      {
         if(param1 == 0)
         {
            this.counterTf.textColor = TEXT_COLOR_ZERO;
            this.counterTf.filters = [];
         }
         else
         {
            this.counterTf.textColor = TEXT_COLOR;
            this.counterTf.filters = COUNTER_TF_FILTERS;
         }
         this.counterTf.text = String(param1);
      }
   }
}
