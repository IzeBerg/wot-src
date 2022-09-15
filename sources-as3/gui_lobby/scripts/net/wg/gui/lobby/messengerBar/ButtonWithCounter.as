package net.wg.gui.lobby.messengerBar
{
   import flash.display.DisplayObject;
   import net.wg.gui.components.controls.IconTextBigButton;
   import net.wg.infrastructure.base.meta.IButtonWithCounterMeta;
   import net.wg.infrastructure.base.meta.impl.ButtonWithCounterMeta;
   import net.wg.infrastructure.interfaces.IPopOverCaller;
   import scaleform.clik.constants.InvalidationType;
   
   public class ButtonWithCounter extends ButtonWithCounterMeta implements IButtonWithCounterMeta, IPopOverCaller
   {
       
      
      public var button:IconTextBigButton = null;
      
      private var _count:int = 0;
      
      public function ButtonWithCounter()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.button.label = this._count > 0 ? this._count.toString() : "";
         }
      }
      
      override protected function onDispose() : void
      {
         this.button.dispose();
         this.button = null;
         super.onDispose();
      }
      
      public function as_setCount(param1:Number) : void
      {
         this._count = param1;
         invalidateData();
      }
      
      public function getHitArea() : DisplayObject
      {
         return this.button;
      }
      
      public function getTargetButton() : DisplayObject
      {
         return this.button;
      }
      
      public function get icon() : String
      {
         return this.button.htmlIconStr;
      }
      
      public function set icon(param1:String) : void
      {
         this.button.htmlIconStr = param1;
      }
      
      public function get tooltip() : String
      {
         return this.button.tooltip;
      }
      
      public function set tooltip(param1:String) : void
      {
         this.button.tooltip = param1;
      }
   }
}
