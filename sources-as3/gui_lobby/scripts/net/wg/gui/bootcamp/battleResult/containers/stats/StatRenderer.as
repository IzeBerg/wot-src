package net.wg.gui.bootcamp.battleResult.containers.stats
{
   import flash.display.MovieClip;
   import net.wg.gui.bootcamp.battleResult.containers.base.BaseRenderer;
   import net.wg.gui.bootcamp.containers.AnimatedTextContainer;
   
   public class StatRenderer extends BaseRenderer
   {
       
      
      public var wrath:MovieClip = null;
      
      public var value:AnimatedTextContainer = null;
      
      public var description:AnimatedTextContainer = null;
      
      public function StatRenderer()
      {
         super();
      }
      
      override protected function validateData() : void
      {
         this.value.text = data.value;
         this.description.text = data.label;
         this.wrath.gotoAndStop(data.finishReason);
         super.validateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseEnabled = true;
         mouseChildren = false;
      }
      
      override protected function onDispose() : void
      {
         this.wrath = null;
         this.value.dispose();
         this.value = null;
         this.description.dispose();
         this.description = null;
         super.onDispose();
      }
   }
}
