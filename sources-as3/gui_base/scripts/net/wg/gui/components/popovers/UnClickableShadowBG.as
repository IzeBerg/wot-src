package net.wg.gui.components.popovers
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class UnClickableShadowBG extends UIComponentEx
   {
       
      
      public var shadow:MovieClip;
      
      public var hit:MovieClip;
      
      public function UnClickableShadowBG()
      {
         super();
         this.shadow.buttonMode = true;
         this.shadow.hitArea = this.hit;
         this.shadow.tabEnabled = false;
      }
   }
}
