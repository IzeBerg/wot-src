package net.wg.gui.lobby.eventBoards.components
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.eventBoards.components.interfaces.IMaintenanceComponent;
   import net.wg.infrastructure.base.meta.impl.MaintenanceComponentMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.gfx.MouseEventEx;
   
   public class MaintenanceComponent extends MaintenanceComponentMeta implements IMaintenanceComponent
   {
      
      private static const TEXT_INVALID:String = "textInv";
      
      private static const LABEL_INVALID:String = "labelInv";
      
      private static const INFO1_OFFSET:int = 100;
      
      private static const INFO2_OFFSET:int = 22;
      
      private static const BUTTON_OFFSET:int = 60;
      
      private static const REFRESH_CLICK:String = "refreshClick";
       
      
      public var info1TF:TextField = null;
      
      public var info2TF:TextField = null;
      
      public var refreshBtn:ISoundButtonEx = null;
      
      public var backgroundMc:Sprite = null;
      
      private var _info1:String = "";
      
      private var _info2:String = "";
      
      private var _label:String = "";
      
      public function MaintenanceComponent()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.refreshBtn.addEventListener(ButtonEvent.CLICK,this.onRefreshClickHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.info1TF.x = Math.round(_width - this.info1TF.width >> 1);
            this.info1TF.y = Math.round((_height >> 1) - INFO1_OFFSET);
            this.info2TF.x = Math.round(_width - this.info2TF.width >> 1);
            this.info2TF.y = this.info1TF.y + INFO2_OFFSET;
            this.refreshBtn.x = Math.round(_width - this.refreshBtn.width >> 1);
            this.refreshBtn.y = this.info1TF.y + BUTTON_OFFSET;
            if(this.backgroundMc)
            {
               this.backgroundMc.width = _width;
               this.backgroundMc.height = _height;
            }
         }
         if(isInvalid(TEXT_INVALID))
         {
            this.info1TF.htmlText = this._info1;
            this.info2TF.htmlText = this._info2;
         }
         if(isInvalid(LABEL_INVALID))
         {
            this.refreshBtn.label = this._label;
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         this.refreshBtn.removeEventListener(ButtonEvent.CLICK,this.onRefreshClickHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.info1TF = null;
         this.info2TF = null;
         this.refreshBtn.dispose();
         this.refreshBtn = null;
         this.backgroundMc = null;
         super.onDispose();
      }
      
      public function setMessage(param1:String, param2:String) : void
      {
         this._info1 = param1;
         this._info2 = param2;
         invalidate(TEXT_INVALID);
      }
      
      public function setLabel(param1:String) : void
      {
         this._label = param1;
         invalidate(LABEL_INVALID);
      }
      
      private function onRefreshClickHandler(param1:ButtonEvent) : void
      {
         if(param1.buttonIdx == MouseEventEx.LEFT_BUTTON)
         {
            dispatchEvent(new Event(REFRESH_CLICK,true));
            refreshS();
         }
      }
   }
}
