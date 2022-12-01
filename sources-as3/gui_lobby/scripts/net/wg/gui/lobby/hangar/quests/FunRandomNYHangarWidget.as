package net.wg.gui.lobby.hangar.quests
{
   import flash.display.DisplayObject;
   import net.wg.gui.components.containers.GFWrapper;
   import net.wg.infrastructure.base.meta.IFunRandomHangarWidgetMeta;
   import net.wg.infrastructure.base.meta.impl.FunRandomNYHangarWidgetMeta;
   import net.wg.utils.IStageSizeDependComponent;
   import scaleform.clik.constants.InvalidationType;
   
   public class FunRandomNYHangarWidget extends FunRandomNYHangarWidgetMeta implements IFunRandomHangarWidgetMeta, IStageSizeDependComponent
   {
      
      private static const SIDE_INDENT:int = 2;
      
      private static const OUTER_MARGIN_X:int = 3;
      
      private static const OUTER_MARGIN_Y:int = 49;
      
      private static const OUTER_SMALL_MARGIN_Y:int = 40;
      
      private static const BASE_WIDTH:uint = 346;
      
      private static const HEIGHT:int = 146;
      
      private static const STAGE_HEIGHT_SMALL:int = 900;
      
      private static const STAGE_WIDTH_SMALL:int = 1600;
       
      
      private var _stageWidth:int;
      
      private var _stageHeight:int;
      
      private var _offset:int;
      
      public function FunRandomNYHangarWidget()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         App.stageSizeMgr.register(this);
         width = BASE_WIDTH + SIDE_INDENT;
         height = HEIGHT + SIDE_INDENT;
         x = OUTER_MARGIN_X;
      }
      
      override protected function onDispose() : void
      {
         App.stageSizeMgr.unregister(this);
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.LAYOUT))
         {
            if(wrapper)
            {
               this.hitObject.width = wrapper.hitArea.width = BASE_WIDTH;
               this.hitObject.height = wrapper.hitArea.height = HEIGHT;
               this.hitObject.x = wrapper.hitArea.x = SIDE_INDENT >> 1;
               this.hitObject.y = wrapper.hitArea.y = SIDE_INDENT >> 1;
            }
         }
      }
      
      public function as_updateHitArea() : void
      {
         invalidateLayout();
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         if(this._stageHeight != param2 || this._stageWidth != param1)
         {
            this._stageHeight = param2;
            this._stageWidth = param1;
            this.updateY();
         }
      }
      
      public function updatePosition(param1:int) : void
      {
         if(this._offset != param1 && param1 > 0)
         {
            this._offset = param1;
            this.updateY();
         }
      }
      
      private function updateY() : void
      {
         var _loc1_:Boolean = this._stageHeight < STAGE_HEIGHT_SMALL || this._stageWidth < STAGE_WIDTH_SMALL;
         if(_loc1_)
         {
            y = this._offset + OUTER_SMALL_MARGIN_Y;
         }
         else
         {
            y = this._offset - OUTER_MARGIN_Y;
         }
      }
      
      public function get hitObject() : DisplayObject
      {
         return Boolean(wrapper) ? GFWrapper(wrapper).inputFixTF : null;
      }
   }
}
