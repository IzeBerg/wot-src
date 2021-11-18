package net.wg.gui.lobby.manualChapter.controls
{
   import flash.display.Sprite;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class ManualBackgroundContainer extends Sprite implements IDisposable
   {
       
      
      public var image:UILoaderAlt;
      
      public var background:UILoaderAlt;
      
      public function ManualBackgroundContainer()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.image.dispose();
         this.image = null;
         this.background.dispose();
         this.background = null;
      }
      
      public function get imageSource() : String
      {
         return this.image.source;
      }
      
      public function set imageSource(param1:String) : void
      {
         this.image.source = param1;
      }
      
      public function get backgroundSource() : String
      {
         return this.background.source;
      }
      
      public function set backgroundSource(param1:String) : void
      {
         this.background.source = param1;
      }
   }
}
