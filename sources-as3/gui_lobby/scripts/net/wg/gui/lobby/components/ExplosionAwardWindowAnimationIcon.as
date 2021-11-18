package net.wg.gui.lobby.components
{
   import net.wg.gui.components.controls.AnimationIcon;
   import net.wg.gui.events.UILoaderEvent;
   
   public class ExplosionAwardWindowAnimationIcon extends AnimationIcon
   {
       
      
      public function ExplosionAwardWindowAnimationIcon()
      {
         super();
         icon.addEventListener(UILoaderEvent.COMPLETE,this.onIconLoadCompleteHandler);
      }
      
      override public function dispose() : void
      {
         icon.removeEventListener(UILoaderEvent.COMPLETE,this.onIconLoadCompleteHandler);
         super.dispose();
      }
      
      private function onIconLoadCompleteHandler(param1:UILoaderEvent) : void
      {
         icon.x = -icon.width >> 1;
         icon.y = -icon.height >> 1;
      }
   }
}
