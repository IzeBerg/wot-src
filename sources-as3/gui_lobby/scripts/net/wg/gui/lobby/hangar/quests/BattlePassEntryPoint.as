package net.wg.gui.lobby.hangar.quests
{
   import flash.events.Event;
   import net.wg.infrastructure.base.meta.IBattlePassEntryPointMeta;
   import net.wg.infrastructure.base.meta.impl.BattlePassEntryPointMeta;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   
   public class BattlePassEntryPoint extends BattlePassEntryPointMeta implements IBattlePassEntryPointMeta
   {
      
      private static const BP_ENTRY_POINT_OUTER_MARGIN_X:int = -56;
      
      private static const BP_ENTRY_POINT_OUTER_MARGIN_SMALL_X:int = -83;
      
      private static const SIZE:int = 256;
       
      
      private var _isSmall:Boolean = false;
      
      public function BattlePassEntryPoint()
      {
         super();
         setManageSize(true);
         setSize(SIZE,SIZE);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         x = -(SIZE >> 1);
         App.stage.addEventListener(Event.RESIZE,this.onStageResizeHandler,false,0,true);
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         setIsSmallS(this._isSmall);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            if(App.stage.stageWidth >= StageSizeBoundaries.WIDTH_1600 && App.stage.stageHeight >= StageSizeBoundaries.HEIGHT_900)
            {
               this.setIsSmallSize(false);
            }
            else
            {
               this.setIsSmallSize(true);
            }
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      override protected function onDispose() : void
      {
         App.stage.removeEventListener(Event.RESIZE,this.onStageResizeHandler);
         super.onDispose();
      }
      
      private function setIsSmallSize(param1:Boolean) : void
      {
         if(this._isSmall != param1)
         {
            this._isSmall = param1;
            if(!isDAAPIInited)
            {
               return;
            }
            setIsSmallS(this._isSmall);
         }
      }
      
      override public function get marginRight() : int
      {
         return !!this._isSmall ? int(BP_ENTRY_POINT_OUTER_MARGIN_SMALL_X) : int(BP_ENTRY_POINT_OUTER_MARGIN_X);
      }
      
      override public function get marginLeft() : int
      {
         return !!this._isSmall ? int(BP_ENTRY_POINT_OUTER_MARGIN_SMALL_X) : int(BP_ENTRY_POINT_OUTER_MARGIN_X);
      }
      
      private function onStageResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
   }
}
