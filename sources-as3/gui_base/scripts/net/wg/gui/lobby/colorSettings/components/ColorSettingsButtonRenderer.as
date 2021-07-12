package net.wg.gui.lobby.colorSettings.components
{
   import flash.text.TextField;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.colorSettings.events.ColorSettingsRendererEvent;
   import net.wg.gui.lobby.colorSettings.vo.ColorSettingsRendererVO;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.ListItemRenderer;
   import scaleform.clik.events.ButtonEvent;
   
   public class ColorSettingsButtonRenderer extends ListItemRenderer
   {
      
      private static const INV_SELECTED:String = "inv_selected";
      
      private static const STATE_NORMAL:String = "normal";
      
      private static const STATE_SELECTED:String = "selected";
      
      private static const STATE_DISABLED:String = "disabled";
       
      
      public var titleTF:TextField = null;
      
      public var icon:UILoaderAlt = null;
      
      protected var buttonData:ColorSettingsRendererVO = null;
      
      public function ColorSettingsButtonRenderer()
      {
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         this.buttonData = ColorSettingsRendererVO(param1);
         invalidateData();
      }
      
      override protected function onBeforeDispose() : void
      {
         removeEventListener(ButtonEvent.CLICK,this.onClickHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.titleTF = null;
         this.icon.dispose();
         this.icon = null;
         this.buttonData.dispose();
         this.buttonData = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseChildren = false;
         buttonMode = true;
         addEventListener(ButtonEvent.CLICK,this.onClickHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this.buttonData && isInvalid(InvalidationType.DATA))
         {
            gotoAndStop(!!enabled ? STATE_NORMAL : STATE_DISABLED);
            this.icon.source = this.buttonData.icon;
            this.titleTF.htmlText = this.buttonData.label;
         }
         if(isInvalid(INV_SELECTED))
         {
            if(_selected)
            {
               gotoAndStop(STATE_SELECTED);
            }
            else
            {
               gotoAndStop(STATE_NORMAL);
            }
         }
      }
      
      protected function clickHandler() : void
      {
         dispatchEvent(new ColorSettingsRendererEvent(ColorSettingsRendererEvent.SETTINGS_TYPE_SELECTED,this.buttonData.id));
      }
      
      override public function set selected(param1:Boolean) : void
      {
         if(_selected == param1)
         {
            return;
         }
         super.selected = param1;
         invalidate(INV_SELECTED);
      }
      
      private function onClickHandler(param1:ButtonEvent) : void
      {
         this.clickHandler();
      }
   }
}
