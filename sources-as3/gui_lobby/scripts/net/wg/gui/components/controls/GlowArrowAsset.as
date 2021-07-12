package net.wg.gui.components.controls
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class GlowArrowAsset extends UIComponentEx
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
