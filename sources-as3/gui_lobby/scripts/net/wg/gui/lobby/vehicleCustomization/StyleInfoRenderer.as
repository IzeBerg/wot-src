package net.wg.gui.lobby.vehicleCustomization
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.interfaces.IContentSize;
   import net.wg.gui.lobby.vehicleCustomization.data.styleInfo.ParamRevdererVO;
   import scaleform.clik.controls.ListItemRenderer;
   
   public class StyleInfoRenderer extends ListItemRenderer implements IContentSize
   {
       
      
      public var paramIcon:Image = null;
      
      public var paramText:TextField = null;
      
      public function StyleInfoRenderer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseEnabled = mouseChildren = false;
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         var _loc2_:ParamRevdererVO = ParamRevdererVO(param1);
         this.paramIcon.source = _loc2_.iconSrc;
         this.paramText.autoSize = TextFieldAutoSize.LEFT;
         this.paramText.htmlText = _loc2_.paramText;
         _loc2_.dispose();
      }
      
      public function get contentHeight() : Number
      {
         return this.paramText.y + this.paramText.height;
      }
      
      public function get contentWidth() : Number
      {
         return this.paramText.width;
      }
      
      override protected function onDispose() : void
      {
         this.paramIcon.dispose();
         this.paramIcon = null;
         this.paramText = null;
         super.onDispose();
      }
   }
}
