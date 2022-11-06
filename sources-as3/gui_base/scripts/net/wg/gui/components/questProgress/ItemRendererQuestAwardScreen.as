package net.wg.gui.components.questProgress
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.components.questProgress.interfaces.data.IQPInitData;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class ItemRendererQuestAwardScreen extends ItemRenderer
   {
       
      
      public var title:TextField = null;
      
      private var _tooltip:String = null;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function ItemRendererQuestAwardScreen()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
      }
      
      override public function init(param1:IQPInitData) : void
      {
         super.init(param1);
         this._tooltip = param1.tooltip;
         this.title.htmlText = param1.title;
         App.utils.commons.updateTextFieldSize(this.title,false,true);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.title = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         if(StringUtils.isNotEmpty(this._tooltip))
         {
            this._toolTipMgr.showComplex(this._tooltip);
         }
      }
   }
}
