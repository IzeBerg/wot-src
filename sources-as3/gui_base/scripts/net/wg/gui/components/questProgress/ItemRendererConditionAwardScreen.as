package net.wg.gui.components.questProgress
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.questProgress.data.HeaderProgressConditionVO;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.constants.InvalidationType;
   
   public class ItemRendererConditionAwardScreen extends UIComponentEx implements IUpdatable
   {
       
      
      public var icon:UILoaderAlt;
      
      private var _data:HeaderProgressConditionVO = null;
      
      private var _toolTip:String = null;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function ItemRendererConditionAwardScreen()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.mouseChildren = false;
         this.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.icon.addEventListener(UILoaderEvent.COMPLETE,this.onIconLoadCompleteHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.icon.source = this._data.icon;
            this._toolTip = this._data.tooltip;
         }
         if(isInvalid(InvalidationType.LAYOUT))
         {
            this.icon.x = this.width - this.icon.width >> 1;
            this.icon.y = this.height - this.icon.height >> 1;
         }
      }
      
      override protected function onDispose() : void
      {
         this.icon.removeEventListener(UILoaderEvent.COMPLETE,this.onIconLoadCompleteHandler);
         this.icon.dispose();
         this.icon = null;
         this.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this._toolTipMgr = null;
         this._data = null;
         super.onDispose();
      }
      
      public function update(param1:Object) : void
      {
         this._data = param1 as HeaderProgressConditionVO;
         invalidateData();
      }
      
      override public function get width() : Number
      {
         return hitArea.width;
      }
      
      override public function get height() : Number
      {
         return hitArea.height;
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         if(this._toolTip)
         {
            this._toolTipMgr.showComplex(this._toolTip);
         }
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onIconLoadCompleteHandler(param1:Event) : void
      {
         invalidateLayout();
      }
   }
}
