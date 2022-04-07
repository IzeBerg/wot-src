package net.wg.gui.lobby.hangar
{
   import flash.events.Event;
   import net.wg.gui.components.containers.inject.GFInjectComponent;
   import scaleform.clik.constants.InvalidationType;
   
   public class RtsBannerWidget extends GFInjectComponent
   {
      
      private static const SMALL_WIDTH:Number = 160;
      
      private static const SMALL_HEIGHT:Number = 112;
      
      private static const BIG_WIDTH:Number = 210;
      
      private static const BIG_HEIGHT:Number = 150;
      
      private static const WIDTH_BREAKPOINT:Number = 1600;
      
      private static const HEIGHT_BREAKPOINT:Number = 900;
      
      private static const MARGIN:Number = 2;
       
      
      public function RtsBannerWidget()
      {
         super();
      }
      
      private static function considerMargin(param1:Number) : Number
      {
         return param1 + MARGIN;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         width = considerMargin(SMALL_WIDTH);
         height = considerMargin(SMALL_HEIGHT);
         App.stage.addEventListener(Event.RESIZE,this.onStageResizeHandler,false,0,true);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = App.appWidth < WIDTH_BREAKPOINT || App.appHeight < HEIGHT_BREAKPOINT;
            width = considerMargin(!!_loc1_ ? Number(SMALL_WIDTH) : Number(BIG_WIDTH));
            height = considerMargin(!!_loc1_ ? Number(SMALL_HEIGHT) : Number(BIG_HEIGHT));
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      override protected function onDispose() : void
      {
         App.stage.removeEventListener(Event.RESIZE,this.onStageResizeHandler);
         super.onDispose();
      }
      
      private function onStageResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
   }
}
