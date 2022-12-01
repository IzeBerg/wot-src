package net.wg.gui.lobby.hangar.quests
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import net.wg.gui.components.containers.GFWrapper;
   import net.wg.infrastructure.base.meta.IFunRandomHangarWidgetMeta;
   import net.wg.infrastructure.base.meta.impl.FunRandomHangarWidgetMeta;
   import scaleform.clik.constants.InvalidationType;
   
   public class FunRandomHangarWidget extends FunRandomHangarWidgetMeta implements IFunRandomHangarWidgetMeta, IHeaderFlagsEntryPoint
   {
      
      private static const SIDE_INDENT:int = 2;
      
      private static const OUTER_MARGIN_X_LEFT:int = -224;
      
      private static const OUTER_MARGIN_X_RIGHT:int = -228;
      
      private static const GLOW_EXTRA_WIDTH:uint = 240;
      
      private static const BASE_WIDTH:uint = 360;
      
      private static const HEIGHT:int = 148;
       
      
      public function FunRandomHangarWidget()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         App.stage.addEventListener(Event.RESIZE,this.onStageResizeHandler);
      }
      
      override protected function onDispose() : void
      {
         App.stage.removeEventListener(Event.RESIZE,this.onStageResizeHandler);
         super.onDispose();
      }
      
      public function get marginRight() : int
      {
         return OUTER_MARGIN_X_RIGHT;
      }
      
      public function get marginLeft() : int
      {
         return OUTER_MARGIN_X_LEFT;
      }
      
      public function get marginTop() : int
      {
         return 0;
      }
      
      public function as_updateHitArea() : void
      {
         invalidateLayout();
      }
      
      public function get hitObject() : DisplayObject
      {
         return Boolean(wrapper) ? GFWrapper(wrapper).inputFixTF : null;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            width = BASE_WIDTH + GLOW_EXTRA_WIDTH + SIDE_INDENT;
            height = HEIGHT;
            x = -(width >> 1);
            dispatchEvent(new Event(Event.RESIZE));
         }
         if(isInvalid(InvalidationType.LAYOUT))
         {
            if(wrapper)
            {
               this.hitObject.width = wrapper.hitArea.width = BASE_WIDTH;
               this.hitObject.height = wrapper.hitArea.height = HEIGHT;
               this.hitObject.x = wrapper.hitArea.x = GLOW_EXTRA_WIDTH + SIDE_INDENT >> 1;
            }
         }
      }
      
      private function onStageResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
   }
}
