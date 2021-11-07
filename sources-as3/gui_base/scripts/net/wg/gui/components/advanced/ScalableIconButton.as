package net.wg.gui.components.advanced
{
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import scaleform.clik.constants.InvalidationType;
   
   public class ScalableIconButton extends SoundButtonEx
   {
       
      
      public var loader:UILoaderAlt;
      
      public var mcLoader:ScalableIconWrapper;
      
      private var _iconSource:String;
      
      protected var isIconSourceChanged:Boolean;
      
      public function ScalableIconButton()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.loader.removeEventListener(UILoaderEvent.COMPLETE,this.iconLoadingCompleteHandler);
         this.loader.dispose();
         this.loader = null;
         if(this.mcLoader)
         {
            this.mcLoader.dispose();
            this.mcLoader = null;
         }
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.loader.addEventListener(UILoaderEvent.COMPLETE,this.iconLoadingCompleteHandler);
      }
      
      protected function iconLoadingCompleteHandler(param1:UILoaderEvent) : void
      {
         invalidate();
         this.loader.x = Math.round((_width - this.loader.width) / 2);
         this.loader.y = Math.round((_height - this.loader.height) / 2);
      }
      
      override protected function draw() : void
      {
         if(this.isIconSourceChanged)
         {
            this.isIconSourceChanged = false;
            this.loader.source = this._iconSource;
            invalidate(InvalidationType.SIZE);
         }
         super.draw();
      }
      
      [Inspectable(name="iconSource",type="String")]
      public function get iconSource() : String
      {
         return this._iconSource;
      }
      
      public function set iconSource(param1:String) : void
      {
         if(this._iconSource != param1)
         {
            this._iconSource = param1;
            this.isIconSourceChanged = true;
            invalidate();
         }
      }
   }
}
