package net.wg.gui.lobby.questsWindow.components
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.lobby.questsWindow.data.CustomizationQuestBonusVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.constants.InvalidationType;
   
   public class CustomizationItemRenderer extends UIComponentEx
   {
       
      
      public var bonusesTf:TextField;
      
      private var _data:CustomizationQuestBonusVO;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function CustomizationItemRenderer()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._toolTipMgr = App.toolTipMgr;
         this.bonusesTf.autoSize = TextFieldAutoSize.LEFT;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.ROLL_OVER,this.onLoaderRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onLoaderRollOutHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            this.bonusesTf.htmlText = this._data.description;
            App.utils.commons.updateTextFieldSize(this.bonusesTf,true,true);
         }
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onLoaderRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onLoaderRollOutHandler);
         this.bonusesTf = null;
         this._data = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      override public function get height() : Number
      {
         return this.bonusesTf.textHeight;
      }
      
      public function set data(param1:Object) : void
      {
         if(this._data != param1)
         {
            this._data = new CustomizationQuestBonusVO(param1);
            invalidateData();
         }
      }
      
      private function onLoaderRollOverHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.TECH_CUSTOMIZATION_ITEM,null,this._data.intCD,this._data.vehicleIntCD);
      }
      
      private function onLoaderRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
   }
}
