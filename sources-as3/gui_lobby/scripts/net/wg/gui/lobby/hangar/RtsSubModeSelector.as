package net.wg.gui.lobby.hangar
{
   import flash.events.Event;
   import net.wg.gui.components.containers.inject.GFInjectComponent;
   import net.wg.gui.lobby.hangar.quests.IHeaderFlagsEntryPoint;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   
   public class RtsSubModeSelector extends GFInjectComponent implements IHeaderFlagsEntryPoint
   {
      
      private static const NORMAL_WIDTH:Number = 880;
      
      private static const NORMAL_HEIGHT:Number = 100;
      
      private static const SMALL_WIDTH:Number = 680;
      
      private static const SMALL_HEIGHT:Number = 95;
      
      private static const WIDTH_BREAKPOINT:Number = StageSizeBoundaries.WIDTH_1366;
       
      
      public function RtsSubModeSelector()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         width = NORMAL_WIDTH;
         height = NORMAL_HEIGHT;
         App.stage.addEventListener(Event.RESIZE,this.onStageResizeHandler,false,0,true);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = App.appWidth < WIDTH_BREAKPOINT;
            width = !!_loc1_ ? Number(SMALL_WIDTH) : Number(NORMAL_WIDTH);
            height = !!_loc1_ ? Number(SMALL_HEIGHT) : Number(NORMAL_HEIGHT);
            x = -(width >> 1);
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      override protected function onDispose() : void
      {
         App.stage.removeEventListener(Event.RESIZE,this.onStageResizeHandler);
         super.onDispose();
      }
      
      public function get marginRight() : int
      {
         return 0;
      }
      
      public function get marginLeft() : int
      {
         return 0;
      }
      
      public function get marginTop() : int
      {
         return 0;
      }
      
      private function onStageResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
   }
}
