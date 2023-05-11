package net.wg.gui.lobby.questsWindow.components
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.generated.TEXT_ALIGN;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   
   public class QuestBigIconAwardItem extends UIComponentEx
   {
      
      private static const ICONS_OFFSET:int = 15;
      
      private static const ICONS_OFFSET_Y:int = 2;
       
      
      public var icon:UILoaderAlt;
      
      public var labelTf:TextField;
      
      private var _data:Object;
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _gap:int = 0;
      
      public function QuestBigIconAwardItem()
      {
         super();
         this._toolTipMgr = App.toolTipMgr;
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
      }
      
      public function populateData(param1:Object) : void
      {
         this.icon.source = param1.imgSource;
         this.labelTf.htmlText = param1.label;
         this._data = param1;
         this._gap = this._data.gap;
         this.updateTextFieldLayout();
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         if(this.icon)
         {
            this.icon.dispose();
            this.icon = null;
         }
         this.labelTf = null;
         this._data = null;
         this._toolTipMgr.hide();
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         this.updateTextFieldLayout();
      }
      
      private function updateTextFieldLayout() : void
      {
         if(this._data.align == TEXT_ALIGN.RIGHT)
         {
            this.labelTf.x = this.icon.x + this.icon.width - ICONS_OFFSET;
         }
         else if(this._data.align == TEXT_ALIGN.LEFT)
         {
            this.labelTf.x = this.icon.x - this.labelTf.width + ICONS_OFFSET ^ 0;
         }
         else
         {
            this.labelTf.x = this.icon.x + (this.icon.width - this.labelTf.width >> 1) ^ 0;
         }
         this.labelTf.y = this.icon.y + this.icon.height - this.labelTf.textHeight + this._gap + ICONS_OFFSET_Y ^ 0;
      }
      
      private function showToolTip() : void
      {
         this._toolTipMgr.showSpecial.apply(this._toolTipMgr,[this._data.specialAlias,null].concat(this._data.specialArgs));
      }
      
      private function onMouseOverHandler(param1:MouseEvent) : void
      {
         this.showToolTip();
      }
      
      private function onMouseOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
   }
}
