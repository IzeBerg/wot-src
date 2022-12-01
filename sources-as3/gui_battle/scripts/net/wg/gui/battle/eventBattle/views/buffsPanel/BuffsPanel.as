package net.wg.gui.battle.eventBattle.views.buffsPanel
{
   import net.wg.data.constants.InvalidationType;
   import net.wg.infrastructure.base.meta.IEventBuffsPanelMeta;
   import net.wg.infrastructure.base.meta.impl.EventBuffsPanelMeta;
   
   public class BuffsPanel extends EventBuffsPanelMeta implements IEventBuffsPanelMeta
   {
      
      private static const INVALIDATE_DRAW_LAYOUT:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 6;
      
      private static const EVENT_BUFF_BUTTON_LINKAGE:String = "EventBuffButtonUI";
      
      private static const ITEM_WIDTH_PADDING:int = 40;
       
      
      protected var renderers:Vector.<EventBuffButton>;
      
      public function BuffsPanel()
      {
         this.renderers = new Vector.<EventBuffButton>();
         super();
      }
      
      public function as_addBuffSlot(param1:uint, param2:String, param3:String) : void
      {
         var _loc4_:EventBuffButton = App.utils.classFactory.getComponent(EVENT_BUFF_BUTTON_LINKAGE,EventBuffButton);
         addChild(_loc4_);
         _loc4_.icon = param2;
         _loc4_.tooltipStr = param3;
         this.renderers.push(_loc4_);
         invalidate(INVALIDATE_DRAW_LAYOUT);
      }
      
      public function as_removeBuffSlot(param1:uint) : void
      {
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALIDATE_DRAW_LAYOUT))
         {
            this.drawLayout();
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:EventBuffButton = null;
         for each(_loc1_ in this.renderers)
         {
            _loc1_.dispose();
         }
         this.renderers.splice(0,this.renderers.length);
         this.renderers = null;
         super.onDispose();
      }
      
      private function drawLayout() : void
      {
         var _loc3_:EventBuffButton = null;
         var _loc1_:int = this.renderers.length;
         var _loc2_:int = -ITEM_WIDTH_PADDING * _loc1_ >> 1;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc1_)
         {
            _loc3_ = this.renderers[_loc4_];
            if(_loc3_ && _loc3_.visible)
            {
               _loc3_.x = _loc2_;
               _loc2_ += ITEM_WIDTH_PADDING;
            }
            _loc4_++;
         }
      }
   }
}
