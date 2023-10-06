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
      
      protected var isIconSourceChanged:Boolean;
      
      private var _iconSource:String;
      
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
      
      override protected function draw() : void
      {
         super.draw();
         if(this.isIconSourceChanged && isInvalid(InvalidationType.DATA))
         {
            this.isIconSourceChanged = false;
            this.loader.source = this._iconSource;
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.loader.x = _width - this.loader.width >> 1;
            this.loader.y = _height - this.loader.height >> 1;
         }
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
            invalidateData();
         }
      }
      
      protected function iconLoadingCompleteHandler(param1:UILoaderEvent) : void
      {
         invalidateSize();
      }
   }
}
