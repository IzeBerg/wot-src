package net.wg.gui.lobby.questsWindow.components
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.lobby.questsWindow.data.VehicleBonusTextElementVO;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.constants.InvalidationType;
   
   public class VehicleBonusTextElement extends AbstractResizableContent
   {
      
      private static const TEXT_PADDING:int = 5;
       
      
      public var bonusesTf:TextField = null;
      
      private var _data:VehicleBonusTextElementVO = null;
      
      public function VehicleBonusTextElement()
      {
         super();
      }
      
      private static function onBonusesTfRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      override public function setData(param1:Object) : void
      {
         this.tryClearData();
         this._data = new VehicleBonusTextElementVO(param1);
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.addListeners();
      }
      
      override protected function onDispose() : void
      {
         this.removeListeners();
         this.bonusesTf = null;
         this.tryClearData();
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.bonusesTf.width = availableWidth - TEXT_PADDING;
               this.bonusesTf.autoSize = TextFieldAutoSize.LEFT;
               this.bonusesTf.htmlText = this._data.label;
               this.bonusesTf.height = this.bonusesTf.textHeight + TEXT_PADDING;
               invalidate(InvalidationType.SIZE);
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               this.layoutBlocks();
            }
         }
      }
      
      private function tryClearData() : void
      {
         if(this._data != null)
         {
            this._data.dispose();
            this._data = null;
         }
      }
      
      private function layoutBlocks() : void
      {
         var _loc1_:int = Boolean(this._data.label) ? int(this.bonusesTf.height) : int(0);
         setSize(this.width,_loc1_);
         isReadyForLayout = true;
      }
      
      private function removeListeners() : void
      {
         this.bonusesTf.removeEventListener(MouseEvent.ROLL_OUT,onBonusesTfRollOutHandler);
         this.bonusesTf.removeEventListener(MouseEvent.ROLL_OVER,this.onBonusesTfRollOverHandler);
      }
      
      private function addListeners() : void
      {
         this.bonusesTf.addEventListener(MouseEvent.ROLL_OUT,onBonusesTfRollOutHandler);
         this.bonusesTf.addEventListener(MouseEvent.ROLL_OVER,this.onBonusesTfRollOverHandler);
      }
      
      private function onBonusesTfRollOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:ITooltipMgr = null;
         if(this._data != null)
         {
            _loc2_ = App.toolTipMgr;
            if(this._data.tooltip)
            {
               _loc2_.show(this._data.tooltip);
            }
            else
            {
               _loc2_.showSpecial(TOOLTIPS_CONSTANTS.QUESTS_VEHICLE_BONUSES,null,this._data.questID);
            }
         }
      }
   }
}
