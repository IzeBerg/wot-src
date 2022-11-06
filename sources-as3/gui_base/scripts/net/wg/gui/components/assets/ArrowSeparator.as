package net.wg.gui.components.assets
{
   import flash.display.Sprite;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class ArrowSeparator extends UIComponentEx
   {
       
      
      public var separator:Sprite;
      
      public var arrow:Sprite;
      
      public function ArrowSeparator()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         mouseEnabled = mouseChildren = false;
         super.configUI();
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.SIZE))
         {
            this.separator.width = _width;
            this.arrow.x = (this.separator.width >> 1) - (this.arrow.width >> 1);
            super.setActualScale(1,scaleY);
         }
         super.draw();
      }
      
      override protected function onDispose() : void
      {
         this.separator = null;
         this.arrow = null;
         super.onDispose();
      }
   }
}
