package net.wg.gui.battle.eventBattle.views.buffsPanel
{
   import fl.motion.easing.Cubic;
   import flash.display.Sprite;
   import net.wg.data.constants.InvalidationType;
   import net.wg.infrastructure.base.meta.IEventBuffsPanelMeta;
   import net.wg.infrastructure.base.meta.impl.EventBuffsPanelMeta;
   import scaleform.clik.motion.Tween;
   
   public class BuffsPanel extends EventBuffsPanelMeta implements IEventBuffsPanelMeta
   {
      
      private static const INVALIDATE_DRAW_LAYOUT:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 6;
      
      private static const EVENT_BUFF_BUTTON_LINKAGE:String = "EventBuffButtonUI";
      
      private static const ITEM_WIDTH_PADDING:int = 67;
      
      private static const ITEM_WIDTH:int = 58;
      
      private static const ANIMATION_DURATION:int = 200;
       
      
      public var panel:Sprite = null;
      
      private var _renderers:Vector.<EventBuffButton>;
      
      private var _tween:Tween = null;
      
      public function BuffsPanel()
      {
         this._renderers = new Vector.<EventBuffButton>();
         super();
      }
      
      public function as_addBuffSlot(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:EventBuffButton = this.getBuffById(param1);
         if(_loc4_)
         {
            _loc4_.visible = true;
         }
         else
         {
            _loc4_ = this.createEquipmentButton();
            this.panel.addChild(_loc4_);
            _loc4_.icon = param2;
            _loc4_.tooltipStr = param3;
            _loc4_.id = param1;
            this._renderers.push(_loc4_);
         }
         invalidate(INVALIDATE_DRAW_LAYOUT);
      }
      
      public function as_removeBuffSlot(param1:String) : void
      {
         var _loc3_:int = 0;
         var _loc2_:EventBuffButton = this.getBuffById(param1);
         if(_loc2_)
         {
            this.panel.removeChild(_loc2_);
            _loc2_.dispose();
            _loc3_ = this._renderers.indexOf(_loc2_);
            this._renderers.splice(_loc3_,1);
         }
         invalidate(INVALIDATE_DRAW_LAYOUT);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALIDATE_DRAW_LAYOUT))
         {
            this.drawLayout();
         }
      }
      
      private function disposeRenderers() : void
      {
         var _loc1_:EventBuffButton = null;
         for each(_loc1_ in this._renderers)
         {
            this.panel.removeChild(_loc1_);
            _loc1_.dispose();
         }
         this._renderers.splice(0,this._renderers.length);
         this._renderers = null;
      }
      
      private function removeTween() : void
      {
         if(this._tween != null)
         {
            this._tween.dispose();
            this._tween = null;
         }
      }
      
      override protected function onDispose() : void
      {
         this.disposeRenderers();
         this.removeTween();
         this.panel = null;
         super.onDispose();
      }
      
      private function createEquipmentButton() : EventBuffButton
      {
         return App.utils.classFactory.getComponent(EVENT_BUFF_BUTTON_LINKAGE,EventBuffButton);
      }
      
      private function drawLayout() : void
      {
         var _loc3_:EventBuffButton = null;
         var _loc1_:int = this._renderers.length;
         if(_loc1_ >= 1)
         {
            this.removeTween();
            this._tween = new Tween(ANIMATION_DURATION,this.panel,{"x":Math.round(-ITEM_WIDTH_PADDING * (_loc1_ - 1) >> 1)},{
               "fastTransform":false,
               "ease":Cubic.easeInOut
            });
         }
         var _loc2_:int = 0;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc1_)
         {
            _loc3_ = this._renderers[_loc4_];
            if(_loc3_ && _loc3_.visible)
            {
               _loc3_.x = Math.round(_loc2_ - (ITEM_WIDTH >> 1));
               _loc2_ += ITEM_WIDTH_PADDING;
            }
            _loc4_++;
         }
      }
      
      private function getBuffById(param1:String) : EventBuffButton
      {
         var _loc3_:EventBuffButton = null;
         var _loc2_:int = this._renderers.length;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = this._renderers[_loc4_];
            if(_loc3_.id == param1)
            {
               return _loc3_;
            }
            _loc4_++;
         }
         return null;
      }
   }
}
