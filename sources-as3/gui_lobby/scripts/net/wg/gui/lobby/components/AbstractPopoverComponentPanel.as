package net.wg.gui.lobby.components
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.gui.components.assets.data.SeparatorConstants;
   import net.wg.gui.components.assets.interfaces.ISeparatorAsset;
   import net.wg.gui.components.controls.CloseButtonText;
   import net.wg.gui.lobby.components.interfaces.IMissionDetailsPopUpPanel;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.gfx.TextFieldEx;
   
   public class AbstractPopoverComponentPanel extends UIComponentEx implements IMissionDetailsPopUpPanel
   {
      
      protected static const OVERRIDE_EXCEPTION_MESSAGE:String = "This method should be overriden";
       
      
      public var bg:MovieClip;
      
      public var body:MovieClip;
      
      public var labelTf:TextField;
      
      public var separator:ISeparatorAsset = null;
      
      public var btnClose:CloseButtonText;
      
      protected var vo:IDAAPIDataClass;
      
      public function AbstractPopoverComponentPanel()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.bg = null;
         this.body = null;
         this.labelTf = null;
         this.vo = null;
         if(this.separator != null)
         {
            this.separator.dispose();
            this.separator = null;
         }
         if(this.btnClose != null)
         {
            this.btnClose.removeEventListener(ButtonEvent.CLICK,this.onBtnCloseClickHandler);
            this.btnClose.dispose();
            this.btnClose = null;
         }
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this.separator)
         {
            this.separator.setType(SeparatorConstants.MEDIUM_TYPE);
         }
         this.labelTf.mouseEnabled = false;
         if(this.btnClose != null)
         {
            this.btnClose.visibleText = false;
            this.btnClose.addEventListener(ButtonEvent.CLICK,this.onBtnCloseClickHandler);
         }
         TextFieldEx.setVerticalAlign(this.labelTf,TextFieldEx.VALIGN_CENTER);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this.vo != null && isInvalid(InvalidationType.DATA))
         {
            this.labelTf.text = this.header;
            App.utils.commons.truncateTextFieldText(this.labelTf,this.labelTf.text);
         }
      }
      
      public function setData(param1:IDAAPIDataClass) : void
      {
         this.vo = param1;
         visible = this.vo != null;
         invalidateData();
      }
      
      protected function get header() : String
      {
         throw new AbstractException(OVERRIDE_EXCEPTION_MESSAGE);
      }
      
      private function onBtnCloseClickHandler(param1:ButtonEvent) : void
      {
         visible = false;
         dispatchEvent(new Event(Event.CLOSE));
      }
   }
}
