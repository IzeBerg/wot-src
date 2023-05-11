package net.wg.gui.lobby.clans.profile.renderers
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.lobby.clans.profile.VOs.ClanProfileSelfProvinceVO;
   import scaleform.clik.constants.InvalidationType;
   
   public class ClanProfileSelfProvinceItemRenderer extends ClanProfileProvinceItemRenderer
   {
       
      
      public var income:TextField = null;
      
      public var noIncomeIcon:Sprite = null;
      
      private var _provinceVO:ClanProfileSelfProvinceVO = null;
      
      public function ClanProfileSelfProvinceItemRenderer()
      {
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         this._provinceVO = ClanProfileSelfProvinceVO(param1);
         super.setData(param1);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA) && this._provinceVO)
         {
            this.income.htmlText = this._provinceVO.income;
            this.noIncomeIcon.visible = this._provinceVO.noIncomeIconVisible;
            if(this.noIncomeIcon.visible)
            {
               this.noIncomeIcon.x = this.income.x - this.noIncomeIcon.width >> 0;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.noIncomeIcon.removeEventListener(MouseEvent.MOUSE_OVER,this.onNoIncomeIconMouseOverHandler);
         this.noIncomeIcon.removeEventListener(MouseEvent.MOUSE_OUT,this.onNoIncomeIconMouseOutHandler);
         this.noIncomeIcon = null;
         this.income = null;
         this._provinceVO = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.income.autoSize = TextFieldAutoSize.RIGHT;
         this.noIncomeIcon.visible = false;
         this.noIncomeIcon.mouseEnabled = true;
         this.noIncomeIcon.addEventListener(MouseEvent.MOUSE_OVER,this.onNoIncomeIconMouseOverHandler);
         this.noIncomeIcon.addEventListener(MouseEvent.MOUSE_OUT,this.onNoIncomeIconMouseOutHandler);
      }
      
      private function onNoIncomeIconMouseOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onNoIncomeIconMouseOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.showComplex(this._provinceVO.noIncomeTooltip);
      }
   }
}
