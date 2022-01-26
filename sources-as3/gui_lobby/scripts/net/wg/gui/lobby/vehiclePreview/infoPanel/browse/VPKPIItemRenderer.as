package net.wg.gui.lobby.vehiclePreview.infoPanel.browse
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class VPKPIItemRenderer extends UIComponentEx
   {
      
      private static const TITLE_OFFSET:int = 10;
       
      
      public var icon:Image;
      
      public var title:TextField;
      
      private var _data:Object;
      
      public function VPKPIItemRenderer()
      {
         super();
      }
      
      public function setData(param1:Object) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseEnabled = mouseChildren = false;
         visible = false;
         this.title.autoSize = TextFieldAutoSize.LEFT;
         this.title.wordWrap = true;
         this.title.multiline = true;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.icon.source = this._data.icon;
            this.title.htmlText = this._data.title;
            visible = true;
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.title.width = width - TITLE_OFFSET;
            height = this.title.y + this.title.height;
         }
      }
      
      override protected function onDispose() : void
      {
         this.icon.dispose();
         this.icon = null;
         this.title = null;
         super.onDispose();
      }
   }
}
