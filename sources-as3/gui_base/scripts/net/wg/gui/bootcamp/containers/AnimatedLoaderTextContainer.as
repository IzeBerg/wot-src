package net.wg.gui.bootcamp.containers
{
   import net.wg.gui.components.controls.UILoaderAlt;
   
   public class AnimatedLoaderTextContainer extends AnimatedTextContainer
   {
       
      
      public var icon:UILoaderAlt;
      
      public function AnimatedLoaderTextContainer()
      {
         super();
      }
      
      public function get source() : String
      {
         return this.icon.source;
      }
      
      public function set source(param1:String) : void
      {
         this.icon.source = param1;
      }
   }
}
