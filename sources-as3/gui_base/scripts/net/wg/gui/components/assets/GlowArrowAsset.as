package net.wg.gui.components.assets
{
   import flash.display.MovieClip;
   import scaleform.clik.core.UIComponent;
   
   public class GlowArrowAsset extends UIComponent
   {
       
      
      public var hit:MovieClip;
      
      public function GlowArrowAsset()
      {
         super();
         hitArea = this.hit;
      }
      
      override public function get width() : Number
      {
         return this.hit.width;
      }
      
      override public function get height() : Number
      {
         return this.hit.height;
      }
   }
}
