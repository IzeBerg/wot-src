package net.wg.gui.components.controls
{
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class AnimationIcon extends Sprite implements IDisposable
   {
       
      
      public var icon:UILoaderAlt = null;
      
      public function AnimationIcon()
      {
         super();
      }
      
      public function dispose() : void
      {
         this.icon.dispose();
         this.icon = null;
      }
      
      public function setImage(param1:String) : void
      {
         this.icon.source = param1;
      }
   }
}
