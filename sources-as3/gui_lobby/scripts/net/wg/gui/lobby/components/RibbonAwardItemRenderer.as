package net.wg.gui.lobby.components
{
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class RibbonAwardItemRenderer extends UIComponentEx
   {
       
      
      public var renderer:AwardItemRendererEx = null;
      
      public function RibbonAwardItemRenderer()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.renderer.x = -this.renderer.width >> 1;
            this.renderer.y = -this.renderer.height >> 1;
         }
      }
      
      override protected function onDispose() : void
      {
         this.renderer.dispose();
         this.renderer = null;
         super.onDispose();
      }
      
      public function setData(param1:Object) : void
      {
         this.renderer.setData(param1);
         invalidateData();
      }
   }
}
