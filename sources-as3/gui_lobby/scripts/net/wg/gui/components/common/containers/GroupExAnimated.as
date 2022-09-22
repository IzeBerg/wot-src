package net.wg.gui.components.common.containers
{
   import flash.display.DisplayObject;
   import net.wg.gui.components.containers.GroupEx;
   import net.wg.gui.components.interfaces.IListItemAnimatedRenderer;
   import net.wg.gui.events.AnimatedRendererEvent;
   
   public class GroupExAnimated extends GroupEx
   {
       
      
      public function GroupExAnimated()
      {
         super();
         addEventListener(AnimatedRendererEvent.RENERER_ANIMATION_FINISHED,this.onRenererAnimationFinishedHandler);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(AnimatedRendererEvent.RENERER_ANIMATION_FINISHED,this.onRenererAnimationFinishedHandler);
         super.onDispose();
      }
      
      public function playEndAnimation() : void
      {
         var _loc2_:DisplayObject = null;
         var _loc1_:int = renderers.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = renderers[_loc3_];
            if(_loc2_ is IListItemAnimatedRenderer)
            {
               IListItemAnimatedRenderer(_loc2_).playEndAnimation();
            }
            _loc3_++;
         }
      }
      
      private function onRenererAnimationFinishedHandler(param1:AnimatedRendererEvent) : void
      {
         var _loc2_:int = renderers.length - 1;
         if(param1.index == _loc2_)
         {
            dispatchEvent(new AnimatedRendererEvent(AnimatedRendererEvent.ANIMATION_FINISHED,_loc2_,true));
         }
      }
   }
}
