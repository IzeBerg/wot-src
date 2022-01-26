package net.wg.gui.bootcamp.battleResult.containers.tapeReward
{
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.bootcamp.battleResult.containers.base.BaseRenderer;
   import net.wg.gui.bootcamp.containers.AnimatedTextContainer;
   
   public class ValueRenderer extends BaseRenderer
   {
       
      
      public var textContainer:AnimatedTextContainer = null;
      
      public function ValueRenderer()
      {
         super();
      }
      
      override protected function validateData() : void
      {
         this.textContainer.text = data.value;
         super.validateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseEnabled = true;
         mouseChildren = false;
         this.textContainer.autoSize = TextFieldAutoSize.LEFT;
      }
      
      override protected function validateLayout() : void
      {
         super.validateLayout();
         this.textContainer.x = loader.x + loader.width >> 0;
      }
      
      override protected function onDispose() : void
      {
         this.textContainer.dispose();
         this.textContainer = null;
         super.onDispose();
      }
   }
}
