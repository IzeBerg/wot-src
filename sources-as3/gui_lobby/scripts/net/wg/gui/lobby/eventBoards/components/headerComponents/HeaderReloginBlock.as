package net.wg.gui.lobby.eventBoards.components.headerComponents
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.lobby.eventBoards.data.HeaderReloginBlockVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class HeaderReloginBlock extends UIComponentEx
   {
      
      private static const TITLE_OFFSET:int = 23;
      
      private static const INFORMATION_ICON_OFFSET:int = 5;
       
      
      public var title:TextField = null;
      
      public var description:TextField = null;
      
      public var informationIcon:Sprite = null;
      
      private var _data:HeaderReloginBlockVO = null;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function HeaderReloginBlock()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.informationIcon.addEventListener(MouseEvent.ROLL_OVER,this.onDescriptionRollOverHandler);
         this.informationIcon.addEventListener(MouseEvent.ROLL_OUT,this.onDescriptionRollOutHandler);
         this.informationIcon.visible = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            this.title.htmlText = this._data.title;
            this.description.visible = StringUtils.isNotEmpty(this._data.description);
            if(this.description.visible)
            {
               this.description.htmlText = this._data.description;
            }
            else
            {
               this.title.y = TITLE_OFFSET;
            }
            this.informationIcon.visible = StringUtils.isNotEmpty(this._data.descriptionTooltip);
            if(this.informationIcon.visible)
            {
               this.informationIcon.x = this.description.x + (this.description.textWidth + this.description.width >> 1) + INFORMATION_ICON_OFFSET;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.title = null;
         this.description = null;
         this.informationIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onDescriptionRollOverHandler);
         this.informationIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onDescriptionRollOutHandler);
         this.informationIcon = null;
         this._data = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      public function setData(param1:Object) : void
      {
         if(this._data != param1)
         {
            this._data = HeaderReloginBlockVO(param1);
            invalidateData();
         }
      }
      
      private function onDescriptionRollOverHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.showComplex(this._data.descriptionTooltip);
      }
      
      private function onDescriptionRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
   }
}
